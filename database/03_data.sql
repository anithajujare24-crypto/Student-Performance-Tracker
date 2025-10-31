-- ================================================================
-- Script Name   : data.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Inserts sample data into tables
-- ================================================================
INSERT INTO student(name, class, email) VALUES ('Amit Sharma', '10A', 'amit@gmail.com');
INSERT INTO student(name, class, email) VALUES ('Priya Rao', '10A', 'priya@gmail.com');

INSERT INTO subject(subject_name, max_marks) VALUES ('Math', 100);
INSERT INTO subject(subject_name, max_marks) VALUES ('Science', 100);

INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (1, 1, 95);
INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (1, 2, 90);
INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (2, 1, 85);
INSERT INTO marks(student_id, subject_id, marks_obtained) VALUES (2, 2, 80);
