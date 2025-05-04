-- Create the initial database
CREATE DATABASE IF NOT EXISTS sampledb;

-- Specify database to use
USE sampledb;

-- CREATE TABLE 1
CREATE TABLE productDetails (
	orderID INT, 
    CustomerName VARCHAR (50),
    Products VARCHAR(255)
    );

-- Insert values into product detail table

INSERT INTO productDetails(orderID, CustomerName, Products)
VALUES  (101, 'John Doe', 'Laptop, Mouse'),
		(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
        (103, 'Emily Klark', 'Phone');
        
SELECT * FROM productDetails;  -- View the created table

-- CREATE TABLE 2
CREATE TABLE orderDetails (
	orderID INT, 
    CustomerName VARCHAR (50),
    Products VARCHAR(255),
    Quantity INT
    );

-- Insert values into OrderDetails table

INSERT INTO orderDetails(orderID, CustomerName, Products, Quantity)
VALUES  (101, 'John Doe', 'Laptop', 2),
		(101, 'John Doe', 'Mouse', 1),
		(102, 'Jane Smith', 'Tablet', 3),
        (102, 'Jane Smith', 'Keyboard', 1),
        (102, 'Jane Smith', 'Mouse', 2),
        (103, 'Emily Klark', 'Phone', 1);

SELECT * FROM orderDetails;
        
-- Question 1: Write an SQL query to transform table 1 into 1NF, ensuring that each row represents a single product for an order

SELECT OrderID, CustomerName, 'Laptop' AS Product FROM productdetails
WHERE Products LIKE '%Laptop%'

UNION

SELECT OrderID, CustomerName, 'Mouse' AS Product FROM productdetails
WHERE Products LIKE '%Mouse%'

UNION

SELECT OrderID, CustomerName, 'Tablet' AS Product FROM productdetails
WHERE Products LIKE '%Tablet%'

UNION

SELECT OrderID, CustomerName, 'Keyboard' AS Product FROM productdetails
WHERE Products LIKE '%Keyboard%'

UNION

SELECT OrderID, CustomerName, 'Phone' AS Product FROM productdetails
WHERE Products LIKE '%Phone%';

-- Question 2: Write an SQL query to transform this table into 2NF by removing partial dependencies. 
-- 				Ensure that each non-key column fully depends on the entire primary key.


-- Step 1: Create an Orders table that stores OrderID and CustomerName (removing partial dependency).

CREATE TABLE orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
-- Populate Orders table

INSERT INTO orders (orderID, CustomerName)
SELECT DISTINCT orderID, CustomerName
FROM orderdetails;

SELECT * FROM orders;  -- View table

-- Step 2: Create an OrderItems table with OrderID, Product, and Quantity where all non-key columns depend on the full composite key

CREATE TABLE orderItems (
    OrderID INT,
    Products VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (orderID, Products),
    FOREIGN KEY (orderID) REFERENCES orders(orderID)
);

-- Populate OrderItems table
INSERT INTO orderItems (orderID, Products, Quantity)
SELECT orderID, Products, Quantity
FROM orderdetails;

SELECT * FROM orderItems;    -- View table
