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

-- Group By

Select dept, count(*) as count_of_emp from employee group by dept;

-- ORDER BY

Select * from employee order by salary desc;

-- EXCLUDE COLUMN

set hive.support.quoted.identifiers=NONE;
set hive.cli.print.header=true;
select `(quit_date)?+.+` from employee; -- excludes quit_date
select `(join_date|quit_date)?+.+` from employee; -- excludes join date and quit date



-- https://www.dezyre.com/recipes/select-group-by-and-order-by-hive