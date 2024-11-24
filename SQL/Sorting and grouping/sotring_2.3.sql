/*
* Посчитал, что регистрацией мы считаем самое раннее появление продавца на площадке
*/
WITH seller_stats AS (
    SELECT 
        seller_id,
        MIN(TO_DATE(date_reg, 'DD/MM/YYYY')) AS first_reg_date,
        COUNT(DISTINCT category) AS category_count,
        SUM(revenue) AS total_revenue
    FROM sellers
    GROUP BY seller_id
),
eligible_sellers AS (
    SELECT 
        s.seller_id,
        string_agg(DISTINCT s.category, ' - ' ORDER BY s.category) AS category_pair
    FROM sellers s
    JOIN seller_stats ss ON s.seller_id = ss.seller_id
    WHERE 
        EXTRACT(YEAR FROM ss.first_reg_date) = 2022
        AND ss.category_count = 2
        AND ss.total_revenue > 75000
    GROUP BY s.seller_id
)
SELECT seller_id, category_pair
FROM eligible_sellers;
