-- Active: 1694601121833@@127.0.0.1@5432@northwind@public
SELECT * from orders

SELECT e.first_name||' '||e.last_name as Full_Name , count(o.order_id) as "number of orders "
FROM employees as e INNER JOIN orders as o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY count(o.order_id) DESC


SELECT c.category_name ,SUM(od.quantity * od.unit_price * (1-od.discount)) 
FROM categories as c INNER JOIN products as p on c.category_id = p.category_id
INNER JOIN order_details as od ON p.product_id = od.product_id
GROUP BY c.category_id
ORDER BY sum DESC

SELECT c.contact_name, AVG(sum_of_order) AS avg_order_per_customer
FROM (
  SELECT o.order_id, o.customer_id, SUM(od.quantity * od.unit_price * (1 - od.discount)) AS sum_of_order
  FROM orders AS o
  INNER JOIN order_details AS od ON o.order_id = od.order_id
  GROUP BY o.order_id
) AS customer_orders
INNER JOIN customers AS c ON customer_orders.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY avg_order_per_customer DESC;


-- שאלה 4, הצגה עם הסכום
SELECT c.contact_name, sum(od.quantity * od.unit_price * (1-od.discount)) as sum_of_order
from customers as c INNER JOIN orders as o ON c.customer_id = o.customer_id
INNER JOIN order_details as od ON o.order_id = od.order_id
GROUP BY c.contact_name
ORDER BY sum_of_order DESC
LIMIT 10

-- הצגה ללא הסכום
SELECT c.contact_name
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN order_details AS od ON o.order_id = od.order_id
GROUP BY c.contact_name
ORDER BY SUM(od.quantity * od.unit_price * (1 - od.discount)) DESC
LIMIT 10



SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS order_month,
       SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total_order_amount
FROM order_details AS od
INNER JOIN orders AS o ON o.order_id = od.order_id 
GROUP BY order_month
ORDER BY order_month

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < 10

SELECT c.contact_name, max(sum_of_order) AS high_order_per_customer
FROM (
  SELECT o.order_id, o.customer_id, SUM(od.quantity * od.unit_price * (1 - od.discount)) AS sum_of_order
  FROM orders AS o
  INNER JOIN order_details AS od ON o.order_id = od.order_id
  GROUP BY o.customer_id, o.order_id
) AS customer_orders
INNER JOIN customers AS c ON customer_orders.customer_id = c.customer_id
GROUP BY c.customer_id, c.contact_name
ORDER BY high_order_per_customer DESC
LIMIT 1


SELECT o.ship_country,sum(od.quantity * od.unit_price * (1 - od.discount)) AS order_sum
FROM order_details as od
INNER JOIN orders as o ON o.order_id = od.order_id
GROUP BY ship_country
ORDER BY order_sum DESC
LIMIT 1


SELECT ship_name ,count(*) FROM orders
GROUP BY ship_name
ORDER BY count DESC
LIMIT 1

SELECT p.product_name ,count(od.product_id)
FROM products as p 
INNER JOIN order_details as od on od.product_id = p.product_id
GROUP BY p.product_id
HAVING count(od.product_id) = 0
