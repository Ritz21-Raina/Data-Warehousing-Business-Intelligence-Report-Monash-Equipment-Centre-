-- Statements for dropping the copied tables
drop table ME_Address;
drop table ME_Category;
drop table ME_Customer;
drop table ME_CustomerType;
drop table ME_Equipment;
drop table ME_Hire;
drop table ME_Sales;
drop table ME_Staff;

-- ADDRESS TABLE

-- Creating a duplicate table
Create table ME_Address as
Select * 
From MonEquip.Address;

-- Viewing the table as whole
SELECT *
FROM ME_ADDRESS;

-- Description of the table
DESC ME_ADDRESS;

-- Rows
SELECT COUNT(*) as ROW_COUNT
FROM ME_ADDRESS;

-- Looking for null values
SELECT *
FROM ME_ADDRESS
WHERE address_id IS NULL
   OR street_number IS NULL
   OR street_name IS NULL
   OR suburb IS NULL
   OR state IS NULL
   OR postcode IS NULL;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT ADDRESS_ID,STREET_NUMBER,STREET_NAME,SUBURB,STATE,POSTCODE)
AS DUPLICATES
FROM ME_ADDRESS;

-- SELECT DISTINCT
SELECT ADDRESS_ID
FROM ME_ADDRESS;


---------------------------------------- CATEGORY TABLE

-- Creating a duplicate table
Create table ME_CATEGORY as
Select * 
From MonEquip.Category;

-- Viewing the table as whole
SELECT *
FROM ME_CATEGORY;

-- Deleting the 15th row
DELETE FROM ME_CATEGORY
WHERE CATEGORY_ID = 15;

-- Description of the table
DESC ME_CATEGORY;

-- Rows
SELECT COUNT(*) as ROW_COUNT
FROM ME_CATEGORY;

-- Looking for null values
SELECT *
FROM ME_CATEGORY
WHERE CATEGORY_DESCRIPTION IS NULL;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT CATEGORY_ID || '-' || CATEGORY_DESCRIPTION) AS DUPLICATES
FROM ME_CATEGORY;


---------------------------------------- CUSTOMER TABLE
-- Creating a duplicate table
Create table ME_CUSTOMER as
Select * 
From MonEquip.Customer;

-- Viewing the table as whole
SELECT *
FROM ME_Customer;

-- Description of the table
DESC ME_CUSTOMER;

-- Rows
SELECT COUNT(*) as ROW_COUNT
FROM ME_CUSTOMER;

-- Looking for null values
SELECT *
FROM ME_CUSTOMER
WHERE CUSTOMER_ID IS NULL
    OR CUSTOMER_TYPE_ID IS NULL
    OR NAME IS NULL
    OR GENDER IS NULL
    OR ADDRESS_ID IS NULL
    OR PHONE IS NULL
    OR EMAIL IS NULL;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT CUSTOMER_ID || '-' || CUSTOMER_TYPE_ID || '-' || NAME|| '-' || GENDER || '-' || ADDRESS_ID || '-' ||PHONE|| '-' ||EMAIL ) AS DUPLICATES
FROM ME_CUSTOMER;

SELECT *
FROM ME_CUSTOMER
WHERE (CUSTOMER_ID, CUSTOMER_TYPE_ID, NAME, GENDER, ADDRESS_ID, PHONE, EMAIL) IN (
    SELECT CUSTOMER_ID, CUSTOMER_TYPE_ID, NAME, GENDER, ADDRESS_ID, PHONE, EMAIL
    FROM ME_CUSTOMER
    GROUP BY CUSTOMER_ID, CUSTOMER_TYPE_ID, NAME, GENDER, ADDRESS_ID, PHONE, EMAIL
    HAVING COUNT(*) > 1
)
ORDER BY CUSTOMER_ID, NAME;

DELETE FROM ME_CUSTOMER
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM ME_CUSTOMER
    GROUP BY CUSTOMER_ID
);



SELECT *
FROM ME_CUSTOMER
WHERE ADDRESS_ID < 0;


-- Checking the gender column
SELECT *
FROM ME_CUSTOMER
WHERE GENDER <> 'Male' 
  AND GENDER <> 'Female';

-- Updating the gender column
UPDATE ME_CUSTOMER
SET GENDER = 'Male'
WHERE GENDER IN ('M');

UPDATE ME_CUSTOMER
SET GENDER = 'Female'
WHERE GENDER IN ('F');

SELECT * FROM ME_CUSTOMER WHERE CUSTOMER_ID IN(27,79,87,139);

---------------------------------------- customer_type TABLE
-- Creating a duplicate table
Create table ME_CUSTOMERTYPE as
Select * 
From MonEquip.Customer_Type;

-- Viewing the table as whole
SELECT *
FROM ME_CUSTOMERTYPE;

-- Description of the table
DESC ME_CUSTOMERTYPE;



-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT CUSTOMER_ID || '-' || CUSTOMER_TYPE_ID || '-' || NAME|| '-' || GENDER || '-' || ADDRESS_ID || '-' ||PHONE|| '-' ||EMAIL ) AS DUPLICATES
FROM ME_CUSTOMER;

-- DELETING THE SECONF ROW
DELETE FROM ME_CUSTOMERTYPE
WHERE description = 'business';

---------------------------------------- HIRE TABLE

-- Creating a duplicate table
Create table ME_HIRE as
Select * 
From MonEquip.HIRE;

-- Viewing the table as whole
SELECT *
FROM ME_HIRE
WHERE EQUIPMENT_ID = 158;

-- Description of the table
DESC ME_HIRE;

-- Rows
SELECT COUNT(*) as ROW_COUNT
FROM ME_HIRE;

-- Looking for null values
SELECT *
FROM ME_HIRE
WHERE CUSTOMER_ID IS NULL
    OR HIRE_ID IS NULL
    OR START_DATE IS NULL
    OR END_DATE IS NULL
    OR EQUIPMENT_ID IS NULL
    OR QUANTITY IS NULL
    OR UNIT_HIRE_PRICE IS NULL
    OR TOTAL_HIRE_PRICE IS NULL
    OR STAFF_ID IS NULL;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT CUSTOMER_ID || '-' || HIRE_ID || '-' || START_DATE|| '-' || END_DATE || '-' || EQUIPMENT_ID || '-' ||QUANTITY|| '-' ||UNIT_HIRE_PRICE 
|| '-' ||TOTAL_HIRE_PRICE || '-' || "STAFF_ID") AS DUPLICATES
FROM ME_HIRE;

-- Checking for any invalid dates
SELECT hire_id, START_DATE, END_DATE, END_DATE - START_DATE AS duration_days
FROM ME_HIRE
WHERE END_DATE-START_DATE <0;

-- deleting the invalid date
DELETE FROM ME_HIRE
WHERE HIRE_ID = 302;

-- checking for invalid staff id
select * from me_hire where staff_id >51;

-- remove the rows with invalid staff id
delete from me_hire where staff_id > 51;


---------------------------------------- EQUIPMENT TABLE
-- Creating a duplicate table
Create table ME_EQUIPMENT as
Select * 
From MonEquip.EQUIPMENT;

-- Viewing the table as whole
SELECT *
FROM ME_EQUIPMENT
WHERE CATEGORY_ID = 15;

DELETE FROM ME_EQUIPMENT
WHERE CATEGORY_ID = 15;

-- Description of the table
DESC ME_EQUIPMENT;

-- Looking for null values
SELECT *
FROM ME_EQUIPMENT
WHERE CATEGORY_ID IS NULL
    OR MANUFACTURER IS NULL
    OR MANUFACTURE_YEAR IS NULL
    OR EQUIPMENT_PRICE IS NULL
    OR EQUIPMENT_ID IS NULL
    OR EQUIPMENT_NAME IS NULL;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT CATEGORY_ID || '-' || MANUFACTURER || '-' || MANUFACTURE_YEAR|| '-' ||EQUIPMENT_PRICE || '-' || EQUIPMENT_ID || '-' ||EQUIPMENT_NAME)
 AS DUPLICATES
FROM ME_EQUIPMENT;

SELECT *
FROM me_equipment
WHERE equipment_name = 'EXCAVATOR - POST HOLE ATTACHMENT SUIT 3.5T';

---------------------------------------- SALES TABLE

-- Creating a duplicate table
Create table ME_SALES as
Select * 
From MonEquip.SALES;

-- Viewing the table as whole
select *
from me_sales;

-- -ve value
select *
from ME_SALES
WHERE QUANTITY < 0;

-- Viewing the table as whole
SELECT *
FROM ME_SALES
WHERE EQUIPMENT_ID = 158;

-- Description of the table
DESC ME_SALES;

-- Checking if quantity values are correct
select *
from ME_SALES
WHERE QUANTITY= null;  

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT SALES_ID || '-' || SALES_DATE || '-' || QUANTITY|| '-' ||UNIT_SALES_PRICE || '-' || EQUIPMENT_ID || '-' ||TOTAL_SALES_PRICE|| '-' || CUSTOMER_ID || '-' ||STAFF_ID)
 AS DUPLICATES
FROM ME_SALES;

-- deleting
DELETE FROM ME_SALES
WHERE SALES_ID = 151;

-- checking the multiplication
SELECT *
FROM ME_SALES
WHERE (quantity * unit_sales_price) <> total_sales_price;


---------------------------------------- STAFF TABLE

-- Creating a duplicate table
Create table ME_STAFF as
Select * 
From MonEquip.STAFF;

-- Viewing the table as whole 
SELECT *
FROM ME_STAFF;

-- Description of the table
DESC ME_STAFF;

-- Looking for duplicates
SELECT COUNT(*) - COUNT(DISTINCT STAFF_ID || '-' || FIRST_NAME || '-' || LAST_NAME|| '-' ||GENDER || '-' ||PHONE|| '-' ||EMAIL|| '-' || COMPANY_BRANCH)
 AS DUPLICATES
FROM ME_STAFF;

--------------- DATA CLEANING DONE ------------------

select * from ME_CATEGORY;
select * from ME_EQUIPMENT;
select * from ME_CUSTOMER;
select * from ME_STAFF;
select * from ME_ADDRESS;
select * from ME_SALES;
select * from ME_HIRE;

-------------- IMPLEMENTING STAR SCHEMA ----------------

----- TIME DIMENSION -----

--drop table--
drop table TimeDIM;

-- creating the table --
create table TimeDIM as
select 
    row_number() over (order by date_value) as time_id,
    extract(year from date_value) as year,
    extract(month FROM date_value) as month,
    case
        when extract(month from date_value) between 9 and 11 then 'Spring'
        when extract(month from date_value) in (12,1,2) then 'Summer'
        when extract(month from date_value) between 3 and 5 then 'Autumn'
        when extract(month from date_value) between 6 and 8 then 'Winter'
    end as season
from (
select distinct ME_SALES.SALES_DATE as date_value from me_sales
union
select distinct ME_HIRE.START_DATE as date_value from me_hire); 

select * from TimeDIM;

----- STAFF DIMENSION -----

-- drop table --
drop table StaffDIM;

-- creating the table --
create table StaffDIM as
select staff_id, company_branch 
from me_staff;

select * from StaffDIM;

----- CATEGORY DIMENSION -----

-- drop table --
drop table CategoryDIM;

-- creating the table --
create table CategoryDIM as
select category_id, category_description
from me_category;

select * from CategoryDIM;

----- CUSTOMER DIMENSION -----

-- drop table --
drop table CustomerTypeDIM;

-- create table --
create table CustomerTypeDIM as
select customer_type_id as CustomerTypeID, description AS Description
from me_customertype;

select * from CustomerTypeDIM;

----- SALES SCALE DIMENSION -----

--drop table --
drop table SalesScaleDIM;

-- create table --
create table SalesScaleDIM(
    ScaleID NUMBER PRIMARY KEY,
    ScaleDesc VARCHAR2(100)
);

select * from SalesScaleDIM;
-- inserting the values given in the brief --
insert into SalesScaleDIM(ScaleID, ScaleDesc)
VALUES (1, 'Low Sales (Below $5000)');
insert into SalesScaleDIM(ScaleID, ScaleDesc)
VALUES (2, 'Medium Sales ($5000 - $10000)');
insert into SalesScaleDIM(ScaleID, ScaleDesc)
VALUES (3, 'High Sales (Above $10000)');

----- SALES FACT TABLE -----

-- drop table --
drop table SalesFACT;

-- creating table --
create table SalesFACT as
select 
    e.category_id,
    s.staff_id,
    t.time_id,
    case
        when s.total_sales_price < 5000 then 1
        when s.total_sales_price between 5000 and 10000 then 2
        else 3
    end as scale_id,
    sum(s.total_sales_price) as total_sales_revenue,
    sum(s.quantity) as total_equipments_sold
from me_sales s
join me_equipment e
    on s.EQUIPMENT_ID = e.EQUIPMENT_ID
join TimeDIM t 
    on extract(year from s.sales_date)= t.year
    and extract(month from s.sales_date)= t.month
group by
    e.category_id,
    s.staff_id,
    t.time_id,
    case
        when s.total_sales_price < 5000 then 1
        when s.total_sales_price between 5000 and 10000 then 2
        else 3
    end;

select * from SalesFACT where scale_id=2;

----- HIRE FACT TABLE -----

-- drop table --
drop table HireFACT;

-- creating table --
create table HireFACT as
select
    e.category_id,
    h.staff_id,
    t.time_id,
    ct.customer_type_id,
    sum(h.total_hire_price) as total_hire_revenue,
    sum(h.quantity) as total_equipments_hired
from me_hire h
join me_equipment e
    on h.EQUIPMENT_ID = e.EQUIPMENT_ID
join TimeDIM t 
    on extract(year from h.start_date)= t.year
    and extract(month from h.start_date)= t.month
join me_customer c
    on h.customer_id = c.customer_id
join ME_CustomerType ct
    on c.customer_type_id = ct.customer_type_id
group by
    e.category_id,
    h.staff_id,
    t.time_id,
    ct.customer_type_id;

----- STAR SCHEMA COMPLETED -----

-- Dimension Tables --
select * from TimeDIM;
SELECT 
    column_name,
    data_type,
    nullable,
    data_default,
    column_id
FROM user_tab_columns
WHERE table_name = 'SALESFACT'  -- write table name in UPPERCASE
ORDER BY column_id;

select * from StaffDIM;
select * from CategoryDIM;
select * from CustomerTypeDIM;
select * from SalesScaleDIM;

-- Fact Tables --
select * from SalesFACT;
select * from HireFACT;

----- OLAP QUERIES -----
-- OLAP Operation: Equipments hired and sold per branch --
SELECT
    s.company_branch,
    NVL(SUM(sf.total_sold), 0) AS total_sold,
    NVL(SUM(hf.total_hired), 0) AS total_hired
FROM StaffDIM s
LEFT JOIN (
    SELECT staff_id, SUM(total_equipments_sold) AS total_sold
    FROM SalesFact
    GROUP BY staff_id
) sf ON s.staff_id = sf.staff_id
LEFT JOIN (
    SELECT staff_id, SUM(total_equipments_hired) AS total_hired
    FROM HireFact
    GROUP BY staff_id
) hf ON s.staff_id = hf.staff_id
GROUP BY s.company_branch;

-- OLAP Operation : Selling Revenue  by year
SELECT 
    t.year,
    SUM(sf.total_sales_revenue) AS total_sales_revenue,
    ROUND(
        SUM(sf.total_sales_revenue) * 100 /
        SUM(SUM(sf.total_sales_revenue)) OVER(),
        2
    ) AS percentage_contribution
FROM SalesFact sf
JOIN TimeDIM t 
    ON sf.time_id = t.time_id
GROUP BY t.year
ORDER BY t.year;

-- OLAP Operation : Hiring Revenue by year
SELECT 
    t.year,
    SUM(hf.total_hire_revenue) AS total_hire_revenue,
    ROUND(
        SUM(hf.total_hire_revenue) * 100 /
        SUM(SUM(hf.total_hire_revenue)) OVER(),
        2
    ) AS percentage_contribution
FROM HireFACT hf
JOIN TimeDIM t 
    ON hf.time_id = t.time_id
GROUP BY t.year
ORDER BY t.year;

-- OLAP Operation : Hire Revenue by Category
SELECT 
    c.category_description,
    SUM(hf.total_hire_revenue) AS total_hire_revenue,
    ROUND(
        SUM(hf.total_hire_revenue) * 100 /
        SUM(SUM(hf.total_hire_revenue)) OVER(),
        2
    ) AS percentage_contribution
FROM HireFact hf
JOIN CategoryDIM c 
    ON hf.category_id = c.category_id
GROUP BY c.category_description
ORDER BY total_hire_revenue DESC;

-- OLAP Operation : Sales Revenue by Category
SELECT 
    c.category_description,
    SUM(sf.total_sales_revenue) AS total_sales_revenue,
    ROUND(
        SUM(sf.total_sales_revenue) * 100 /
        SUM(SUM(sf.total_sales_revenue)) OVER(),
        2
    ) AS percentage_contribution
FROM SalesFact sf
JOIN CategoryDIM c 
    ON sf.category_id = c.category_id
GROUP BY c.category_description
ORDER BY total_sales_revenue DESC;




