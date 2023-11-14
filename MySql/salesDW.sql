CREATE DATABASE salesDW;
GO

USE salesDW;
GO


CREATE TABLE DimProduct
(
	SK_Product int IDENTITY(1,1) NOT NULL,
	Product_ID int NOT NULL,
	ProductName varchar(30) NOT NULL,
	ProductPrice decimal(10,2) DEFAULT 0,
	ProductSize varchar(20),
	ProductCategory varchar(20)
	CONSTRAINT PK_DimProduct PRIMARY KEY ( SK_Product ASC )
);

CREATE TABLE DimDate
(
	SK_Date int IDENTITY(1,1) NOT NULL,
	FullDate smalldatetime NOT NULL,
	MonthName varchar(15),
	MonthNumber tinyint,
	FiscalYear smallint,
	CONSTRAINT PK_DimDate PRIMARY KEY ( SK_Date ASC )
);

CREATE TABLE DimEmployee
(
	SK_Employee smallint IDENTITY(1,1) NOT NULL,
	Employee_ID smallint NOT NULL,
	EmployeeName varchar(30) NOT NULL,
	EmployeeSurname varchar(30),
	CONSTRAINT PK_DimEmployee PRIMARY KEY ( SK_Employee ASC )
);

CREATE TABLE DimTransaction
(
	SK_Transaction bigint IDENTITY(1,1) NOT NULL,
	Transaction_ID bigint NOT NULL,
	TransactionSum decimal(10,2) NOT NULL,
	CONSTRAINT PK_DimTransaction PRIMARY KEY ( SK_Transaction ASC )
);

CREATE TABLE FactSales
(
	SK_Product int NOT NULL,
	SK_Date int NOT NULL,
	SK_Employee smallint NOT NULL,
	SK_Transaction bigint NOT NULL,
	UnitsSold tinyint NOT NULL,
	CONSTRAINT FK_Product FOREIGN KEY ( SK_Product ) REFERENCES DimProduct ( SK_Product ),
	CONSTRAINT FK_Date FOREIGN KEY ( SK_Date ) REFERENCES DimDate ( SK_Date ),
	CONSTRAINT FK_Employee FOREIGN KEY ( SK_Employee ) REFERENCES DimEmployee ( SK_Employee ),
	CONSTRAINT FK_Transaction FOREIGN KEY ( SK_Transaction ) REFERENCES DimTransaction ( SK_Transaction )
);