SELECT * FROM countries;
--fully fully qualified a column
SELECT e.first_name || ' ' || e.last_name AS "full name"
FROM employees e;

SELECT * FROM departments;
-- Get info for empolyee from marketing dpt
SELECT first_name ||' '|| last_name AS "full_name", department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;
--short/alternative method using USING
SELECT first_name ||' '|| last_name AS "full name", department_name
FROM employees e
INNER JOIN departments d
USING (department_id)
WHERE department_name = 'Marketing';

--Get info of the dpt id 1,2,3 and 4
SELECT * FROM departments
WHERE department_id IN (1,2,3,4);
--Get info of employee who work in the dpt id 1,2,3 and 4
SELECT * FROM 
departments d
JOIN employees e
USING (department_id)
WHERE department_id IN (1,2,3,4);


SELECT * FROM employees;

-- query the information of who reports to whom 
SELECT m.first_name || ' ' || m.last_name AS employee,
e.first_name ||' '|| e.last_name AS manager
FROM employees e
INNER JOIN employees m
ON m.employee_id = e.manager_id;

--let's display staff that are getting the same salary
SELECT s1.first_name ||' '|| s1.last_name AS staff_1,
s2.first_name ||' '|| s2.last_name AS staff_2, s1.salary
FROM employees s1
INNER JOIN employees s2
ON S1.first_name != s2.first_name AND s1.salary = s2.salary;

--UNION operator to combine data from similar tables
SELECT * FROM most_popular_films
UNION
SELECT * FROM top_rated_films;

SELECT * FROM most_popular_films
UNION ALL
SELECT * FROM top_rated_films;

CREATE TABLE ALL_films AS 
SELECT * FROM most_popular_films
UNION ALL
SELECT * FROM top_rated_films;

SELECT * 
FROM most_popular_films
JOIN top_rated_films 
USING(title);

SELECT * FROM most_popular_films
INTERSECT
SELECT * FROM top_rated_films;

--EXCEPT operator returns distinct rows from the first (left) query that are not in the output of the second (right) query
SELECT * FROM most_popular_films
EXCEPT
SELECT * FROM top_rated_films;


SELECT department_name, COUNT(employee_id) AS employee_count
FROM employees 
JOIN departments 
USING (department_id)
GROUP BY department_name
ORDER BY employee_count DESC;

--employee hired last month
SELECT employee_id, first_name, hire_date
FROM employees 
WHERE hire_date = (SELECT MAX(hire_date) FROM employees);

SELECT CURRENT_DATE;

CREATE VIEW employee_contacts AS
SELECT
first_name, last_name, email, phone_number, department_name
FROM
employees e
INNER JOIN
departments d ON d.department_id = e.department_id
ORDER BY first_name;

SELECT * FROM employee_contacts;

SELECT first_name, last_name, department_name
FROM employee_contacts;

--identify staffs that are earing more than the company's average salary
--let find the average salary 
SELECT AVG(salary)
FROM employees;

--now identify staffs that are earing more than the company's average salary
SELECT first_name ||' '|| last_name AS "staff name", salary
FROM employees
WHERE salary > 8060;

--USING sub Query
SELECT first_name ||' '|| last_name AS "staff name", salary
FROM employees
WHERE salary > (
SELECT AVG(salary) FROM employees);

--get employees whose location_id is 1700 USING JOIN 
SELECT first_name ||' '|| last_name AS "employees name", location_id
FROM employees
JOIN departments 
USING (department_id)
WHERE location_id = 1700;

SELECT department_id
FROM departments
WHERE location_id = 1700;

SELECT first_name, last_name 
FROM employees
WHERE department_id IN (
SELECT department_id
FROM departments 
WHERE location_id = 1700); 

--find the employees who has the higest salary USING sub QUERY
SELECT first_name, last_name, salary
FROM employees
WHERE salary =(
		SELECT MAX(salary) 
		 FROM employees);
		 
--finds all departments that do not have any employee with the salary greater than 10,000
SELECT d.department_id, e.first_name, e.last_name, d.department_name, e.salary 
FROM departments d
JOIN employees e
ON d.department_id = e.department_id
where salary > 10000;

--USING SUBQUERY
SELECT department_name
FROM departments d 
WHERE EXISTS (
SELECT 1 
FROM employees e
WHERE salary > 10000
AND d.department_id = e.department_id);

--find the lowest salary by department
SELECT MIN(salary )
FROM employees
GROUP BY department_id 
ORDER BY MIN(salary) DESC; 

/*SELECT first_name, MIN(salary)
FROM employees
JOIN departments
USING (department_id)
GROUP BY first_name 
ORDER BY MIN(salary) DESC; */

--find all employees whose salaries are greater than the lowest salary of every departments
SELECT first_name, last_name, salary
FROM  employees
WHERE salary > ALL (
SELECT MIN(salary)
FROM employees
GROUP BY department_id);

SELECT first_name, last_name, salary, department_name
FROM  employees
JOIN departments
USING (department_id)
WHERE salary > ALL (
SELECT MIN(salary)
FROM employees
GROUP BY department_id);

