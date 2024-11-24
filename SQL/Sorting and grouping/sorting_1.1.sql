SELECT 
    city,
    CASE
        WHEN age BETWEEN 0 AND 20 THEN 'young'
        WHEN age BETWEEN 21 AND 49 THEN 'adult'
        WHEN age >= 50 THEN 'old'
    END AS age_category,
    COUNT(*) AS customer_count
FROM 
    users
GROUP BY 
    city,
    age_category
ORDER BY 
    customer_count DESC;
