
-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    City VARCHAR(30)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Category VARCHAR(30)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data into Customers
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', 'Mumbai'),
(2, 'Bob', 'bob@example.com', 'Delhi'),
(3, 'Charlie', 'charlie@example.com', 'Pune');

-- Insert sample data into Products
INSERT INTO Products VALUES
(101, 'Laptop', 60000.00, 'Electronics'),
(102, 'Mobile Phone', 20000.00, 'Electronics'),
(103, 'Book', 500.00, 'Stationery');

-- Insert sample data into Orders
INSERT INTO Orders VALUES
(1001, 1, '2025-04-01'),
(1002, 2, '2025-04-02'),
(1003, 1, '2025-04-05');

-- Insert sample data into OrderDetails
INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 103, 5);

-- Basic SELECT
SELECT * FROM Customers;

-- JOIN query
SELECT c.Name, p.ProductName, od.Quantity, o.OrderDate
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON od.ProductID = p.ProductID;

-- GROUP BY with SUM
SELECT c.City, SUM(p.Price * od.Quantity) AS TotalSpending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.City;

-- Subquery: Find customers who ordered more than 3 books
SELECT DISTINCT c.Name
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE od.ProductID = 103 AND od.Quantity > 3;

-- UPDATE: Change price of book
UPDATE Products
SET Price = 550.00
WHERE ProductID = 103;

-- DELETE: Remove a customer from Pune
DELETE FROM Customers
WHERE City = 'Pune';
