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

-- CREATE BUCKETED TABLE

CREATE TABLE emp_bucketed_patitioned_tbl (
employee_id int,
company_id int,
seniority int,
salary int ,
join_date string,
quit_date string
)
PARTITIONED BY(dept string)
CLUSTERED BY (salary)
SORTED BY (salary ASC) INTO 4 BUCKETS;


-- INSERT DATA INTO BUCKETED TABLE

SET hive.enforce.bucketing=TRUE;
set hive.exec.dynamic.partition.mode=nonstrict;
INSERT OVERWRITE TABLE emp_bucketed_patitioned_tbl PARTITION (dept) SELECT * FROM employee;

-- BUCKETED TABLE WITHOUT PARTITION

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


--INSERT DATA INTO TABLE

INSERT OVERWRITE TABLE emp_bucketed_tbl_only SELECT * FROM employee;

-- We can compare the costs of the both tables by querying the data. Usually bucketed tables return results fast
-- compare to non bucketed and non partitioned tables

-- https://www.dezyre.com/recipes/what-are-types-of-bucketing-hive