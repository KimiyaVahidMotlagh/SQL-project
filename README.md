# University Course Management SQL Project


### Overview
This project implements a university course management system using SQL Server. It includes data modeling, table creation, sample data insertion, views, and basic user management to simulate interactions between students and professors.

### Features
Entity Modeling:
- Professors (Ostad)
- Students (Danshgo)
- Courses (Darse)
- Student-course enrollments (DaneshjODarse)

### Data Operations:
- Insertion of sample data for students, professors, and courses
- Student-course enrollments
- Join, Group By, and Subquery examples
- Transaction handling

### Views:
- ProfessorCoursesView: Displays professors with their courses and student counts
- StudentCoursesView: Displays students with their courses and related professors

### User Management:
- ProfessorLogin and StudentLogin with custom permissions
- Demonstration of security with EXECUTE AS USER

### Example Queries
- List CE department professors ordered by last name
- Count of students per course (GROUP BY)
- Full list of students and their enrolled courses (JOIN)
- List of students enrolled in a specific course using a SUBQUERY
