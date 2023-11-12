CREATE FUNCTION CountMOM() RETURNS TABLE("Year" int, "Month" smallint, "RevenueSum" NUMERIC, "Month-to-Month(%)" INT )
LANGUAGE plpgsql
AS $$
BEGIN
return query
SELECT
    Y,
    M,
    Revenue, 
    CAST(
        ROUND(
            COALESCE((
                Revenue - LAG(Revenue) OVER(ORDER BY Y, M))/LAG(Revenue) OVER(ORDER BY Y, M)*100, 0)) AS INT) AS "Month-to-Month(%)"
FROM
( 
    SELECT EXTRACT(YEAR FROM D.FullDate)::INT AS Y, EXTRACT(MONTH FROM D.FullDate)::SMALLINT AS M, ROUND((SUM(T.TransactionSum)::decimal),2) AS REVENUE FROM DimDate D
    INNER JOIN FactSales FS ON FS.SK_Date = D.SK_Date
    INNER JOIN DimTransaction T ON FS.SK_Transaction = T.SK_Transaction
    GROUP BY EXTRACT(YEAR FROM D.FullDate), EXTRACT(MONTH FROM D.FullDate)
) AS M_REV;
END;
$$;