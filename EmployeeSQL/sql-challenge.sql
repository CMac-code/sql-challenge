CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE Dept_EMP (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL
);

CREATE TABLE Dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL
);

CREATE TABLE Employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL
);

CREATE TABLE Titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

ALTER TABLE Dept_EMP ADD CONSTRAINT fk_Dept_EMP_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_EMP ADD CONSTRAINT fk_Dept_EMP_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

Select * from Departments
Select * from Titles
Select * from Employees
Select * from Dept_EMP
Select * from Dept_manager
Select * from Salaries

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT Employees.emp_no, 
Employees.last_name,
Employees.first_name,
Employees.sex,
Salaries.salary
FROM Employees
LEFT JOIN Salaries
ON Employees.emp_no = Salaries.emp_no
ORDER BY emp_no

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT * FROM Employees WHERE DATE_PART('year', hire_date) = 1986
Order by emp_no

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT Dept_manager.dept_no,
Departments.dept_name,
Dept_manager.emp_no,
Employees.last_name,
Employees.first_name
FROM Dept_manager
Left Join Departments
On Dept_manager.dept_no = Departments.dept_no
Left Join Employees
On Dept_manager.emp_no = Employees.emp_no
Order by emp_no

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
Select Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
From Employees
Inner Join dept_emp 
On Employees.emp_no = dept_emp.emp_no
Inner Join Departments
On Departments.dept_no = dept_emp.dept_no
Order by emp_no

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
Select * From Employees
Where first_name = 'Hercules' And last_name like 'B%';

-- 6. List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.
Select Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
From Employees
Inner Join dept_emp
On dept_emp.emp_no = Employees.emp_no
Inner Join Departments
On Departments.dept_no = dept_emp.dept_no
Where Departments.dept_no = 'd007'
Order by emp_no

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
Select Employees.emp_no,
Employees.last_name,
Employees.first_name,
Departments.dept_name
From Employees
Inner Join dept_emp
On dept_emp.emp_no = Employees.emp_no
Inner Join Departments
On Departments.dept_no = dept_emp.dept_no
Where Departments.dept_no IN ('d007', 'd005')
Order by emp_no


-- 8. In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
Select last_name, Count(first_name) As emp_count
From Employees Group By last_name
Order by last_name Desc;

