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

-- RANDOM SAMPLING

SELECT * FROM employee DISTRIBUTE BY RAND() SORT BY RAND() LIMIT 10;

-- BUCKETED SAMPLING

CREATE TABLE emp_bucketed_tbl_only (
employee_id int,
company_id int,
dept string,
seniority int,
salary int,
join_date string,
quit_date string
)
CLUSTERED BY (salary)
SORTED BY (salary ASC) INTO 4 BUCKETS;

INSERT OVERWRITE TABLE emp_bucketed_tbl_only SELECT * FROM employee;

SELECT * FROM EMP_BUCKETED_TBL_ONLY;

select employee_id, company_id,seniority,dept from emp_bucketed_tbl_only TABLESAMPLE(BUCKET 1 OUT OF 4 ON company_id);

-- BLOCK SAMPLING

select * from emp_bucketed_tbl_only TABLESAMPLE(10 ROWS);

