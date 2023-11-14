-- Write a database stored procedure (SQL) that takes data from the staged tables and
-- transforms it to fit the conformed dimensional model created in Problem 2. The
-- procedure should perform at least one data cleansing activity as a part of its flow. 
USE salesDB;
GO

CREATE PROCEDURE TransformData
AS
BEGIN
INSERT INTO salesDW.dbo.DimEmployee
SELECT
	ID_Employee,
	EmployeeName,
	EmployeeSurname
FROM salesDB.dbo.Employee e
WHERE NOT EXISTS (
	SELECT 1 FROM salesDW.dbo.DimEmployee de 
	WHERE de.Employee_ID = e.ID_Employee)

INSERT INTO salesDW.dbo.DimTransaction
SELECT
	ID_Transaction,
	TransactionSum
FROM salesDB.dbo.Transactions t
WHERE NOT EXISTS (
	SELECT 1 FROM salesDW.dbo.DimTransaction dt 
	WHERE dt.Transaction_ID = t.ID_Transaction)

INSERT INTO salesDW.dbo.DimProduct
SELECT
	ID_Product,
	Product,
	ProductPrice,
	Cast(IsNull(s.Size, 'No size') AS varchar(10)),
	Cast(pc.Category AS varchar(30))
FROM salesDB.dbo.Product p
INNER JOIN salesDB.dbo.ProductCategory pc ON p.Category_ID = pc.ID_Category
LEFT JOIN salesDB.dbo.Size s ON p.Size_ID = s.ID_Size
WHERE NOT EXISTS (
	SELECT 1 FROM salesDW.dbo.DimProduct dp
	WHERE dp.Product_ID = p.ID_Product
)

INSERT INTO salesDW.dbo.DimDate
SELECT 
	TransactionDate,
	DATENAME(m, TransactionDate),
	MONTH(TransactionDate),
	CASE 
		WHEN MONTH(TransactionDate) < 9 
		THEN YEAR(TransactionDate) - 1 
		ELSE YEAR(TransactionDate) 
		END
FROM salesDB.dbo.Transactions t
WHERE NOT EXISTS (
	SELECT 1 FROM salesDW.dbo.DimDate dt
	WHERE dt.FullDate = t.TransactionDate 
)

INSERT INTO salesDW.dbo.FactSales
SELECT
	dp.SK_Product,
	dd.SK_Date,
	de.SK_Employee,
	dt.SK_Transaction,
	o.AmountSold
FROM salesDB.dbo.Operation o
INNER JOIN salesDB.dbo.Transactions t ON o.Transaction_ID = t.ID_Transaction
INNER JOIN salesDB.dbo.Employee e ON e.ID_Employee = t.Employee_ID
INNER JOIN salesDB.dbo.Product p ON o.Product_ID = p.ID_Product
INNER JOIN salesDW.dbo.DimProduct dp ON o.Product_ID = dp.Product_ID
INNER JOIN salesDW.dbo.DimDate dd ON t.TransactionDate = dd.FullDate
INNER JOIN salesDW.dbo.DimEmployee de ON e.ID_Employee = de.Employee_ID
INNER JOIN salesDW.dbo.DimTransaction dt ON t.ID_Transaction = dt.Transaction_ID
WHERE NOT EXISTS ( 
	SELECT 1 FROM salesDW.dbo.FactSales fs 
	WHERE fs.SK_Transaction = dt.SK_Transaction
	AND fs.SK_Product = dp.SK_Product
)
END

GO
CREATE INDEX productindex ON salesDW.dbo.FactSales(SK_Transaction);