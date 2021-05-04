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

-- Create VIEW

CREATE VIEW emp_100000 AS SELECT * FROM employee WHERE salary>100000;

-- SELECT VIEW

select * from emp_100000;

desc formatted emp_100000;

ALTER VIEW emp_100000 SET TBLPROPERTIES ('comment' = 'This is my view table');

desc formatted emp_100000;

-- EXPLODE

create table std_course_details( std_id int, stud_name string, location string, course array<string>);

INSERT INTO TABLE std_course_details VALUES (1,'vamshi','hyd',array('hive','hadoop','spark')),(2,'chandana','bangalore',array('reactjs','javascript')),(3,'Divya','pune',array('python','pyspark','airflow','spark')),(4,'srikanth','pune',array('java','spring boot')),(5,'sreethan','pune',array('c','c++'));

SELECT * FROM STD_COURSE_DETAILS;

select explode(course) from std_course_details;

select std_id,stud_name,location,courses  from std_course_details LATERAL VIEW explode(course) courses_list as courses;

-- https://www.dezyre.com/recipes/explain-use-of-explode-and-lateral-view-hive
