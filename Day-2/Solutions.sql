-- ==========================================
-- STUDENT DATASET SQL SOLUTIONS
-- ==========================================

-- ==========================================
-- 🟢 Section A: Basic Level
-- ==========================================

-- 1. Display the first 5 rows of the dataset.
SELECT TOP 5 *
FROM Students;

-- 2. Check the total number of rows.
SELECT COUNT(*) AS Total_Rows
FROM Students;

-- 3. Find the number of missing values in each column.
SELECT
SUM(CASE WHEN student_id IS NULL THEN 1 ELSE 0 END) AS student_id_missing,
SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_missing,
SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS department_missing,
SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_missing,
SUM(CASE WHEN marks IS NULL THEN 1 ELSE 0 END) AS marks_missing,
SUM(CASE WHEN attendance IS NULL THEN 1 ELSE 0 END) AS attendance_missing
FROM Students;

-- 4. Replace missing values in the marks column with the average marks.
UPDATE Students
SET marks = (SELECT AVG(marks) FROM Students)
WHERE marks IS NULL;

-- 5. Display only the name and marks columns.
SELECT name, marks
FROM Students;

-- ==========================================
-- 🟡 Section B: Filtering & Sorting
-- ==========================================

-- 6. Display students who scored more than 160 marks.
SELECT *
FROM Students
WHERE marks > 160;

-- 7. Display students from the CS department.
SELECT *
FROM Students
WHERE department = 'CS';

-- 8. Attendance > 85 and Marks > 150.
SELECT *
FROM Students
WHERE attendance > 85
AND marks > 150;

-- 9. Sort the dataset by marks in descending order.
SELECT *
FROM Students
ORDER BY marks DESC;

-- 10. Display the top 3 students based on marks.
SELECT TOP 3 *
FROM Students
ORDER BY marks DESC;

-- ==========================================
-- 🟠 Section C: Column Transformations
-- ==========================================

-- 11. Percentage column.
SELECT *,
(marks * 100.0 / 200) AS percentage
FROM Students;

-- 12. Grade column.
SELECT *,
CASE
    WHEN (marks * 100.0 / 200) >= 85 THEN 'A'
    WHEN (marks * 100.0 / 200) >= 70 THEN 'B'
    WHEN (marks * 100.0 / 200) >= 50 THEN 'C'
    ELSE 'Fail'
END AS Grade
FROM Students;

-- 13. Add 5 bonus marks.
UPDATE Students
SET marks = marks + 5;

-- 14. Result column.
SELECT *,
CASE
    WHEN (marks * 100.0 / 200) >= 40 THEN 'Pass'
    ELSE 'Fail'
END AS Result
FROM Students;

-- 15. Convert names to uppercase.
SELECT UPPER(name) AS name
FROM Students;

-- ==========================================
-- 🔵 Section D: GroupBy & Aggregation
-- ==========================================

-- 16. Average marks of each department.
SELECT department,
AVG(marks) AS Average_Marks
FROM Students
GROUP BY department;

-- 17. Maximum marks scored in each city.
SELECT city,
MAX(marks) AS Maximum_Marks
FROM Students
GROUP BY city;

-- 18. Count students in each department.
SELECT department,
COUNT(*) AS Student_Count
FROM Students
GROUP BY department;

-- 19. Department with highest average marks.
SELECT TOP 1 department,
AVG(marks) AS Average_Marks
FROM Students
GROUP BY department
ORDER BY Average_Marks DESC;

-- 20. Average marks by department and city.
SELECT department,
city,
AVG(marks) AS Average_Marks
FROM Students
GROUP BY department, city;

-- ==========================================
-- 🔴 Section E: Advanced Level
-- ==========================================

-- 21. Rank students based on marks.
SELECT *,
RANK() OVER(ORDER BY marks DESC) AS Rank_No
FROM Students;

-- 22. Students above overall average marks.
SELECT *
FROM Students
WHERE marks > (SELECT AVG(marks) FROM Students);

-- 23. Min-Max Scaling.
SELECT *,
(marks - (SELECT MIN(marks) FROM Students)) * 1.0 /
((SELECT MAX(marks) FROM Students) -
 (SELECT MIN(marks) FROM Students)) AS Marks_Scaled
FROM Students;

-- 24. Attendance category.
SELECT *,
CASE
    WHEN attendance >= 90 THEN 'Excellent'
    WHEN attendance >= 80 THEN 'Good'
    WHEN attendance >= 70 THEN 'Average'
    ELSE 'Poor'
END AS Attendance_Category
FROM Students;
