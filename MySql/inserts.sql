-- Employee Table
insert into Employee (EmployeeName, EmployeeSurname) values ('Aguistin', 'Wones');
insert into Employee (EmployeeName, EmployeeSurname) values ('Beret', 'Dwine');
insert into Employee (EmployeeName, EmployeeSurname) values ('Bel', 'Boxell');
insert into Employee (EmployeeName, EmployeeSurname) values ('Patsy', 'Rodrig');
insert into Employee (EmployeeName, EmployeeSurname) values ('Erminia', 'Hawe');
-- CashRegister Table
insert into CashRegister (CashRegisterName) values ('956279926-3');
insert into CashRegister (CashRegisterName) values ('328734107-3');
insert into CashRegister (CashRegisterName) values ('210913825-4');
insert into CashRegister (CashRegisterName) values ('940148555-0');
insert into CashRegister (CashRegisterName) values ('726417816-1');
-- Product Category Table
insert into ProductCategory (Category) values ('equipment');
insert into ProductCategory (Category) values ('apparel');
insert into ProductCategory (Category) values ('accessories');
-- Size Table
insert into Size (Size) values ('S');
insert into Size (Size) values ('XS');
insert into Size (Size) values ('M');
insert into Size (Size) values ('L');
insert into Size (Size) values ('XL');
-- Product Table
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (2, 3, 'shirt', 25, 97.72);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (2, 1, 'shirt', 97, 42.88);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (3, NULL, 'football', 20, 54.28);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (3, NULL, 'baseball bat', 51, 41.21);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (1, NULL, 'Dumbbell Set', 59, 33.13);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (2, 3, 'leggins', 96, 38.72);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (2, 5, 'leggins', 94, 44.63);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (3, 2, 'baseball glove', 49, 91.83);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (1, NULL, 'Training Mat', 39, 66.75);
insert into Product (ID_Category, ID_Size, Product, AmountOnStock, ProductPrice) values (3, 4, 'baseball glove', 51, 86.02);
-- Transaction Table
insert into Transactions (ID_Transaction, ID_Employee, ID_CashRegister, TransactionDate, TransactionSum) values ('030300613', 5, 3, '2022-12-13 17:32:21', 378.51);
insert into Transactions (ID_Transaction, ID_Employee, ID_CashRegister, TransactionDate, TransactionSum) values ('495756493', 3, 1, '2023-07-15 18:35:55', 164.07);
insert into Transactions (ID_Transaction, ID_Employee, ID_CashRegister, TransactionDate, TransactionSum) values ('048616508', 3, 1, '2022-11-04 23:19:58', 81.41);
insert into Transactions (ID_Transaction, ID_Employee, ID_CashRegister, TransactionDate, TransactionSum) values ('618091383', 4, 1, '2023-01-14 14:24:06', 42.91);
-- Operation Table
insert into Operation (ID_Transaction, ID_Product, AmountSold) values ('030300613', 7, 1);
insert into Operation (ID_Transaction, ID_Product, AmountSold) values ('030300613', 8, 1);
insert into Operation (ID_Transaction, ID_Product, AmountSold) values ('048616508', 1, 4);
insert into Operation (ID_Transaction, ID_Product, AmountSold) values ('495756493', 2, 5);
insert into Operation (ID_Transaction, ID_Product, AmountSold) values ('618091383', 7, 3);

