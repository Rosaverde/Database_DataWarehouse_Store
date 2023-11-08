CREATE DATABASE salesDB;

\c salesdb;

CREATE TABLE Employee
(
    ID_Employee SERIAL,
    EmployeeName VARCHAR(40) NOT NULL,
    EmployeeSurname VARCHAR(40) NOT NULL,
    PRIMARY KEY(ID_Employee)
);

CREATE TABLE CashRegister
(
    ID_CashRegister SERIAL,
    CashRegisterName VARCHAR(30) NOT NULL,
    PRIMARY KEY(ID_CashRegister)
);

CREATE TABLE ProductCategory
(
    ID_Category SERIAL,
    Category VARCHAR(30) NOT NULL,
    PRIMARY KEY(ID_Category)
);

CREATE TABLE Size
(
    ID_Size SERIAL,
    Size VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID_Size)
);

CREATE TABLE Transactions
(
    ID_Transaction BIGINT,
    Employee_ID SMALLINT NOT NULL REFERENCES Employee(ID_Employee),
    CashRegister_ID SMALLINT NOT NULL REFERENCES CashRegister(ID_CashRegister),
    TransactionDate TIMESTAMP NOT NULL,
    TransactionSum REAL NOT NULL,
    PRIMARY KEY(ID_Transaction)
);

CREATE TABLE Product
(
    ID_Product SERIAL,
    Category_ID SMALLINT NOT NULL REFERENCES ProductCategory(ID_Category),
    Size_ID SMALLINT REFERENCES Size(ID_Size),
    Product VARCHAR(40) NOT NULL,
    AmountOnStock SMALLINT DEFAULT 0,
    ProductPrice REAL NOT NULL,
    PRIMARY KEY(ID_Product)
);

CREATE TABLE Operation
(
    Transaction_ID BIGINT NOT NULL REFERENCES Transactions(ID_Transaction),
    Product_ID INTEGER NOT NULL REFERENCES Product(ID_Product),
    AmountSold SMALLINT NOT NULL,
    PRIMARY KEY(Transaction_ID, Product_ID)
);
