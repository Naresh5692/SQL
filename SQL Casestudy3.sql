SELECT*FROM employeesdata1;

SELECT*FROM jobs;
--1.To get the managers and their direct reports, you use the GROUP BY clause to group employees by the managers and use the COUNT function to count the direct reports.

SELECT 
    manager_id,
    first_name,
    last_name,
    COUNT(employee_id) direct_reports
FROM
    employeesdata1
WHERE
    manager_id IS NOT NULL
GROUP BY manager_id,First_Name, Last_Name;

--Result/

--  manager_id	  | First_name  | Last_Name     | direct_reports
------------------|-------------|---------------|-----------------
--	200	  | Amgoth	| Shiva		| 1	    			
--	200	  | Dumpala	| Sowmya	| 1				
--	200 	  | Karri	| Santhosh	| 1			
--	200	  | Kusuma	| Vinay		| 1       
--	200	  | Muddangula	| naresh	| 1	    
--	200	  | Palle	| Keerthna	| 1    


--2.To find the department that has employees with the lowest salary greater than 10000, you use the following query:

SELECT
    e.department_id,
    d.department_name,
    MIN(j.min_salary) AS min_salary
FROM
    employeesdata1 e
INNER JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY
    e.department_id,
    d.department_name
HAVING
    MIN(j.min_salary) >= 10000
ORDER BY
    min_salary;

--Result/

--   department_id| department_name | min_salary 
------------------|-----------------|------------
--	5	  | Shipping	    |	15000				


--3.To find the departments that have the average salaries of employees between 5000 and 7000, you use the AVG function as the following query:

SELECT
    e.department_id,
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM
    employeesdata1 e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY
    e.department_id,
    d.department_name
HAVING
    AVG(e.salary) BETWEEN 5000 AND 7000
ORDER BY
    avg_salary;

	--Result/

--   department_id| department_name | avg_salary 
------------------|-----------------|------------
--	4	  | Human Resources |	6000	



--4.Let’s set up a new table named inventory to demonstrate the functionality of the GROUPING SETS.

CREATE TABLE inventory (
    warehouse VARCHAR(255),
    product VARCHAR(255) NOT NULL,
    model VARCHAR(50) NOT NULL,
    quantity INT,
    PRIMARY KEY (warehouse,product,model)
);

SELECT*FROM inventory;

--Second, insert data into the inventory table:

INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose', 'iPhone','6s',100);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','6s',50);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','iPhone','7',50);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','7',10);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','iPhone','X',150);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','X',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','Samsung','Galaxy S',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco','Samsung','Galaxy S',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco','Samsung','Note 8',100);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','Samsung','Note 8',150);


SELECT*FROM inventory;
--Result/

--  | warehouse	   |  product	      | model |	quantity
----|--------------|------------------|-------|-----------
--1 | San Fransisco|	iPhone	      |	6s    |	50
--2 | San Fransisco|	iPhone	      |	7     |	10
--3 | San Fransisco|	iPhone	      |	X     |	200
--4 | San Fransisco|	Samsung	Galaxy|	S     |	200
--5 | San Fransisco|	Samsung	Note  |	8     |	100
--6 | San Jose	   |    iPhone	      |	6s    |	100
--7 | San Jose	   |	iPhone	      |	7     |	50
--8 | San Jose	   |	iPhone	      |	X     |	150
--9 | San Jose	   |	Samsung	Galaxy|	S     |	200
--10| San Jose	   |	Samsung	Note  |	8     |	150

--5.The following example defines a grouping set (warehouse, product). It returns the number of stock keeping units (SKUs) stored in the inventory by warehouse and product.

SELECT
    warehouse,
    product, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    warehouse,
    product;

--Result/

--  warehouse   |product |qty
 ---------------|--------|--------
-- San Fransisco|iPhone	 |260
-- San Fransisco|Samsung |300
-- San Jose	|iPhone	 |300
-- San Jose     |Samsung |350

--6.The following query finds the number of SKUs by the warehouse. It defines the grouping set (warehouse):

SELECT
    warehouse, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    warehouse;

--Result/

--	warehouse |qty
------------------|-------
--  San Fransisco |	560
--  San Jose	  | 650

--7.The following query returns the number of SKUs by the product. It defines the grouping set (product):

SELECT
    product, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    product;

--Result/

-- product      |qty
----------------|--------
-- iPhone	|560
-- Samsung	|650

--8.The following query finds the number of SKUs for all warehouses and products. It defines an empty grouping set ().

SELECT
    SUM(quantity) qty
FROM
    inventory;

-- Result/
-- |qty
---|--------
-- |1210
-- |

--9.The UNION ALL requires all result sets to have the same number of columns, therefore, you need to add NULL to the select list to of each query as shown below:

SELECT
    warehouse,
    product, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    warehouse,
    product
UNION ALL
SELECT
    warehouse, 
    null,
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    warehouse
UNION ALL
SELECT
    null,
    product, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    product
UNION ALL
SELECT
    null,
    null,
    SUM(quantity) qty
FROM
    inventory;

--Result/

--	warehouse    |	product |qty
---------------------|----------|-------
--	San Fransisco| iPhone	|260
--	San Fransisco| Samsung	|300
--	San Jose     | iPhone	|300
--	San Jose     | Samsung	|350
--	San Fransisco| NULL	|560
--	San Jose     | NULL	|650
--	NULL	     | iPhone	|560
--	NULL	     | Samsung	|650
--	NULL	     | NULL	|1210

--10.You can apply the GROUPING SETS to rewrite the query with the UNION ALL clauses above:

SELECT
    warehouse,
    product, 
    SUM (quantity) qty
FROM
    inventory
GROUP BY
    GROUPING SETS(
        (warehouse,product),
        (warehouse),
        (product),
        ()
    );

--Result/

--	warehouse    |product |	qty
---------------------|--------|---------
--	San Fransisco|iPhone  |	260
--	San Jose     |iPhone  |	300
--	NULL	     |iPhone  |	560
--	San Fransisco|Samsung |	300
--	San Jose     |Samsung |	350
--	NULL	     |Samsung |	650
--	NULL	     |NULL    | 1210
--	San Fransisco|NULL    | 560
--	San Jose     |NULL    |	650

--11.The following example finds all employees whose salaries are equal to the highest salary of employees in the Marketing department:

SELECT 
    first_name, last_name, salary
FROM
    employeesdata1
WHERE
    salary = ALL (SELECT 
            MAX(salary)
        FROM
            employeesdata1
        WHERE
            department_id = 5);

--Result/
--first_name|last_name|salary
------------|---------|--------
--Gopari    |Keerthana|40000











