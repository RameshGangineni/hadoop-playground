create database hive_demo;

-- USE database

use hive_demo;

-- Create Salesman Table

CREATE TABLE salesman(
salesman_id int,
name string,
city string,
commission float
 )
ROW FORMAT DELIMITED
fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");


--LOAD DATA INTO SALESMAN TABLE

load data local inpath '/home/rameshbabug/datasets/salesman.csv' into table salesman;

SELECT * FROM SALESMAN;

-- CREATE ORDERS TABLE

CREATE TABLE orders(
ord_no int,
purch_amt  string,
ord_date string,
customer_id int,
Salesman_id int
)
ROW FORMAT DELIMITED
fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");

-- LOAD DATA INTO ORDERS TABLE

load data local inpath '/home/rameshbabug/datasets/orders.csv' into table orders;

SELECT * FROM ORDERS;

-- SUBQUERY
SELECT *
FROM orders
WHERE salesman_id =
    (SELECT salesman_id
     FROM salesman
     WHERE name='Paul Adam');

-- UNION

SELECT salesman_id FROM salesman  UNION SELECT salesman_id FROM orders ORDER BY salesman_id;

-- UNION ALL

SELECT salesman_id FROM salesman  UNION ALL SELECT salesman_id FROM orders ORDER BY salesman_id;

-- https://www.dezyre.com/recipes/explain-with-example-perform-subquery-union-and-union-all