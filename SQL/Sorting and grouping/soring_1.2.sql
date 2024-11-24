SELECT 
    category,
    ROUND(CAST(AVG(price) AS NUMERIC), 2) AS avg_price
FROM 
    products
WHERE 
    name ILIKE '%hair%' OR name ILIKE '%home%' -- ILIKE для нечувствительности к регистру
GROUP BY 
    category;
