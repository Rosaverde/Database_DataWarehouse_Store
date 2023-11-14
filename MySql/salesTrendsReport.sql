-- Relying on the data model from Problem 2, write a SQL query to calculate the total
-- sales amount for each month, along with the month-over-month growth rate. 
USE salesDW
GO
CREATE PROCEDURE CountMOM
AS
BEGIN
SELECT
    Y AS Year,
    M AS Month,
    Revenue, 
    CAST(
        ROUND(
            COALESCE((
                Revenue - LAG(Revenue) OVER(ORDER BY Y, M))/LAG(Revenue) OVER(ORDER BY Y, M)*100,0),2) AS INT) AS "Month-to-Month(%)"
FROM
( 
    SELECT (YEAR(D.FullDate)) AS Y, (MONTH(D.FullDate)) AS M, ROUND(SUM(T.TransactionSum),2) AS REVENUE FROM DimDate D
    INNER JOIN FactSales FS ON FS.SK_Date = D.SK_Date
    INNER JOIN DimTransaction T ON FS.SK_Transaction = T.SK_Transaction
    GROUP BY (YEAR(D.FullDate)), (MONTH(D.FullDate))
) AS M_REV
END;