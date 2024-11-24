WITH ranked_sales AS (
    SELECT sa."DATE" AS "DATE_", sa."SHOPNUMBER", sa."ID_GOOD",
           ROW_NUMBER() OVER (PARTITION BY sa."DATE", sa."SHOPNUMBER" ORDER BY SUM(sa."QTY") DESC) AS rank
    FROM "SALES" sa
    GROUP BY sa."DATE", sa."SHOPNUMBER", sa."ID_GOOD"
)
SELECT "DATE_", "SHOPNUMBER", "ID_GOOD"
FROM ranked_sales
WHERE rank <= 3
ORDER BY "DATE_", "SHOPNUMBER", rank;