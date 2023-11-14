CREATE DATABASE salesDB;
GO

USE salesDB;
GO


CREATE TABLE Employee
(
	ID_Employee smallint IDENTITY(1,1) NOT NULL,
	EmployeeName varchar(30) NOT NULL,
	EmployeeSurname varchar(30) NOT NULL,
	CONSTRAINT PK_Employee PRIMARY KEY ( ID_Employee ASC )
);
GO

CREATE TABLE CashRegister
(
	ID_CashRegister smallint IDENTITY (1,1) NOT NULL,
	CashRegisterName varchar(20) NOT NULL,
	CONSTRAINT PK_CashRegister PRIMARY KEY ( ID_CashRegister ASC )
);
GO

CREATE TABLE ProductCategory
(
	ID_Category smallint IDENTITY(1,1) NOT NULL,
	Category varchar(30) NOT NULL,
	CONSTRAINT PK_ProductCategory PRIMARY KEY ( ID_Category ASC)
);
GO

CREATE TABLE Size
(
	ID_Size smallint IDENTITY(1,1) NOT NULL,
	Size varchar(20) NOT NULL,
	CONSTRAINT PK_Size PRIMARY KEY ( ID_Size ASC )
);
GO

CREATE TABLE Transactions
(
	ID_Transaction bigint NOT NULL,
	Employee_ID smallint NOT NULL,
	CashRegister_ID smallint NOT NULL,
	TransactionDate smalldatetime NOT NULL,
	TransactionSum decimal(10,2) NOT NULL,
	CONSTRAINT PK_Transaction PRIMARY KEY ( ID_Transaction ASC ),
	CONSTRAINT FK_Employee FOREIGN KEY ( Employee_ID ) REFERENCES Employee (ID_Employee),
	CONSTRAINT FK_CashRegister FOREIGN KEY (CashRegister_ID ) REFERENCES CashRegister (ID_CashRegister)
);
GO

CREATE TABLE Product
(
	ID_Product int IDENTITY(1,1) NOT NULL,
	Category_ID smallint NOT NULL,
	Size_ID smallint NULL,
	Product varchar(30) NOT NULL,
	AmountOnStock smallint DEFAULT 0,
	ProductPrice decimal(5,2) NOT NULL,
	CONSTRAINT PK_Product PRIMARY KEY ( ID_Product ASC),
	CONSTRAINT FK_Category FOREIGN KEY ( Category_ID ) REFERENCES ProductCategory ( ID_Category ),
	CONSTRAINT FK_SIze FOREIGN KEY ( Size_ID ) REFERENCES Size ( ID_Size ) 
);
GO

CREATE TABLE Operation
(
	Transaction_ID bigint NOT NULL,
	Product_ID int NOT NULL,
	AmountSold smallint NOT NULL,
	CONSTRAINT PK_Operation PRIMARY KEY ( Transaction_ID ASC, Product_ID ASC),
	CONSTRAINT FK_Transactions FOREIGN KEY ( Transaction_ID ) REFERENCES Transactions ( ID_Transaction ),
	CONSTRAINT FK_Product FOREIGN KEY ( Product_ID ) REFERENCES Product ( ID_Product )
);
GO