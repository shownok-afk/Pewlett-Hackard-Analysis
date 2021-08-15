--Employess who will retire bron between 1952 & 1955 
SELECT Employees.emp_no,
    Employees.first_name,
    Employees.last_name,
    Titles.title,
	Titles.from_date,
	Titles.to_date
INTO retirement_titles
FROM Employees
LEFT JOIN titles
ON Employees.emp_no = titles.emp_no
WHERE (Employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by emp_no
;

-- Display retirement_titles table
Select * from retirement_titles;

-- Create a table of employess with latest title who were born between 1952 & 1955
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
into  Unique_titles
From retirement_titles
order by emp_no, to_date desc; 

-- Display Unique_titles table
Select * from Unique_titles;

-- Create a Retiring Titles table
-- Count number of employees per title who are retiring soon
SELECT COUNT(title) as count, title
INTO retiring_titles
FROM Unique_titles
GROUP BY title
order by count desc 
;

-- Display retiring_titles table
Select * from retiring_titles;

-- Create a Mentorship Eligibility table
-- Filter with Employess who bron in 1965 
SELECT DISTINCT ON (Employees.emp_no) 
    Employees.emp_no,
    Employees.first_name,
    Employees.last_name,
	Employees.birth_date,
    dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibilty
FROM Employees
LEFT JOIN dept_emp
ON Employees.emp_no = dept_emp.emp_no
LEFT JOIN titles
ON Employees.emp_no = titles.emp_no
WHERE (Employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (dept_emp.to_date = '9999-01-01')
order by Employees.emp_no
;

--Display mentorship_eligibilty table
select * from mentorship_eligibilty;

-- Count number of employees per title who are eligible for mentorship 
SELECT COUNT(title) as count, title
FROM mentorship_eligibilty
GROUP BY title
order by count desc 
;