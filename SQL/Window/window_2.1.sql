SELECT sh."SHOPNUMBER", 
       sh."CITY", 
       sh."ADDRESS",
       SUM(s."QTY") AS "SUM_QTY",
       SUM(s."QTY"::numeric * g."PRICE"::numeric) AS "SUM_QTY_PRICE"
FROM "SALES" s
JOIN "SHOPS" sh USING("SHOPNUMBER")
JOIN "GOODS" g USING("ID_GOOD")
WHERE to_date(s."DATE", 'MM/DD/YYYY') = to_date('01/02/2016', 'MM/DD/YYYY')
GROUP BY sh."SHOPNUMBER", sh."CITY", sh."ADDRESS"
ORDER BY sh."SHOPNUMBER";