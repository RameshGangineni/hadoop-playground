create database hive_demo;

-- USE database

use hive_demo;

-- CREATE FOOD TABLE

CREATE TABLE food_prices (
 series_reference string,
 Period string,
 data_value int,
 status string,
 units string,
 subject string,
 product string,
 series_title string,
 year string
 )
 ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = "\""
)


-- LOAD DATA INTO FOOD TABLE

LOAD DATA LOCAL INPATH '/home/rameshbabug/datasets/food_prices.csv' INTO TABLE FOOD_PRICES;

SELECT * FROM FOOD_PRICES;

-- STATIC PARTITION TABLE

-- CREATE PARTITION TABLE WITH PARTITIONED KEY

create table food_prices_static_partitioned (
series_reference string,
data_value int,
status string,
units string,
subject string,
product string
)
partitioned by (year string) ;

-- LOAD DATA INTO PARTITION TABLE

insert overwrite table food_prices_static_partitioned partition(year = '2019') select series_reference, data_value, status, units, subject, product from food_prices where year='2019';

select * from food_prices_static_partitioned;

-- DYNAMIC PARTITION

-- CREATE TABLE

create table food_prices_dynamic_partitioned (
series_reference string,
period string,
data_value int,
status string,
units string,
subject string,
product string,
series_title string
)partitioned by (year string);

-- SET PROPERTIES
set hive.exec.dynamic.partition.mode=nonstrict;

-- LOAD DATA
insert overwrite table food_prices_dynamic_partitioned partition(year) select * from food_prices;

select * from food_prices_dynamic_partitioned;

-- DROP PARTITION

alter table food_prices_dynamic_partitioned drop partition (year = '2019');

-- https://www.dezyre.com/recipes/create-static-and-dynamic-partitions-hive