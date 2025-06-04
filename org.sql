
CREATE SCHEMA onlineshopping;

CREATE TABLE onlineshopping.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender Varchar(30),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
   
);


CREATE TABLE onlineshopping.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


CREATE TABLE onlineshopping.Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    EmployeeID INT,
    SaleDate DATE,
    Quantity INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES market.Products(ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES market.Employees(EmployeeID)
);
CREATE TABLE onlineshopping.Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    EmployeeID INT,
    SaleDate DATE,
    Quantity INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES mar.Products(ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES mar.Employees(EmployeeID)
);
DROP TABLE IF EXISTS onlineshopping.Sales;

CREATE table if not exists  onlineshopping.Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    EmployeeID INT,
    SaleDate DATE,
    Quantity INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES mar.Products(ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES mar.Employees(EmployeeID)
);

INSERT INTO onlineshopping.Employees (EmployeeID, FirstName, LastName, Gender, Department, HireDate, Salary) VALUES
(1, 'John', 'Doe', 'Male', 'IT', '2018-05-01', 60000.00),
(2, 'Jane', 'Smith', 'Female', 'HR', '2019-06-15', 50000.00),
(3, 'Michael', 'Johnson', 'Male', 'Finance', '2017-03-10', 75000.00),
(4, 'Emily', 'Davis', 'Female', 'IT', '2020-11-20', 70000.00),
(5, 'Sarah', 'Brown', 'Female', 'Marketing', '2016-07-30', 45000.00),
(6, 'David', 'Wilson', 'Male', 'Sales', '2019-01-05', 55000.00),
(7, 'Chris', 'Taylor', 'Male', 'IT', '2022-02-25', 65000.00);


INSERT INTO onlineshopping.Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Desk', 'Furniture', 300.00, 50),
(3, 'Chair', 'Furniture', 150.00, 200),
(4, 'Smartphone', 'Electronics', 800.00, 75),
(5, 'Monitor', 'Electronics', 250.00, 40),
(6, 'Bookshelf', 'Furniture', 100.00, 60),
(7, 'Printer', 'Electronics', 200.00, 25);
INSERT INTO onlineshopping.Sales (SaleID, ProductID, EmployeeID, SaleDate, Quantity, Total) VALUES
(1, 1, 1, '2021-01-15', 2, 2400.00),
(2, 2, 2, '2021-03-22', 1, 300.00),
(3, 3, 3, '2021-05-10', 4, 600.00),
(4, 4, 4, '2021-07-18', 3, 2400.00),
(5, 5, 5, '2021-09-25', 2, 500.00),
(6, 6, 6, '2021-11-30', 1, 100.00),
(7, 7, 1, '2022-02-15', 1, 200.00),
(8, 1, 2, '2022-04-10', 1, 1200.00),
(9, 2, 3, '2022-06-20', 2, 600.00),
(10, 3, 4, '2022-08-05', 3, 450.00),
(11, 4, 5, '2022-10-11', 1, 800.00),
(12, 5, 6, '2022-12-29', 4, 1000.00);


SELECT * FROM onlineshopping.Employees;


SELECT FirstName FROM onlineshopping.Employees;


SELECT DISTINCT Department FROM onlineshopping.Employees;


SELECT COUNT(*) AS TotalEmployees FROM onlineshopping.Employees;


SELECT SUM(Salary) AS TotalSalaries FROM onlineshopping.Employees;


SELECT AVG(Salary) AS AverageSalary FROM onlineshopping.Employees;


SELECT MAX(Salary) AS HighestSalary FROM onlineshopping.Employees;


SELECT MIN(Salary) AS LowestSalary FROM onlineshopping.Employees;


SELECT COUNT(*) AS MaleEmployees FROM onlineshopping.Employees WHERE Gender = 'Male';


SELECT COUNT(*) AS FemaleEmployees FROM onlineshopping.Employees WHERE Gender = 'Female';


SELECT COUNT(*) AS HiredIn2020 FROM onlineshopping.Employees WHERE extract(year from HireDate) = 2020;

SELECT AVG(Salary) AS IT_AverageSalary FROM onlineshopping.Employees WHERE Department = 'IT';


SELECT Department, COUNT(*) AS NumEmployees FROM onlineshopping.Employees GROUP BY Department;


SELECT Department, SUM(Salary) AS TotalDeptSalary FROM onlineshopping.Employees GROUP BY Department;


SELECT Department, MAX(Salary) AS MaxDeptSalary FROM onlineshopping.Employees GROUP BY Department;


SELECT Department, MIN(Salary) AS MinDeptSalary FROM onlineshopping.Employees GROUP BY Department;

SELECT Gender, COUNT(*) AS TotalEmployees
FROM onlineshopping.Employees
GROUP BY Gender;

SELECT Gender, AVG(Salary) AS AvgSalary FROM onlineshopping.Employees GROUP BY Gender;


SELECT * FROM onlineshopping.Employees ORDER BY Salary DESC LIMIT 5;


SELECT COUNT(DISTINCT FirstName) AS UniqueFirstNames FROM onlineshopping.Employees;


SELECT e.*, s.* 
FROM onlineshopping.Employees e
LEFT JOIN onlineshopping.Sales s ON e.EmployeeID = s.EmployeeID;


SELECT * FROM onlineshopping.Employees ORDER BY HireDate ASC LIMIT 10;


SELECT * FROM onlineshopping.Employees
WHERE EmployeeID NOT IN (
    SELECT DISTINCT EmployeeID FROM onlineshopping.Sales
);


SELECT EmployeeID, COUNT(*) AS NumSales
FROM onlineshopping.Sales
GROUP BY EmployeeID;


SELECT EmployeeID, SUM(Total) AS TotalSales
FROM onlineshopping.Sales
GROUP BY EmployeeID
ORDER BY TotalSales DESC
LIMIT 1;


SELECT e.Department, AVG(s.Quantity) AS AvgQuantity
FROM onlineshopping.Employees e
JOIN onlineshopping.Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.Department;

WITH SalesData AS (
    SELECT EmployeeID, Quantity
    FROM onlineshopping.Sales
)
SELECT 
    e.Department, 
    AVG(COALESCE(s.Quantity, 0)) AS AvgQuantity
FROM 
    onlineshopping.Employees e
LEFT JOIN 
    SalesData s ON e.EmployeeID = s.EmployeeID
GROUP BY 
    e.Department
ORDER BY 
    e.Department;



SELECT EmployeeID, SUM(Total) AS TotalSales2021
FROM onlineshopping.Sales
WHERE EXTRACT(YEAR FROM SaleDate) = 2021
GROUP BY EmployeeID;

SELECT EmployeeID, SUM(Quantity) AS TotalQuantity
FROM onlineshopping.Sales
GROUP BY EmployeeID
ORDER BY TotalQuantity DESC
LIMIT 3;


SELECT e.Department, SUM(s.Quantity) AS TotalDeptQuantity
FROM onlineshopping.Employees e
JOIN onlineshopping.Sales s ON e.EmployeeID = s.EmployeeID
GROUP BY e.Department;


SELECT p.Category, SUM(s.Total) AS TotalRevenue
FROM onlineshopping.Products p
JOIN onlineshopping.Sales s ON p.ProductID = s.ProductID
GROUP BY p.Category;
