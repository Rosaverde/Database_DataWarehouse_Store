# Sporting goods store
### Scenario:

You are a data engineer at a sporting goods store. The store has multiple tills where customers make in-store purchases, and each till is operated by a cashier. The store offers a wide range of sporting goods, including equipment, apparel, and accessories.

Customers make purchases in-store

- [x]  Problem 1: Normalized Data Model for Sales Transactions

    You have been provided with information about sales transactions at a retail store. Design a normalized relational data model to capture the sales transaction data. Include appropriate tables, primary keys, foreign keys, and relationships.
    
    The solution should Include both a diagram and any code you’d write to achieve this.
    
- [x]  Problem 2: Data Warehouse Model for Sales Transactions

    Referencing the normalized data model from Problem 1, design a conformed dimensional model specific to a Data Warehouse for the sales transactions. Create the necessary fact and dimension tables and define the appropriate relationships for querying and reporting.
    
    The solution should include both a diagram and any code you’d write to achieve this.
    
- [x]  Problem 3: Data Pipeline Development for Staging
    
    Imagine you have a CSV file containing raw sales transaction data. Develop a data pipeline using your preferred programming language or ETL tool to ingest and stage this data into a database table that you design. 
    
    The solution should include both a diagram and any code you’d write to achieve this.
    
- [x]  Problem 4: Stored Procedure for Transforming to Conformed Dimensional Model
    
    Write a database stored procedure (SQL) that takes data from the staged tables and transforms it to fit the conformed dimensional model created in Problem 2. The procedure should perform at least one data cleansing activity as a part of its flow.
    
- [x]  Problem 5: Sales Trends
    
    Relying on the data model from Problem 2, write a SQL query to calculate the total sales amount for each month, along with the month-over-month growth rate.

- ****Solution 1 database diagram:****
![alt text](https://github.com/Rosaverde/Database_DataWarehouse_Store/blob/main/salesdb.png)

- ****Solution 2 data warehouse diagram:****
![alt text](https://github.com/Rosaverde/Database_DataWarehouse_Store/blob/main/salesdw.png)

- ****Solution 5 Example sales report:****
![alt text](https://github.com/Rosaverde/Database_DataWarehouse_Store/blob/main/salesReport.png)

- ## There are solutions in two versions, MSSQL and PostgreSQL.