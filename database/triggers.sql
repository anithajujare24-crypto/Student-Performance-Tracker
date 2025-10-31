-- ================================================================
-- Script Name   : trigger_auto_calculate.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Creates a trigger that auto-runs the result
--                 calculation procedure when marks are updated.
-- ================================================================
CREATE OR REPLACE TRIGGER trg_calc_result
AFTER INSERT OR UPDATE ON marks
FOR EACH ROW
BEGIN
    calculate_results;
END;
/    
--
INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (1, 1, 70);
select * from result;