WITH daily_sales AS (
    SELECT s."DATE" AS "DATE_", 
           sh."CITY",
           SUM(s."QTY"::numeric * g."PRICE"::numeric) AS daily_sum
    FROM "SALES" s
    JOIN "SHOPS" sh USING("SHOPNUMBER")
    JOIN "GOODS" g USING("ID_GOOD")
    WHERE g."CATEGORY" = 'ЧИСТОТА'
    GROUP BY s."DATE", sh."CITY"
)
SELECT "DATE_", 
       "CITY",
       ROUND(daily_sum / SUM(daily_sum) OVER (PARTITION BY "DATE_"), 4) AS "SUM_SALES_REL"
FROM daily_sales
ORDER BY "DATE_", "CITY";