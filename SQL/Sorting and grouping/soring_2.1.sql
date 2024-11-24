SELECT 
    seller_id,
    COUNT(DISTINCT category) AS total_categ,
    ROUND(AVG(rating), 2) AS avg_rating,
    SUM(revenue) AS total_revenue,
    CASE 
        WHEN COUNT(DISTINCT category) > 1 AND SUM(revenue) > 50000 THEN 'rich'
        WHEN COUNT(DISTINCT category) > 1 AND SUM(revenue) <= 50000 THEN 'poor'
        ELSE NULL
    END AS seller_type
FROM 
    sellers
WHERE 
    category != 'Bedding' -- Исключаем категорию "Bedding"
GROUP BY 
    seller_id
HAVING 
    COUNT(DISTINCT category) > 1 -- Учитываем только селлеров с более чем одной категорией
ORDER BY 
    seller_id;
