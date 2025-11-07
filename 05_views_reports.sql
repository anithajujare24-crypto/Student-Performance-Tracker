-- ================================================================
-- Script Name   : views_reports.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Creates analytical views for top scorers and
--                 class performance summary.
-- ================================================================
-- Top 3 scorers
-- ================================================================
-- Fetches top n students across all classes by percentage
-- Used fetch first x rows only to limit; 3 is example
-- ================================================================

CREATE OR REPLACE VIEW top_scorers AS
SELECT s.name, r.percentage, r.grade
FROM student s
JOIN result r ON s.student_id = r.student_id
ORDER BY r.percentage DESC
FETCH FIRST 3 ROWS ONLY;

-- Class performance summary
-- ================================================================
-- shows number of students per class and average percentage
-- Useful for quick class-level reporting
-- ================================================================

CREATE OR REPLACE VIEW class_summary AS
SELECT s.class, COUNT(s.student_id) AS total_students,
       AVG(r.percentage) AS avg_percentage
FROM student s JOIN result r ON s.student_id = r.student_id
GROUP BY s.class;
commit;
