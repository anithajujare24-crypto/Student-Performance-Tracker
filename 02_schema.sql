-- ================================================================
-- Script Name   : schema.sql
-- Project       : Student Performance Tracker
-- Author        : J. Anitha
-- Purpose       : Defines database schema (tables and relationships)
-- ================================================================

--
-- ================================================================
-- Table : student
-- Stores basic details of each student
-- ================================================================

CREATE TABLE student (
    student_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,-- Unique identifier for each student (auto-incremented)
    name VARCHAR2(50),
    class VARCHAR2(10),
    email VARCHAR2(100)
);

--
-- ==================================================================
-- Table : Subject
-- Holds all subjects details
-- ==================================================================

CREATE TABLE subject (
    subject_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,-- Unique ID for each subject
    subject_name VARCHAR2(50),
    max_marks NUMBER(3)
);

--
-- ===================================================================
-- Table : marks
-- Holds marks obtained by each student in each subject
-- ===================================================================

CREATE TABLE marks (
    student_id NUMBER REFERENCES student(student_id),-- Ensures mark record belongs to a valid student
    subject_id NUMBER REFERENCES subject(subject_id),-- Ensures mark record belongs to a valid subject
    marks_obtained NUMBER(3),
    PRIMARY KEY(student_id, subject_id)
);

--
-- ====================================================================
-- Table : result
-- Stores calculated results for each student
-- ====================================================================

CREATE TABLE result (
    student_id NUMBER PRIMARY KEY REFERENCES student(student_id),-- One result record per student
    total_marks NUMBER(5),
    percentage NUMBER(5,2),
    grade CHAR(1)
);
commit;
