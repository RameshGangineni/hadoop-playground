create database hive_demo;

-- USE database

use hive_demo;

-- Create authors

CREATE TABLE authors(
id int,
author_name string ,
country string
 )
ROW FORMAT DELIMITED
fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");

-- LOAD DATA INTO AUTHORS

load data local inpath '/home/rameshbabug/datasets/authors.csv' into table authors;

SELECT * FROM AUTHORS;

-- CREATE BOOKS

CREATE TABLE books(
id int,
book_title string
)
ROW FORMAT DELIMITED
fields terminated by ','
TBLPROPERTIES ("skip.header.line.count"="1");

-- LOAD DATA INTO BOOKS

LOAD DATA LOCAL INPATH '/home/rameshbabug/datasets/books.csv' INTO TABLE BOOKS;

SELECT * FROM BOOKS;

-- INNER JOIN

SELECT A.AUTHOR_NAME, B.BOOK_TITLE FROM AUTHORS A JOIN BOOKS B ON A.ID = B.ID;

-- LEFT JOIN

SELECT A.AUTHOR_NAME, B.BOOK_TITLE FROM AUTHORS A LEFT JOIN BOOKS B ON A.ID = B.ID;

-- RIGHT JOIN

SELECT A.AUTHOR_NAME, B.BOOK_TITLE FROM AUTHORS A RIGHT JOIN BOOKS B ON A.ID = B.ID;

-- FULL OUTER JOIN

SELECT A.AUTHOR_NAME, B.BOOK_TITLE FROM AUTHORS A FULL JOIN BOOKS B ON A.ID = B.ID;

-- https://www.dezyre.com/recipes/perform-joins-hive