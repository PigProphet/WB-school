SELECT s."DATE", 
       sh."SHOPNUMBER", 
       g."CATEGORY",
       COALESCE(LAG(SUM(g."PRICE"::numeric * s."QTY"::numeric), 1) OVER (
           PARTITION BY g."CATEGORY", sh."SHOPNUMBER" 
           ORDER BY s."DATE"
       ), 0) AS "PREV_SALES"
FROM "SALES" s 
JOIN "SHOPS" sh USING("SHOPNUMBER") 
JOIN "GOODS" g USING("ID_GOOD")
WHERE sh."CITY" = 'СПб'
GROUP BY s."DATE", g."CATEGORY", sh."SHOPNUMBER"
ORDER BY s."DATE", sh."SHOPNUMBER", g."CATEGORY";