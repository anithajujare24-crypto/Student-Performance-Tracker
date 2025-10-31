-- ================================================================
-- Script Name   : procedure_calculate_results.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Defines PL/SQL procedure to calculate total marks,
--                 percentage, and grade for each student.
-- ================================================================
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE calculate_results AS
    v_student_id   NUMBER;
    v_total_marks  NUMBER;  -- actual student marks
    v_max_total    NUMBER;  -- total max marks
    v_percentage   NUMBER(6,2);
    v_grade        CHAR(1);
BEGIN
    FOR rec IN (SELECT student_id FROM student) LOOP
        v_student_id := rec.student_id;

        -- total marks obtained by student
        SELECT NVL(SUM(m.marks_obtained), 0)
        INTO v_total_marks
        FROM marks m
        WHERE m.student_id = v_student_id;

        -- total maximum marks possible (based on subjects taken)
        SELECT NVL(SUM(s.max_marks), 0)
        INTO v_max_total
        FROM subject s
        WHERE s.subject_id IN (SELECT subject_id FROM marks WHERE student_id = v_student_id);

        -- avoid division by zero
        IF v_max_total = 0 THEN
            v_percentage := 0;
        ELSE
            v_percentage := ROUND((v_total_marks / v_max_total) * 100, 2);
        END IF;

        -- grading logic
        IF v_percentage >= 90 THEN
            v_grade := 'A';
        ELSIF v_percentage >= 75 THEN
            v_grade := 'B';
        ELSIF v_percentage >= 60 THEN
            v_grade := 'C';
        ELSE
            v_grade := 'D';
        END IF;

        -- merge into result table
        MERGE INTO result r
        USING (SELECT v_student_id AS student_id FROM dual) s
        ON (r.student_id = s.student_id)
        WHEN MATCHED THEN
            UPDATE SET total_marks = v_total_marks,
                       percentage  = v_percentage,
                       grade       = v_grade
        WHEN NOT MATCHED THEN
            INSERT (student_id, total_marks, percentage, grade)
            VALUES (v_student_id, v_total_marks, v_percentage, v_grade);

        -- print for debugging
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id ||
                             ' | Total: ' || v_total_marks ||
                             ' | Max: ' || v_max_total ||
                             ' | %: ' || v_percentage ||
                             ' | Grade: ' || v_grade);
    END LOOP;
    COMMIT;
END;
/
