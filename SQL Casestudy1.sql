select*from employeesdata1;

--1.selecting data from specific columns: 

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    hire_date
FROM
    employeesdata1;


--2.Performing some calculation the SELECT statement to get the first name, last name, salary, and new salary:

SELECT 
    first_name, 
    last_name, 
    salary, 
    salary * 1.05
FROM
    employeesdata1;

--3. the new_salary as the column alias for the salary * 1.05 expression:

SELECT 
    first_name, 
    last_name, 
    salary, 
    salary * 1.05 AS new_salary
FROM
    employeesdata1;

--4.The following SELECT statement returns the data from the employee id, first name, last name, hire date, andsalary column of the employees table:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1;

--5.As you can see clearly from the output, the rows do not have any order.
--The following example uses the ORDER BY clause to sort employees by first names in alphabetical order:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1
ORDER BY
	first_name;

--6.the ORDER BY clause to sort the employees by the first name in ascending order and the last name in descending order:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1
ORDER BY
	first_name,
	last_name DESC;

--7.the ORDER BY clause to sort employees by salary from high to low:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1
ORDER BY
	salary DESC;

--8.the following statement uses the ORDER BY clause to sort the employees by values in the hire_date column from:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1
ORDER BY
	hire_date;

--9.To see the employees who joined the company from lastest to earliest, you sort the employees by the hire dates in descending order:

SELECT
	employee_id,
	first_name,
	last_name,
	hire_date,
	salary
FROM
	employeesdata1
ORDER BY
	hire_date DESC;

--10.The following statement selects the salary data from the salary column of the employees table and sorts them from high to low:

SELECT
	salary
FROM
	employeesdata1
ORDER BY salary DESC;
--The result set have some duplicates values. For example 30000,16000 and 9000

--11.The following statement uses the DISTINCT operator to select unique values from the salary column of the employees table:
	
SELECT
	DISTINCT salary
From 
	employeesdata1
ORDER BY salary DESC;

--12.The following statement selects multiple columns the job id and salary from the employees table:

SELECT
	job_id,
	salary
FROM
	employeesdata1
ORDER BY 
	job_id,
	salary DESC;

--The result set has some duplicate rows e.g., job id 1, 2, 5 salary 17000. It means that there are two employees with the same job id and salary.

--13.The following statement uses the DISTINCT operator to remove the duplicate values in job id and salary:

SELECT DISTINCT
		job_id,
		salary
FROM
		employeesdata1
ORDER BY
		job_id,
		Salary DESC;
--14.the following statement returns the distinct phone numbers of employees:

SELECT DISTINCT phone_number
FROM employeesdata1
ORDER BY phone_number;

--15.the top clause to return the first 5 rows in the result set returned by the SELECT clause:

SELECT top 5 
    employee_id, 
    first_name, 
    last_name
FROM
    employeesdata1
ORDER BY 
	first_name;
	
--16.The following example uses both FETCH & OFFSET clauses to return five rows starting from the 4th row:

SELECT
		employee_id,
		first_name,
		last_name
FROM
		employeesdata1
ORDER BY
		first_name
	OFFSET 3 ROW
	FETCH NEXT 5 ROWS ONLY;

--17.For example, the following statement gets the top five employees with the highest salaries.

SELECT top 5 
    employee_id, 
    first_name, 
    last_name,
	Salary
FROM
    employeesdata1
ORDER BY 
	salary DESC;

--18.If you know subquery, you can combine both queries into a single query as follows:

WITH SalaryRank AS (
    SELECT 
        employee_id, 
        first_name, 
        last_name, 
        salary, 
        ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
    FROM 
        employeesdata1
)
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary
FROM 
    SalaryRank
WHERE 
    rank = 2;

SELECT*FROM dependents;

--19.The following statement uses the UNION operator to combine the first name and last name of employees and dependents.

SELECT
	first_name,
	last_name
FROM
	employeesdata1
UNION
SELECT
	first_name,
	last_name
FROM
	dependents
ORDER BY
	last_name;

--20.The following statement finds all employees who joined the company in 2002 or 1992.

SELECT
	first_name,
	last_name,
	hire_date
FROM
	employeesdata1
WHERE
	YEAR (hire_date) = 2002 OR YEAR (hire_date) = 1992
ORDER BY
	first_name,
	last_name;

SELECT*FROM employeesdata1;

--21.To find all employees who joined the company  in 1992 or 2020 and worked in the department id 9, you use both AND and OR operators as follows:

SELECT
	first_name,
	last_name,
	hire_date,
	department_id
FROM
	employeesdata1
WHERE
	department_id = 9
AND (
	YEAR (hire_date) = 1992
	OR YEAR (hire_date) = 2020
)
ORDER BY
	first_name,
	last_name;



   