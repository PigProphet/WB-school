SELECT c.customer_id, c.name, 
       MAX(o.shipment_date::date - o.order_date::date) AS max_wait_time
FROM customers_new_3 c
JOIN orders_new_3 o ON c.customer_id = o.customer_id
WHERE o.shipment_date IS NOT NULL
GROUP BY c.customer_id, c.name
ORDER BY max_wait_time DESC
LIMIT 5;