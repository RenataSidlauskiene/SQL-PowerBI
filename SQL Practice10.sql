use salesdatawalmark;

create database if not exists SalesDataWalmark; 

create table if not exists Sales(
invoice_ID varchar(30) not null primary key,
Branch varchar(10) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10, 2) not null,
quantity int not null,
VAT float(6, 4) not null,
Total decimal (12, 4) not null,
Date Datetime not null,
time Time not null,
payment_metod varchar(15) not null,
cogs Decimal(10,2) not null,
gross_margin_pct float(11,9) not null,
gross_income decimal(10, 2) not null,
rating float(2, 1))
;

-- --------------------------------------------------------------------------------------------------
-- Feature Engineering

-- Adding new column -  Time of day

select
   time,
   (case
       when time between '00:00:00' and '12:00:00' then 'Morning'
       when time between '12:01:00' and '16:00:00' then 'Afternoon'
       Else 'Evening'
   End
   ) as time_of_day
from sales;

Alter table sales add column time_of_day varchar(20);

Update sales 
set time_of_day = (
   case
       when time between '00:00:00' and '12:00:00' then 'Morning'
       when time between '12:01:00' and '16:00:00' then 'Afternoon'
       Else 'Evening'
   End
);

-- adding Month name column

select
   Date,
   Left(Monthname(Date), 3) as Month_name
from sales
Order by Date;

alter table sales add column Month_name varchar(10);

update sales 
   set Month_name= Left(Monthname(Date), 3);
   
  -- adding Day name column  
  
select
     date,
     dayname(date) as day_name
from sales;

alter table sales add column day_name varchar(20);

update sales
   set day_name = dayname(date);
   
   
-- ---------------------------------------------------------------------------------------------------
-- GENERIC

-- 1.How many unique cities does the data have?

select
   distinct city
from sales;

-- Which branch is located in which country?
select
   distinct city,
   Branch
from sales;


-- PRODUCT --------------------------------------------------------------------------------------------
-- How many unique product lines does the data have?

select
    distinct product_line
from sales;


select
    count(distinct product_line)  -- It shows only the total count of unique values.
from sales;

-- what is the most common payment method?

select 
   payment_metod,
   count(payment_metod) as cnt
from sales
group by payment_metod
order by cnt desc;


-- what is the total revenue by month?
select 
    Month_name as Month,
    sum(Total) as total_revenue
from sales
Group by Month
Order by total_revenue desc;

-- What Month had the largest COGS(Cost of Goods Sold)?
select 
   Month_name as Month,
   sum(COGS) as cogs_sum
from sales
group by Month
order by cogs_sum desc;

-- What product line had the largest revenue?
select
   product_line,
   sum(Total) as Total_revenue
from sales
group by product_line
order by Total_revenue desc;
     
-- What is the city with the largest revenue?    
select
   branch,
   city,
   sum(Total) as Total_revenue
from sales
group by city, branch
order by Total_revenue desc;

-- What product line had the largest VAT?
select
   product_line,
   avg(VAT) as avg_tax
from sales
group by product_line
order by avg_tax desc;

-- Fetch each product line and add the column to those product line showing 'Good', 'Bad'. 
-- 'Good' if its greater than average sales.

select 
   avg(Total) as average_sales
from sales;

Select 
   product_line,
   Total as sales_amount,
  case 
    when Total > (select avg(Total)from sales) then 'Good' 
    else 'Bad'
  end as line_showing
from sales
order by sales_amount desc;

-- Which branch sold more products than average product sold?

SELECT 
   branch,
   SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) from sales); 


-- what is the most common product line by gender?

select
   gender,
   product_line,
   count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt desc;
   
-- what is the average rating of each product line?

select 
   product_line,
   round(avg(rating),2) as avg_rating
from sales
Group by product_line
order by avg_rating desc;


-- ----------------------------------------------------------------------------------------------------
-- SALES-----------------

-- Number of sales made in each time of the day per weekday?

select 
   time_of_day,
   count(*) as total_sales
from sales
group by time_of_day
order by total_sales desc;


select 
   time_of_day,
   count(*) as total_sales
from sales
where day_name = 'Tuesday'
group by time_of_day
order by total_sales desc;


-- Which of the customer types brings the most revenue?

select
   customer_type,
   sum(Total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

-- which city has the largest tax percent/ VAT (Value Added Tax)?

select
   city,
   avg(VAT) as VAT
from sales
group by city
order by VAT desc;

-- Which customer type pays the most in VAT
select
   customer_type,
   sum(VAT) as VAT
from sales
group by customer_type
order by VAT desc;

-- --------------------------------------------------------------------------------------------------
-- Customers------------------------

-- How many unique cusmomer types does the data have?

select 
   distinct customer_type
from sales;

-- How many uniques payment methods does the data have?

select 
   distinct payment_metod
from sales;

-- What is the most common customer type?

select 
   customer_type,
   count(customer_type) as cust_cnt
from sales
group by customer_type
order by cust_cnt desc;

-- Which customer type buys the most?

select 
   customer_type,
   count(*) as cust_cnt
from sales
group by customer_type;

-- What is the gender of most of the customers?

select
   gender,
   count(*) as gender_count
from sales
group by gender;


-- What is the gender distribution per branch?

select
   Branch,
   gender,
   count(gender) as count_gender
from sales
group by Branch, gender
order by Branch, count_gender;

select
   gender,
   count(*) as count_gender
from sales
where branch = 'A'
group by gender
order by count_gender;

 -- Which time of the day do customers give most ratings?
 
 select
    time_of_day,
    count(rating) as rating_count
 from sales
 group by time_of_day
 order by rating_count desc;
 
 
  select
    time_of_day,
    round(avg(rating),2) as avg_rating
 from sales
 group by time_of_day
 order by avg_rating desc;
 
 -- Which time of the day do customers give most ratings per branch?
 
 select
    branch,
    time_of_day,
    count(rating) as rating_count
 from sales
 group by branch,time_of_day
 order by branch,rating_count desc; 
 
 
 select
    branch,
    time_of_day,
    avg(rating) as avg_rating
 from sales
 group by branch,time_of_day
 order by branch,avg_rating desc; 
 
 
  select
    time_of_day,
    avg(rating) as avg_rating
 from sales
 where branch = 'A'
 group by time_of_day
 order by avg_rating desc; 
 
 -- Which day for the week has the best avg rating?

select
   day_name,
   avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;

-- Which day for the week has the best avg ratings per branch?

select
   branch,
   day_name,
   avg(rating) as avg_rating
from sales
group by day_name, branch
order by branch, avg_rating desc;

select
   day_name,
   avg(rating) as avg_rating
from sales
where branch = 'A'
group by day_name
order by avg_rating desc;

-- ---------------------------------------------------------------------------------------------------
-- Revenue And Profit Calculations -----------

-- Number of sales made in each time of the day per weekday 

select
    time_of_day,
    count(Total) as sales_count
from sales
where day_name = 'Monday'
group by time_of_day
order by sales_count desc;
    
    
-- Evenings experience most sales, the stores are filled during the evening hours

-- Which of the customer types brings the most revenue?

select
    customer_type,
    sum(Total) as sum_revenue
from sales
group by customer_type
order by sum_revenue desc;


-- Which city has the largest tax/VAT percent?

select
   City,
   avg(VAT) avg_VAT
from sales
group by City
order by avg_VAT desc;


-- Which customer type pays the most in VAT?

SELECT
	customer_type,
	AVG(VAT) AS avg_VAT
FROM sales
GROUP BY customer_type
ORDER BY  avg_VAT;
