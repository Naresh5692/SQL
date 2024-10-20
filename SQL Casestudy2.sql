SELECT*FROM departments;

--1.To get the information of the department id 1,2, and 3, you use the following statement.

SELECT
	department_id,
	department_name
FROM
	departments

WHERE 
	department_id IN (1, 2, 3);

--Result/

-- department_id | department_name
-----------------|-----------------
--   1		 | Administration
--   2		 | Marketing
--   3		 | Purchasing


--2.To get the information of employees who work in departments id 9, 8, and 6, you use the following query:

SELECT
	first_name,
	last_name,
	department_id
FROM
	employeesdata1
WHERE
	department_id IN (4, 5, 6)
ORDER BY
	department_id;

--Result/

--   first_name	  | last_name   | department_id | 
------------------|-------------|---------------|
--	Annarapu  | Sathvika	|      4        |		
--	Gopari	  | Keerthana	|      5	|		
--	Karri     | Santhosh	|      5	|			
--	Venkata   | Santhoshi	|      6	|	    
--	Joga	  | Keerthana	|      6	|		
--	Chavva    | Shravani	|      6	|	

SELECT*FROM employeesdata1;

--3.To combine data from these employeesdata1 and deparments both two tables, you use an inner join clause as the following query :

SELECT 
    first_name,
    last_name,
    employeesdata1.department_id,
    departments.department_id,
    department_name
FROM
    employeesdata1
        INNER JOIN
    departments ON departments.department_id = employeesdata1.department_id
WHERE
    employeesdata1.department_id IN (4, 5, 6 );

	--Result/

--   first_name	  | last_name   | department_id | departement_id|department_name    
------------------|-------------|---------------|---------------|-------------------
--	Venkata	  | Santhoshi	|	6	|	6	|	IT				
--	Karri	  | Santhosh	|	5	|	5	|	Shipping		
--	Annarapu  | Sathwika	|	4	|	4	|	Human Resources	
--	Gopari	  | Keerthana	|	5	|	5       |	Shipping
--	Joga	  | Keerthana	|	6	|	6	|	IT
--	Chavva	  | Shravani	|	6	|	6       |	IT	

--4.The following query uses the inner join clauses to join 3 tables: employees, departments, and jobs to get the first name, last name, job title, and department name of employees who work in department id 4, 5, and 6.

SELECT
	first_name,
	last_name,
	job_title,
	department_name
FROM
	employeesdata1 e
INNER JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
WHERE
	e.department_id IN (4, 5, 6);

--Result/

--   first_name	  | last_name   |      job_title		| department_name    
------------------|-------------|-------------------------------|-------------------
--	Venkatesh | Santhosh	| Administartion Vice president | IT				
--	Karri	  | Santhosh	| Administration Vice President | Shipping		
--	Annarapu  | Sathwika	| Administration Assistant      | Human Resources	
--	Gopari	  | Keerthana	| president			| Shipping
--	Joga	  | Keerthana	| Administration Vice President | IT
--	Chavva	  | Shravani	| Accountant		        | IT	

---- Copy table structure and data from hr1 to master

	USE master;
GO
-- Copy table structure and data from hr1 to master

SELECT * INTO master.dbo.countries
FROM hr1.dbo.countries;

select*from countries;

--5. To query the country names of US, UK, and China, you use the following statement.

SELECT
	country_id,
	country_name
FROM
	countries
WHERE
	country_id IN ('US', 'UK', 'CN');
--Result/

--  country_id | country_name
---------------|-----------------
-- 	CN     | China
--	UK     | United Kingdom
--	US     | United States of America

---- Copy table structure and data from hr1 to master

	USE master;
GO
-- Copy table structure and data from hr1 to master

SELECT * INTO master.dbo.Locations
FROM hr1.dbo.Locations;

SELECT*FROM Locations;

--6.The following query retrieves the locations located in the US, UK and China:

SELECT
	country_id,
	street_address,
	city
FROM
	locations
WHERE
	country_id IN ('US', 'UK', 'CN');

	--Result/

--  Country_id    |Street_address      |  city
------------------|--------------------|--------------------
--   US 	  | 2014 Jabberwocky Rd| Southlake 
--   US		  | 2011Interiors Blvd | South San Francisco 
--   US		  | 2004 Charade rd    | Seattle
--   UK		  | 8204 Athur St      | London
--   UK		  | Magdalen Centre.   | Oxford  

--7.Now, we use the LEFT JOIN clause to join the countries table with the locations table as the following query:

SELECT
	c.country_name,
	c.country_id,
	l.country_id,
	l.street_address,
	l.city
FROM
	countries c
LEFT JOIN locations l ON l.country_id = c.country_id
WHERE
	c.country_id IN ('US', 'UK', 'CN')

--Result/

--   Country_name | Country_id  | Country_id|Street_address     |  city
------------------|-------------|-----------|-------------------|--------------------
-- China	  |	CN	|    NULL   |NULL		| NULL
-- United Kindomb |	UK	|    UK	    |8204 Athur St	| LondonOxford
-- United Kindom  |	UK 	|    UK	    |Magdalen Centre.	| Oxford 
-- United S A     |	US	|    US	    |2014 Jabberwocky Rd| Southlake
-- United S A     |	US	|    US	    |2011Interiors Blvd | South San FranciscoSeattle
-- United S A     |	US	|    US	    |2004 Charade rd	| Seattle

--8.to find the country that does not have any locations in the locations table, you use the following query:

SELECT
	country_name
FROM
	countries c
LEFT JOIN locations l ON l.country_id = c.country_id
WHERE
	l.location_id IS NULL
ORDER BY
	country_name;

--Result/
-- |	Country_name
 --|----------------------
--1|	Argentina
--2|	Belgium
--3|    Brazil
--4|    China
--5|    Denmark
--6|    etc...

-- Copy the Regions table and data from hr1 to master

	USE master;
GO
-- Copy the Regions table and data from hr1 to master
SELECT * INTO master.dbo.regions
FROM hr1.dbo.regions;

select*from regions;

--Result/
	--region     | region_name
	-------------|-------------
--	  1	     | Europe		
--	  2          | Americas		
--	  3	     | Asia		
--	  4	     | Middle East and Africa	

--9.The following statement demonstrates how to join 3 tables: regions, countries, and locations:

SELECT
	r.region_name,
	c.country_name,
	l.street_address,
	l.city
FROM
	regions r
LEFT JOIN countries c ON c.region_id = r.region_id
LEFT JOIN locations l ON l.country_id = c.country_id
WHERE
	c.country_id IN ('US', 'UK', 'CN');

--Result/

--region_name | Country_Name      | Street_address    |  city
--------------|-------------------|-------------------|--------------------
-- Europe     |United Kindom	  |8204 Athur St      | London
-- Europe     |United Kindom	  |Magdalen Centre.   | Oxford
-- Americas   |United S A         |2014 Jabberwocky Rd| Southlake
-- Americas   |United S A         |2011	Interiors Blvd| South San Francisco
-- Americas   |United S A         |2004 Charade rd    | Seattle
-- Asia       |China		  |NULL		      | NULL
				  
--10.the following statement uses the GROUP BY clause with the COUNT function to count the number of employees by department:

SELECT
	department_id,
	COUNT(employee_id) headcount
FROM
	employeesdata1
GROUP BY
	department_id;

--Result/

-- department_id| headcount
   -------------|----------------
--	4	|	1
--	5       |	2
--	6	|	3
--	8	|	7
--	9       |	8

--11.The following example returns the number of employees by department. And it uses an INNER JOIN clause to include the department name in the result:

SELECT
	department_name,
	COUNT(employee_id) headcount
FROM
	employeesdata1 e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY
        department_name;

--Result/

--department_name  | headcount
  -----------------|----------
-- Excutive	   |	8	
-- Human Resources |	1	
-- IT		   |	3	
-- sales	   |	7	
-- Shipping        |	2	

--12.The following example uses the HAVING clause to find departments with headcounts are greater than 5:

SELECT 
    department_name,
    COUNT(employee_id) AS headcount
FROM 
    employeesdata1 e
INNER JOIN 
    departments d ON d.department_id = e.department_id
GROUP BY 
    department_name
HAVING 
    COUNT(employee_id) > 5
ORDER BY 
    headcount DESC;

--Result/

--department_name  | headcount
  -----------------|----------
-- Excutive	   |	8	
-- Sales	   |	7	

--13.The following query returns the minimum, maximum, and average salary of employees in each department.

SELECT 
    department_name,
    MIN(salary) min_salary,
    MAX(salary) max_salary,
    ROUND(AVG(salary), 2) average_salary
FROM
    employeesdata1 e
        INNER JOIN
    departments d ON d.department_id = e.department_id
GROUP BY 
    department_name;

--Result/

--department_id   | min_salary | max_salary | average_salary
------------------|------------|------------|-----------------
-- Exacutive	  |9000	       |  30000	    | 117625
-- Human Resources|6000	       |  6000	    |  6000
-- IT		  |9000	       |  30000	    |  23000
-- Sales	  |9000	       |  30000	    |  18000
-- Shipping       |30000       |  40000	    |  35000

--14.To get the total salary per department, you apply the SUM function to the salary column and group employees by the department_id column as follows:

SELECT 
    department_name,
    SUM(salary) total_salary
FROM
    employeesdata1 e
        INNER JOIN
    departments d ON d.department_id = e.department_id
GROUP BY 
    department_name;

	--Result/

--department_name  | total_salary
  -----------------|----------
-- Excutive	   | 141000	
-- Human Resources | 6000	
-- IT		   | 69000	
-- sales	   | 126000	
-- Shipping        | 70000

--15.The following statement groups rows with the same values in both department_id and job_id columns in the same group then return the rows for each of these groups.

SELECT 
    department_name,
    job_title,
    COUNT(employee_id)
FROM
    employeesdata1 e
        INNER JOIN
    departments d ON d.department_id = e.department_id
        INNER JOIN
    jobs j ON j.job_id = e.job_id
GROUP BY department_name , 
         job_title;

 --Result/

-- department_name | job_title                    | COUNT(employee_id)
------------------ |------------------------------|--------------------
-- Exacutive	   |Accountant	                  |2	    
-- Human Resources |Administartive Assistant      |1		
-- IT		   |Accountant	                  |1		
-- Sales	   |Administartive Vice Presindent|2		
-- Shipping        |Presedent	                  |1		
