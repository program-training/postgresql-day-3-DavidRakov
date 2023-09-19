-- Active: 1694601121833@@127.0.0.1@5432@northwind@public

-- שאלה 1
SELECT DISTINCT c.contact_name,o.customer_id
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- שאלה 2
SELECT c.contact_name,count(o.order_id) as count_of_orders
FROM customers AS c
RIGHT JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING count(o.order_id) > 10

-- שאלה 3
SELECT product_id,product_name,unit_price
FROM products
WHERE unit_price > (SELECT avg(unit_price) FROM products)


SELECT country,count(country)
FROM customers
GROUP BY country
HAVING count(country) > 5


SELECT c.customer_id,c.contact_name,c.country
FROM customers as c LEFT JOIN orders as o on c.customer_id = o.customer_id
and extract(YEAR from o.order_date) = 1998
WHERE o.customer_id IS NULL


SELECT c.customer_id,c.contact_name,c.country
FROM customers as c LEFT JOIN orders as o on c.customer_id = o.customer_id
and o.order_date > '01-01-1998'
WHERE o.customer_id IS NULL AND c.country = 'USA'

SELECT c.customer_id,COUNT(o.order_id)
FROM customers as c INNER JOIN orders as o on c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 3

SELECT p.supplier_id,s.country,count(p.supplier_id)
FROM products as p
INNER JOIN suppliers as s ON p.supplier_id = s.supplier_id
AND s.country = 'USA'
GROUP BY p.supplier_id,s.country
HAVING count(p.supplier_id) > 1

