CREATE SCHEMA Olist;

USE Olist;

/* DATA PREPARATION 
 Check duplicates by distinct count. Found no duplicate rows in all tables.
*/

SELECT 
	order_id,
	COUNT(*)
FROM  olist_orders oo
GROUP BY oo.order_id 
HAVING COUNT(*)>1; 

# --- 99,441 rows ---
	
SELECT
	COUNT(*)
FROM olist_orders oo;

# --- update tables ---

ALTER TABLE olist_products 
ADD COLUMN product_category_name_english VARCHAR(255);

UPDATE  olist_products op
JOIN product_category_name_translation pcnt 
   ON op.product_category_name  = pcnt.product_category_name
SET op.product_category_name_english = pcnt.product_category_name_english; 


/*update empty spaces in 'product_category_name' and NULL values in 'product_category_name_english' 
 *olist_product_dataset has null values of 610 
 */

SELECT 
   product_category_name,
   product_category_name_english
FROM olist_products op 
WHERE product_category_name =' ';

UPDATE olist_products
SET product_category_name = 'N/A'
WHERE product_category_name ='';

UPDATE olist_products 
SET product_category_name_english = 'N/A'
WHERE product_category_name_english IS NULL;

SELECT 
   product_category_name,
   product_category_name_english
FROM olist_products op 
WHERE product_category_name_english = 'N/A';

# ---'portateis_cozinha_e_preparadores_de_alimentos' = portable kitchens and food preparers ---

SELECT 
   product_category_name,
   product_category_name_english
FROM olist_products op 
WHERE product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos'

UPDATE olist_products 
SET product_category_name_english = 'portable kitchens and food preparers'
WHERE product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos';

UPDATE olist_products 
SET product_category_name_english = 'pc_gamer'
WHERE  product_category_name = 'pc_gamer'
