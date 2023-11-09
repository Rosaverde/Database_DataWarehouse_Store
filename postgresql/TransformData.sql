\c salesdw;

CREATE EXTENSION postgres_fdw;

CREATE SERVER temp_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS(host'localhost',port'5432',dbname'salesdb');

CREATE USER MAPPING FOR postgres
SERVER temp_server
OPTIONS (user'postgres', password'root');

CREATE SCHEMA salesdb_schema;

IMPORT FOREIGN SCHEMA public 
FROM SERVER temp_server
INTO salesdb_schema;


CREATE OR REPLACE PROCEDURE TransformData()
LANGUAGE plpgsql
AS $$
BEGIN

INSERT INTO DimEmployee (Employee_ID,EmployeeName,EmployeeSurname)
(
    SELECT 
        ID_Employee,
        EmployeeName,
        EmployeeSurname
    FROM salesdb_schema.Employee e
    WHERE NOT EXISTS
    (
        SELECT 1 FROM DimEmployee de
        WHERE de.Employee_ID = e.ID_Employee
    )
);

INSERT INTO DimTransaction(Transaction_ID, TransactionSum)
(
    SELECT 
        ID_Transaction, 
        TransactionSum
    FROM salesdb_schema.Transactions t
    WHERE NOT EXISTS
    (
        SELECT 1 FROM DimTransaction dt
        WHERE dt.Transaction_ID = t.ID_Transaction
    )
);

INSERT INTO DimProduct(Product_ID, ProductName, ProductPrice, ProductSize, ProductCategory)
(
    SELECT
        ID_Product,
        Product,
        ProductPrice,
        CAST(COALESCE(s.Size, 'No Size') AS VARCHAR(10)),
        CAST(pc.Category AS VARCHAR(30))
    FROM salesdb_schema.Product p
    INNER JOIN salesdb_schema.ProductCategory pc ON p.Category_ID = pc.ID_Category
    LEFT JOIN salesdb_schema.Size s ON p.Size_ID = s.ID_Size
    WHERE NOT EXISTS
    (
        SELECT 1 FROM DimProduct dp
        WHERE dp.Product_ID = p.ID_Product
    )
);

INSERT INTO DimDate(FullDate, MonthName, MonthNumber, FiscalYear)
(
    SELECT
        TransactionDate,
        TO_CHAR(TransactionDate,'Month'),
        EXTRACT(MONTH FROM TransactionDate),
        CASE
            WHEN EXTRACT(MONTH FROM TransactionDate) < 9
            THEN EXTRACT(YEAR FROM TransactionDate) - 1
            ELSE EXTRACT(YEAR FROM TransactionDate)
        END
    FROM salesdb_schema.Transactions t
    WHERE NOT EXISTS
    (
        SELECT 1 FROM DimDate dt
        WHERE dt.FullDate = t.TransactionDate
    )
);

INSERT INTO FactSales(SK_Product, SK_Date, SK_Employee, SK_Transaction, UnitsSold)
    SELECT
        dp.SK_Product,
        dd.SK_Date,
        de.SK_Employee,
        dt.SK_Transaction,
        o.AmountSold
    FROM salesdb_schema.Operation o
    INNER JOIN salesdb_schema.Transactions t ON o.Transaction_ID = t.ID_Transaction
    INNER JOIN salesdb_schema.Employee e ON e.ID_Employee = t.Employee_ID
    INNER JOIN salesdb_schema.Product p ON o.Product_ID = p.ID_Product
    INNER JOIN DimProduct dp ON o.Product_ID = dp.Product_ID
    INNER JOIN DimDate dd ON t.TransactionDate = dd.FullDate
    INNER JOIN DimEmployee de ON e.ID_Employee = de.Employee_ID
    INNER JOIN DimTransaction dt ON t.ID_Transaction = dt.Transaction_ID
    WHERE NOT EXISTS
    ( 
    	SELECT 1 FROM FactSales fs 
    	WHERE fs.SK_Transaction = dt.SK_Transaction
    	AND fs.SK_Product = dp.SK_Product
    );
END;
$$;

CREATE INDEX productindex ON Factsales(sk_transaction);
