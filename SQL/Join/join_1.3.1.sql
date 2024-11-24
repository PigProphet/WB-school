/*
* Возникли сложности с пониманием куда относить доставку в 5+ дней, которую отменили,
* Поэтому 2 версии, где считается в обе категории и только в отменённую
*
*/
SELECT c.customer_id, c.name,
       SUM(CASE WHEN o.shipment_date::date - o.order_date::date > 5 AND o.order_status != 'Cancel' THEN 1 ELSE 0 END) AS delayed_deliveries,
       SUM(CASE WHEN o.order_status = 'Cancel' THEN 1 ELSE 0 END) AS cancelled_orders,
       SUM(CASE 
           WHEN o.order_status = 'Cancel' THEN o.order_ammount
           WHEN o.shipment_date::date - o.order_date::date > 5 THEN o.order_ammount
           ELSE 0
       END) AS total_amount
FROM customers_new_3 c
JOIN orders_new_3 o ON c.customer_id = o.customer_id
WHERE (o.shipment_date::date - o.order_date::date > 5 AND o.order_status != 'Cancel') OR (o.order_status = 'Cancel')
GROUP BY c.customer_id, c.name
ORDER BY total_amount DESC;

SELECT c.customer_id, c.name,
       SUM(CASE WHEN o.shipment_date::date - o.order_date::date > 5 THEN 1 ELSE 0 END) AS delayed_deliveries,
       SUM(CASE WHEN o.order_status = 'Cancel' THEN 1 ELSE 0 END) AS cancelled_orders,
       SUM(CASE 
           WHEN o.shipment_date::date - o.order_date::date > 5 OR o.order_status = 'Cancel' 
           THEN o.order_ammount
           ELSE 0
       END) AS total_amount
FROM customers_new_3 c
JOIN orders_new_3 o ON c.customer_id = o.customer_id
WHERE (o.shipment_date::date - o.order_date::date > 5) OR (o.order_status = 'Cancel')
GROUP BY c.customer_id, c.name
ORDER BY total_amount DESC;