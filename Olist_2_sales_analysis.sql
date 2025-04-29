
### --- SALES PERFORMANCE ---

# time frame : 2016-09-04 to 2018-10-17 

SELECT 
   MIN(order_purchase_timestamp) AS started_date,
   MAX(order_purchase_timestamp) AS ended_Date
FROM olist_orders oo;

# Gross revenue: $16,008,872

SELECT 
   ROUND(SUM(opa.payment_value), 0) total_revenue  
FROM olist_orders oo
JOIN 
     olist_payments opa ON oo.order_id = opa.order_id 
         
# Valid revenue: $15,421,083 
     
SELECT 
   ROUND(SUM(opa.payment_value), 0) Valid_revenue 
FROM olist_orders oo
JOIN 
     olist_payments opa ON oo.order_id = opa.order_id 
WHERE 
     oo.order_status <> 'canceled'
    AND oo.order_delivered_customer_date IS NOT NULL;
        
# Revenue Loss: $ 587,789

SELECT
  ROUND(SUM(payment_value), 0) AS gross_revenue,
  ROUND(SUM(CASE 
	  	WHEN oo.order_status = 'canceled' THEN NULL 
  		WHEN oo.order_delivered_customer_date IS NULL THEN NULL
            ELSE payment_value 
            END)) AS adjusted_revenue,
  ROUND(SUM(payment_value) 
	- (SUM(CASE WHEN oo.order_status = 'canceled' THEN NULL 
  		    WHEN oo.order_delivered_customer_date IS NULL THEN NULL	
               ELSE payment_value 
               END)), 0) AS loss
FROM olist_orders oo
JOIN 
     olist_payments opa ON oo.order_id = opa.order_id;  

# AOV: $161, CPO: $138

SELECT 
   ROUND(SUM(opa.payment_value) / COUNT(oo.order_id),2) AS AOV,
   ROUND(SUM(oi.cost) / COUNT(oo.order_id),2) AS CPO	
FROM
   olist_orders oo
JOIN 
    (SELECT 
        oo.order_id AS order_id,
        SUM(payment_value) AS payment_value
     FROM 
     	olist_payments opa 
     JOIN 
     	olist_orders oo ON oo.order_id = opa.order_id
     GROUP BY order_id) AS opa ON oo.order_id = opa.order_id 
JOIN
    (SELECT 
        oo.order_id AS order_id,
        SUM(price) AS cost
     FROM
     	olist_items oi 
     JOIN 
     	olist_orders oo ON oo.order_id = oi.order_id
	GROUP BY order_id) AS oi ON oo.order_id =  oi.order_id;  
   
# Quarterly sales

SELECT 
   YEAR(oo.order_purchase_timestamp) AS the_year,
   QUARTER(oo.order_purchase_timestamp) AS the_quarter,
   ROUND(SUM(opa.payment_value), 0) AS revenue
FROM 
    olist_orders oo 
JOIN 
    olist_payments opa ON oo.order_id = opa.order_id 
WHERE 
     oo.order_status <> 'canceled'
     AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY 
    the_year, the_quarter
ORDER BY 
    the_year, the_quarter;
   
# monthly sales

SELECT 
   YEAR(oo.order_purchase_timestamp) AS the_year,
   QUARTER(oo.order_purchase_timestamp) AS the_quarter,
   MONTH(oo.order_purchase_timestamp) AS the_month,
   ROUND(SUM(opa.payment_value), 0) AS revenue
FROM 
    olist_orders oo 
JOIN 
    olist_payments opa ON oo.order_id = opa.order_id 
WHERE 
     oo.order_status <> 'canceled'
     AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY 
    the_year, the_quarter, the_month
ORDER BY
	the_year, the_quarter, the_month;
   
## --- ORDERS ---

# Total orders: 99,441   

SELECT
   COUNT(*) AS order_count
FROM
   olist_orders oo  
   
# Valid orders: 96,470
	
SELECT
   COUNT(*) AS Valid_order_count
FROM
   olist_orders oo
WHERE
   order_status <> 'canceled'
    AND order_delivered_customer_date IS NOT NULL;
   
# Quarterly orders

SELECT
   YEAR(order_purchase_timestamp) AS the_year,
   QUARTER(order_purchase_timestamp) AS the_quarter,
   COUNT(*) AS num_order
FROM
   olist_orders oo
WHERE
   order_status <> 'canceled'
   AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY
   the_year, the_quarter
ORDER BY
   the_year, the_quarter;

# monthly orders

SELECT
   YEAR(order_purchase_timestamp) AS the_year,
   MONTH(order_purchase_timestamp) AS the_month,
   COUNT(*) AS num_order
FROM
   olist_orders oo
WHERE
   order_status <> 'canceled'
   AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY
   the_year, the_month
ORDER BY
   the_year, the_month;

### ---- PRODUCT PERFORMANCE ---

# Total Product listed: 112,650
	
 SELECT
   COUNT(oi.product_id) AS total_product_id
FROM 
   olist_items oi

# Vaild product count:110,189
	
 SELECT
   COUNT(oi.product_id) AS total_product_id
FROM
   olist_items oi
JOIN 
   olist_orders oo ON oi.order_id = oo.order_id
WHERE
   oo.order_status <> 'canceled'
   AND oo.order_delivered_customer_date IS NOT NULL;

/* Valid Product Price: $13,220,249 Freight fee: $2,198,146 
 * avg_product_price :$120, avg_freight_fee: $20
 */
SELECT 
   ROUND(SUM(price), 0) AS product_price,
   ROUND(SUM(freight_value), 0)AS freight_fee,
   ROUND(AVG(price), 0) AS avg_product_price,
   ROUND(AVG(freight_value), 0)AS avg_freight_fee
FROM 
   olist_items oi 
JOIN 
   Olist_orders oo ON oo.order_id = oi.order_id
WHERE
   oo.order_status <> 'canceled'
   AND oo.order_delivered_customer_date IS NOT NULL; 

/* Most popular product categories by product price:
 * health_beauty, watches_gifts, bed_bath_table
 */

SELECT 
   op.product_category_name_english AS product_name,
   ROUND(SUM(price),0) AS product_price
FROM 
    olist_orders oo
JOIN 
    olist_items oi ON oo.order_id = oi.order_id 
JOIN
    (SELECT
        product_id,
        product_category_name_english
     FROM 
        olist_products op) AS op ON oi.product_id = op.product_id
WHERE
    oo.order_status <> 'canceled'
    AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY
    product_name
ORDER BY 
    product_price  DESC;
   
/* Most popular product categories by orders:
 * bed_bath_table, health_beauty,sports_leisure
 */

SELECT 
   op.product_category_name_english AS product_name,
   COUNT(oo.order_id) AS num_orders
FROM 
    olist_orders oo
JOIN 
    olist_items oi ON oo.order_id = oi.order_id 
JOIN
    (SELECT
        product_id,
        product_category_name_english
     FROM 
        olist_products op) AS op ON oi.product_id = op.product_id
WHERE
    oo.order_status <> 'canceled'
    AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY
    product_name
ORDER BY 
    num_orders DESC;

### --- MARKETPLACE PERFORMANCE ---

# Total sellers :3,095

SELECT
   COUNT(DISTINCT seller_id) 
FROM
   olist_sellers os; 

# Active sellers: 1,786

SELECT
   COUNT(seller_id) AS num_active_sellers
FROM (
      SELECT
	 seller_id,
	 DATEDIFF(MAX(order_purchase_timestamp), MAX(previous_order_date)) AS days_between_orders
      FROM(
      	   SELECT
              oi.seller_id, 
	      oo.order_id,
	      oo.order_purchase_timestamp,
	      LAG(oo.order_purchase_timestamp, 1) 
	           OVER (PARTITION BY oi.seller_id ORDER BY oo.order_purchase_timestamp) AS previous_order_date
	    FROM
	       Olist_orders oo
	    JOIN 
	        (SELECT 
		   si.seller_id AS seller_id,
		   oi.order_id,
		   COUNT(oi.order_item_id) AS order_item_count
		 FROM 
		   olist_items oi
	    JOIN 
		(SELECT 
		   order_id,
		   COUNT(DISTINCT seller_id) AS distinct_seller_count
		 FROM 
		   olist_items
		 GROUP BY 
	           order_id
-- 	         HAVING 
-- 		   COUNT(DISTINCT seller_id) > 1
		 ) AS subquery ON oi.order_id = subquery.order_id
	JOIN 
	    (SELECT 
		order_id,
		seller_id
	     FROM 
		olist_items
	     GROUP BY 
		 order_id, seller_id
	     ) AS si ON oi.order_id = si.order_id
	         GROUP BY 
		    oi.order_id, si.seller_id
	         ORDER BY 
	            si.seller_id,oi.order_id) AS oi ON oi.order_id = oo.order_id	
		 WHERE
	            oo.order_status <> 'canceled'
		    AND oo.order_delivered_customer_date IS NOT NULL
		 ORDER BY
		    oi.seller_id,
		   oo.order_purchase_timestamp DESC				
	      ) AS second_last_order_date
GROUP BY
   seller_id
HAVING
   DATEDIFF(MAX(order_purchase_timestamp), MAX(previous_order_date)) <= 30
   AND DATEDIFF(MAX(order_purchase_timestamp), MAX(previous_order_date)) IS NOT NULL
ORDER BY
   DATEDIFF(MAX(order_purchase_timestamp), MAX(previous_order_date))
) AS active_seller;

#  Distinct customers: 96,096

SELECT 
   COUNT(DISTINCT customer_unique_id) AS customers
FROM 
   olist_customers oc 

# Valid customers: 93,350

SELECT 
   COUNT(DISTINCT customer_unique_id)
FROM 
   olist_customers oc 
JOIN Olist_orders oo ON oo.customer_id = oc.customer_id 
WHERE
   oo.order_status <> 'canceled'
   AND oo.order_delivered_customer_date IS NOT NULL;
	
##  --- Repeat customers:2,801
   
SELECT
   COUNT(*) AS num_repeat_customer
FROM
   (
    SELECT 
	oc.customer_unique_id AS re_customer,
	COUNT(DISTINCT oo.order_id) AS num_re_customers
    FROM
	olist_orders oo
    JOIN 
        olist_customers oc ON oo.customer_id = oc.customer_id
    WHERE
	oo.order_status <> 'canceled'
	AND oo.order_delivered_customer_date IS NOT NULL 
    GROUP BY
	re_customer
    HAVING
	COUNT(oo.order_id) >1
    ORDER BY
	num_re_customers DESC) AS repeat_customers;

# Average review score: 4.1

SELECT
   ROUND(AVG(ore.review_score), 1) AS avg_review
FROM
   olist_orders oo
JOIN olist_reviews ore ON
	oo.order_id = ore.order_id
WHERE
   order_status <> 'canceled'
   AND order_delivered_customer_date IS NOT NULL;

### --- DELIVERY PERFORMANCE ---

# Total order: 99,441

SELECT 
   COUNT(order_id)
FROM 
   Olist_orders oo 

# Delivered: 96,478

SELECT 
   COUNT(order_id)
FROM 
   Olist_orders oo 
WHERE 
   order_status = 'delivered';

# On-time Delivery: 89,936

SELECT 
   COUNT(order_id)
FROM
   Olist_orders oo 
WHERE order_status = 'delivered'
   AND order_delivered_customer_date IS NOT NULL
   AND DATEDIFF(oo.order_estimated_delivery_date,
		oo.order_delivered_customer_date) >= 0;

# Average Delivery Days: 12

SELECT 
   ROUND(AVG(
	    DATEDIFF(order_delivered_customer_date,
	    order_approved_at)), 0) AS Avg_delivery_day
FROM Olist_orders oo 
WHERE order_status = 'delivered'
   AND order_delivered_customer_date IS NOT NULL
   AND order_approved_at IS NOT NULL;

# Total Delayed Orders: 6,534

SELECT 
   COUNT(oo.order_id)
FROM 
   Olist_orders oo
WHERE order_status <> 'canceled'
   AND order_delivered_customer_date IS NOT NULL
   AND DATEDIFF(oo.order_estimated_delivery_date,
		oo.order_delivered_customer_date) < 0;

# --- Order Delayed due to seller not shipping products to carriers on time: 1,460

SELECT 
   COUNT(DISTINCT oo.order_id)
FROM 
   Olist_orders oo
JOIN olist_items oi ON oo.order_id  = oi.order_id
WHERE order_status <> 'canceled'
   AND order_delivered_customer_date IS NOT NULL
   AND DATEDIFF(oo.order_delivered_carrier_date, oi.shipping_limit_date) > 0
   AND DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date) > 0;

### --- REGIONAL PERFORMANCE ---

# Top seller locations: SP, PR, MG, RJ, SC

SELECT 
   os.seller_state,
   ROUND(SUM(price),0) AS product_price
FROM 
   Olist_orders oo 
JOIN olist_items oi ON oo.order_id = oi.order_id
JOIN olist_sellers os ON oi.seller_id  = os.seller_id
WHERE 
   order_status <> 'canceled'
   AND order_delivered_customer_date IS NOT NULL
GROUP BY 
   os.seller_state
ORDER BY
   product_price DESC;

# Top Revenue locations: SP, RJ,MG,RS, PR

SELECT 
   oc.customer_state,
   ROUND(SUM(payment_value),0) AS revenue
FROM 
   Olist_orders oo 
JOIN olist_payments op  ON oo.order_id = op.order_id
JOIN olist_customers oc ON oo.customer_id  = oc.customer_id 
WHERE 
   order_status <> 'canceled'
   AND order_delivered_customer_date IS NOT NULL
GROUP BY 
   oc.customer_state
ORDER BY 
   revenue DESC;
   
