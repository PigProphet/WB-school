WITH category_sales AS (
    SELECT p.product_category,
           SUM(o.order_ammount) AS total_sales
    FROM orders_2 o
    JOIN products_3 p ON o.product_id = p.product_id
    GROUP BY p.product_category
),
top_category AS (
    SELECT product_category
    FROM category_sales
    WHERE total_sales = (SELECT MAX(total_sales) FROM category_sales)
),
product_sales AS (
    SELECT p.product_category,
           p.product_name,
           SUM(o.order_ammount) AS product_total_sales,
           ROW_NUMBER() OVER (PARTITION BY p.product_category ORDER BY SUM(o.order_ammount) DESC) AS rank
    FROM orders_2 o
    JOIN products_3 p ON o.product_id = p.product_id
    GROUP BY p.product_category, p.product_name
)
SELECT cs.product_category,
       cs.total_sales AS category_total_sales,
       ps.product_name AS top_product,
       ps.product_total_sales AS top_product_sales
FROM category_sales cs
LEFT JOIN top_category tc ON cs.product_category = tc.product_category
JOIN product_sales ps ON cs.product_category = ps.product_category AND ps.rank = 1
ORDER BY cs.total_sales DESC;