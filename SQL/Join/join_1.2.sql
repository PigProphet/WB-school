SELECT c.customer_id, c.name, 
       COUNT(*) AS order_count,
       AVG(o.shipment_date::date - o.order_date::date) AS avg_wait_time,
       SUM(o.order_ammount) AS total_amount
FROM customers_new_3 c
JOIN orders_new_3 o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_amount DESC
LIMIT 2;