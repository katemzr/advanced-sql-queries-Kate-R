/*Pasted in from Lesson 2*/
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

select * from customers;
select * from orders;

/*find the total amount spent by each customer*/
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

/*show the total amount spent by each customer on each order date*/
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

/*the total amount spent by each customer, but only include orders that are greater than $200 in the grouping*/
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;

/*show the total amount spent by each customer, but only include customers who have spent more than $200 in total*/
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 200;

/*show all the orders, but also include the customer's first and last name - use INNER JOIN to join two tables*/
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

/*show all the orders, but also include the customer's first and last name - use LEFT JOIN to join two tables*/
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

/*return all orders where the total_amount is greater than or equal to the average total_amount of all orders*/
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount)FROM orders);

/*return all orders where the customer_id is in the list of id values of customers with the last name 'Smith'*/
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

/*return all the order_date values from the orders table*/
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;
