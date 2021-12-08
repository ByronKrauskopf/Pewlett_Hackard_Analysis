--Create retirement_titles table 
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no

--check new table
SELECT * 
FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows from retirement_table
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

--check new table
SELECT *
FROM unique_titles

--Create table of count for retirements by title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY Count(title) DESC;

--check new table
SELECT *
FROM retiring_titles

--Create a mentorship_eligibility table
SELECT DISTINCT ON(emp_no) 
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_employees AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no

--check new table
SELECT * 
FROM mentorship_eligibility