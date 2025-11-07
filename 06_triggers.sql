-- ================================================================
-- Script Name   : trigger_auto_calculate.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Creates a trigger that auto-runs the result
--                 calculation procedure when marks are updated.
-- ================================================================
CREATE OR REPLACE TRIGGER trg_calc_result
-- Trigger fires after any new marks are inserted or existing marks are updated
AFTER INSERT OR UPDATE ON marks
-- Runs once for each affected row 
FOR EACH ROW
BEGIN
    -- Calling the stored procedure to recalculate total marks, percentage, and grade
    -- Ensures automatic consistency between marks and results
    calculate_results;
END;
/    
--
-- Inserted a record to verify the trigger executes automatically
INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (1, 1, 70);
-- Verifes that the result table reflects updated totals
select * from result;
commit;