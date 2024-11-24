WITH delivery_stats AS (
    SELECT 
        MAX(delivery_days) - MIN(delivery_days) AS max_delivery_difference
    FROM 
        sellers
    WHERE 
        category <> 'Bedding' -- Исключаем категорию "Bedding"
    GROUP BY 
        seller_id
    HAVING 
        COUNT(DISTINCT category) > 1 AND 
        SUM(revenue) <= 50000 -- Учитываем только "poor" продавцов
)
SELECT 
    seller_id,
    FLOOR((CURRENT_DATE - MIN(TO_DATE(date_reg, 'DD/MM/YYYY'))) / 30) AS month_from_registration,
    (SELECT MAX(max_delivery_difference) FROM delivery_stats) AS max_delivery_difference
FROM 
    sellers
WHERE 
    category <> 'Bedding' -- Исключаем категорию "Bedding"
GROUP BY 
    seller_id
HAVING 
    COUNT(DISTINCT category) > 1 AND 
    SUM(revenue) <= 50000 -- Учитываем только "poor" продавцов
ORDER BY 
    seller_id;
