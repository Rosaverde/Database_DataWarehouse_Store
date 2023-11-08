CREATE DATABASE salesDW;

\c salesdw;

CREATE TABLE DimProduct
(
    SK_Product SERIAL,
    Product_ID INTEGER NOT NULL,
    ProductName VARCHAR(30) NOT NULL,
    ProductPrice REAL DEFAULT 0,
    ProductSize VARCHAR(30),
    ProductCategory VARCHAR(30),
    PRIMARY KEY(SK_Product)
);

CREATE TABLE DimDate
(
    SK_Date SERIAL,
    FullDate TIMESTAMP,
    MonthName VARCHAR(15),
    MonthNumber SMALLINT,
    FiscalYear SMALLINT,
    PRIMARY KEY(SK_Date)
);

CREATE TABLE DimEmployee
(
    SK_Employee SERIAL,
    Employee_ID SMALLINT NOT NULL,
    EmployeeName VARCHAR(30) NOT NULL,
    EmployeeSurname VARCHAR(30) NOT NULL,
    PRIMARY KEY(SK_Employee)
);

CREATE TABLE DimTransaction
(
    SK_Transaction BIGSERIAL,
    Transaction_ID BIGINT NOT NULL,
    TransactionSum REAL NOT NULL,
    PRIMARY KEY(SK_Transaction)
);

CREATE TABLE FactSales
(
    SK_Product INTEGER NOT NULL REFERENCES DimProduct(SK_Product),
    SK_Date INTEGER NOT NULL REFERENCES DimDate(SK_Date),
    SK_Employee SMALLINT NOT NULL REFERENCES DimEmployee(SK_Employee),
    SK_Transaction BIGINT NOT NULL REFERENCES DimTransaction(SK_Transaction),
    UnitsSold SMALLINT NOT NULL
);