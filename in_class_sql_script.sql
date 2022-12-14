CREATE TABLE salesman
(salesman_id INT PRIMARY KEY, 
name VARCHAR(20),
city VARCHAR(20),
commission DOUBLE);

INSERT INTO salesman
(salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15);

INSERT INTO salesman
(salesman_id, name, city, commission)
VALUES
(5002, 'Nail Knite', 'Paris', 0.13);

INSERT INTO salesman
(salesman_id, name, city, commission)
VALUES
(5005, 'Pit Alex', 'London', 0.11);

INSERT INTO salesman
(salesman_id, name, city, commission)
VALUES
(5006, 'Mc Lyon', 'Paris', 0.14);

INSERT INTO salesman
(salesman_id, name, commission)
VALUES
(5003,'Lauson Hen', 0.12);

INSERT INTO salesman
(salesman_id, name, city, commission)
VALUES
(5007, 'Paul Adam', 'Rome', 0.13);

-- Q1: Retrieve the data in the name and city columns in the salesman table
SELECT salesman.name, salesman.city
FROM salesman;

-- Q2: Retrieve the entire contents of the salesman table
SELECT *
FROM salesman;

-- Q3: For salesman table, show the name and commission columns and a column showing commission increased by 10%
SELECT name, commission, commission*1.1
FROM salesman;


CREATE TABLE customer 
(customer_id INT(4) PRIMARY KEY,
cust_name VARCHAR(20),
city VARCHAR(20),
grade INT(4),
salesman_id INT(4) REFERENCES salesman(salesman_id));

INSERT INTO customer
(customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007);

-- Q4: For the custimer table, retrieve the name, city, and grade of each customer whose grade is above 200
SELECT cust_name, city, grade
FROM customer
WHERE grade>200;

-- Q5: For the customer table, retrieve the name, city, and grade of each customer whose city is different from Berline and grade is less than or equal to 200
SELECT cust_name, city, grade
FROM customer
WHERE city<>'Berlin' AND grade<=200;

-- Q6: For the customer table, retrieve the name, city, and grade of each customer whose name contains 'an'
SELECT cust_name, city, grade
FROM customer
WHERE cust_name LIKE '%an%';

-- Q7: Retrieve distinct salesman IDs in the customer table 
SELECT DISTINCT salesman_id
FROM customer;

-- Q8: Retrieve distinct pairs of salesman ID and city in the customer table
SELECT DISTINCT salesman_id, city
FROM customer;

-- Q9: For the customer table, retrieve the customer ID, name, city, and grade, sorted by grade in the ascending order
SELECT customer_id, cust_name, city, grade
FROM customer
ORDER BY grade;

-- Q10: For the customer table, retrieve the customer ID, name, city, and grade, sorted by grade in the descending order
SELECT customer_id, cust_name, city, grade
FROM customer
ORDER BY grade DESC;

-- Q11: For the customer table, retrieve the customer ID, name, city, and grade, sorted by grade, and  within the same grade, by customer name
SELECT customer_id, cust_name, city, grade
FROM customer
ORDER BY grade, cust_name;


CREATE TABLE salesorder
(order_no INT(5) PRIMARY KEY,
purch_amt DOUBLE,
ord_date DATE,
customer_id INT(4) REFERENCES customer (customer_id),
salesman_id INT(4) REFERENCES salesman (salesman_id));


-- How to delete table info, pick a value and do all values from it  
-- DELETE FROM salesorder
-- WHERE order_no>70000;


INSERT INTO salesorder
(order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.5, DATE('2012-10-05'), 3005, 5002),
(70009, 270.65, DATE('2012-09-10'), 3001, 5005),
(70002, 65.26, DATE('2012-10-05'), 3002, 5001),
(70004, 110.5, DATE('2012-08-17'), 3009, 5003),
(70007, 948.5, DATE('2012-09-10'), 3005, 5002),
(70005, 2400.6, DATE('2012-07-27'), 3007, 5001),
(70008, 5760, DATE('2012-09-10'), 3002, 5001),
(70012, 250.45, DATE('2012-06-27'), 3008, 5002),
(70011, 75.29, DATE('2012-08-17'), 3003, 5007),
(70013, 3045.6, DATE('2012-04-25'), 3002, 5001); 

--Q12: For the salesorder table, show how many orders there are
SELECT COUNT(*)
FROM salesorder;

--Q13: Retrieve the average purchase amount of all orders
SELECT AVG(purch_amt)
FROM salesorder;

--Q14: Retrieve the total number, average purchase amount, lowest purchase amount, and highest purchase amount of the orders after September 2012
SELECT COUNT(*), AVG(purch_amt), MIN(purch_amt), MAX(purch_amt)
FROM salesorder
WHERE ord_date>='2012-10-01';

--Q15: For each salesman, retrieve the salesman ID and the average purchase amount of the orders sold by the salesman
SELECT salesman_id, AVG(purch_amt)
FROM salesorder
GROUP BY salesman_id;

--Q16: For each salesman, retrieve the number and average purchase amount of the orders sold by the salesman
SELECT salesman_id, COUNT(*), AVG(purch_amt)
FROM salesorder
GROUP BY salesman_id;

--Q17: For each salesman, retrieve the salesman ID and the number of the orders with a purchase amount higher than $200 sold by the salesman
SELECT salesman_id, COUNT(*)
FROM salesorder
WHERE purch_amt>200
GROUP BY salesman_id;

--Q18: For each group of orders of the same customer and salesman, retrieve the customer ID, salesman ID, total number of orders, and average purchase amount
SELECT customer_id, salesman_id, COUNT(*), AVG(purch_amt)
FROM salesorder
GROUP BY customer_id, salesman_id;

--Q19: For each group of orders of the same customer and salesman that contains more than one order, retrieve the customer ID, salesman ID, and average purchase amount
SELECT customer_id, salesman_id, AVG(purch_amt)
FROM salesorder
GROUP BY customer_id, salesman_id
HAVING COUNT(*)>1;

--Q20: For each group of more than one order that has the same customer and salesman, and the purchase amount is greater than 100, retrieve the customer ID, salesman ID, and average purchase amount
SELECT customer_id, salesman_id, AVG(purch_amt)
FROM salesorder
WHERE purch_amt>100
GROUP BY customer_id, salesman_id
HAVING COUNT(*)>1;

--Q21: For each salesman who has an order with the purchase amount greater than 150, retrieve the salesman ID and sum of purchase amount of the orders sold by the salesman
SELECT salesman_id, SUM(purch_amt)
FROM salesorder
GROUP BY salesman_id
HAVING MAX(purch_amt)>150;

--Q21A: For each salesman who has ALL order purchase amounts greater than 150, retrieve the salesman ID and sum of purchase amount of the orders sold by the salesman
SELECT salesman_id, SUM(purch_amt)
FROM salesorder
GROUP BY salesman_id
HAVING MIN(purch_amt)>150;

9/19