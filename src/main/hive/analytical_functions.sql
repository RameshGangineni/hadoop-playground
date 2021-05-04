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


-- ROW_NUMBER

SELECT employee_id, company_id, seniority, dept, salary, ROW_NUMBER() OVER (PARTITION BY dept ORDER BY salary DESC) FROM employee;


-- RANK

SELECT employee_id, company_id, seniority, dept, salary, RANK() OVER (PARTITION BY dept ORDER BY salary DESC) FROM employee;


-- DENSE_RANK

SELECT employee_id, company_id, seniority, dept, salary, DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) FROM employee;


-- CUME_DIST

SELECT dept, salary, CUME_DIST() OVER (ORDER BY salary) AS cume_dist FROM employee order by salary desc;

-- PERCENT_RANK

SELECT dept, salary, RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rank, PERCENT_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS percen_rank FROM employee;

-- NTILE



