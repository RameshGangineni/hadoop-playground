-- Create Database

create database hive_demo;

-- USE database

use hive_demo;

-- Create employee

CREATE TABLE employee (
employee_id int,
company_id int,
seniority int,
salary int,
join_date string,
quit_date string,
dept string
)
ROW FORMAT DELIMITED
fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");


-- SELECT data from employee

select * from employee;


-- Load data into employee table

scp  -r datasets/empdata.csv ${username}@{EMR_MASTER_IP}:/home/${username}datasets/
load data local inpath '/home/${username}/datasets/empdata.csv' into table employee;

-- SELECT data from employee

select * from employee;

-- COUNT

SELECT dept, COUNT(employee_id) OVER (PARTITION BY dept) FROM employee;
SELECT distinct dept, COUNT(employee_id) OVER (PARTITION BY dept) FROM employee;

-- MAX

select employee_id, dept, MAX(salary) as max_sal from employee group by employee_id, dept order by max_sal desc;

-- MIN

SELECT employee_id,dept, MIN(salary) as min_sal from employee group by employee_id, dept order by min_sal;

-- AVG

SELECT AVG(salary) as avg_sal from employee where dept='marketing';

-- LEAD

SELECT employee_id, company_id, seniority, dept,salary, LEAD(SALARY) OVER (PARTITION BY dept ORDER BY salary) - SALARY FROM employee;

-- LAG

SELECT employee_id, company_id, seniority, dept,salary, LAG(SALARY) OVER (PARTITION BY dept ORDER BY salary DESC) - SALARY FROM employee;

-- FIRST_VALUE

SELECT employee_id, company_id, seniority, dept,salary, FIRST_VALUE(SALARY) OVER (PARTITION BY dept ORDER BY salary) FROM employee;

-- LAST_VALUE

SELECT employee_id, company_id, seniority, dept,salary, LAST_VALUE(employee_id) OVER (PARTITION BY dept ORDER BY salary) FROM employee;