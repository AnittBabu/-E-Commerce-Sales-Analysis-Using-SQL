create database Superstore1
use Superstore1;
--table 1 customers
create table customers(customer_id INT primary key,
customer_name VARCHAR(100), Gender VARCHAR(20),
City VARCHAR(50),State VARCHAR(50))
--table2 products
create table products (product_id INT PRIMARY KEY,
product_name VARCHAR(150),category VARCHAR(100),
sub_category VARCHAR(100),price DECIMAL(10,2))
--table3 orders
CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT,
order_date DATE, ship_date DATE, payment_method VARCHAR(50),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id))
--table4 order_item
CREATE TABLE order_items (order_item_id INT PRIMARY KEY,
order_id INT, product_id INT, quantity INT,
sales_amount DECIMAL(10,2), Profit DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id))
select * from customers
desc customers
select * from products
desc products
select * from orders
desc orders
select * from order_items
desc order_items
desc customers1
select * from customers1
alter table customers1 modify column customer_id varchar(15) primary key,
modify column customer_name VARCHAR(100), modify column gender VARCHAR(20),
modify column city VARCHAR(50),modify column state VARCHAR(50)
desc products1
alter table products1 modify column product_id varchar(15) PRIMARY KEY,
modify column product_name VARCHAR(150),modify column category VARCHAR(100),
modify column sub_category VARCHAR(100),modify column price DECIMAL(10,2)
desc orders1
alter table orders1 modify column order_id varchar(15) PRIMARY KEY, 
modify column customer_id varchar(30), modify column order_date DATE,
modify column ship_date DATE,modify column payment_method VARCHAR(50)
alter table orders1 add constraint foreign key(customer_id)
references customers1(customer_id) on delete cascade
desc order_items2
select * from order_items2
alter table order_items2 modify column order_item_id INT PRIMARY KEY,
modify column order_id varchar(15), 
modify column product_id varchar(30), 
modify column quantity INT,
modify column sales_amount DECIMAL(10,2),
modify column  Profit DECIMAL(10,2)
alter table order_items2 add constraint foreign key(order_id)
references orders1(order_id) on delete cascade, 
add constraint foreign key(product_id)
references products1(product_id) on delete cascade


--part1
--1find total no. of sales
select count(sales_amount) as total_sales from order_items2
--find total no. of customers
select count(customer_id) as total_customers from customers1
--find total orders
select count(order_id) as total_orders from orders1
--average sales amount
select avg(sales_amount) as average_sales from order_items2
--highest sales
select max(sales_amount) as highest_sales from order_items2
--lowerst sales
select min(sales_amount) as lowest sales from order_items2
--part2
--1.Find category-wise sales.
select p.category, sum(oi.sales_amount) as total_sales from order_items2 oi
join products p on oi.product_id = p.product_id group by p.category
--2.Find region-wise profit.      
select c.state, sum(oi.profit) as total_profitby_region 
from  customers1 c
join orders1 o on c.customer_id = o.customer_id
join order_items2 oi on o.order_id = oi.order_id group by c.state
--3.Find state-wise order count.
select c.state, count(o.order_id) as ordewer_count from customers1 c
JOIN orders1 o ON c.customer_id = o.customer_id
GROUP BY c.state;
--4.Find top 5 customers by sales.
SELECT c.customer_name, SUM(oi.sales_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;
--5.Find least profitable categories.
SELECT p.category, SUM(oi.profit) AS total_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_profit ASC;

--part3
-- 1. Display customer orders with product details
SELECT o.order_id, c.customer_name, p.product_name, oi.quantity, oi.sales_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- 2. Find products sold in each region (State)
SELECT DISTINCT c.state, p.product_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY c.state;
--part4
-- 1. Classify customers (High, Medium, Low Value)
SELECT customer_id, SUM(sales_amount) AS total_purchase,
CASE 
    WHEN SUM(sales_amount) > 10000 THEN 'High Value'
    WHEN SUM(sales_amount) BETWEEN 5000 AND 10000 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_category
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY customer_id;

-- 2. Classify products (High Profit, Low Profit, Loss)
SELECT product_id, SUM(profit) AS total_profit,
CASE 
    WHEN SUM(profit) > 1000 THEN 'High Profit'
    WHEN SUM(profit) BETWEEN 0 AND 1000 THEN 'Low Profit'
    ELSE 'Loss'
END AS profit_category
FROM order_items
GROUP BY product_id;
--part 5
-- 1. Find products with above-average sales
SELECT product_id, SUM(sales_amount) AS total_sales
FROM order_items
GROUP BY product_id
HAVING SUM(sales_amount) > (SELECT AVG(sales_amount) FROM order_items);

-- 2. Find second highest selling product
SELECT product_id, SUM(sales_amount) AS total_sales
FROM order_items
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 1 OFFSET 1;
--part6
-- 1. Rank customers based on sales
SELECT customer_id, SUM(sales_amount) AS total_sales,
RANK() OVER(ORDER BY SUM(sales_amount) DESC) as sales_rank
FROM orders o 
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY customer_id;

-- 2. Find top 3 products in each category
SELECT category, product_name, total_sales
FROM (
    SELECT p.category, p.product_name, SUM(oi.sales_amount) AS total_sales,
    DENSE_RANK() OVER(PARTITION BY p.category ORDER BY SUM(oi.sales_amount) DESC) as rnk
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
) ranked_products
WHERE rnk <= 3;

-- 3. Calculate running total sales
SELECT order_date, sales_amount,
SUM(sales_amount) OVER(ORDER BY order_date) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

