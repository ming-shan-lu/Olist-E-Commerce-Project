# Project Background

Founded in 2015, Olist is an e-commerce platform that connects small and medium-sized businesses with customers across Brazil. Operating as a digital marketplace, it enables merchants to list their products while customers browse, purchase, and review items in one centralised platform.

This project explores Olist’s data across sales, logistics, customer engagement, and operational efficiency. By analysing historical trends and key performance metrics, the report aims to generate data-driven insights and actionable recommendations that support Olist’s efforts in improving customer retention, operational reliability, and overall marketplace competitiveness. 

Insights and recommendations are provided on the following key areas:

  * **Sales Trends Analysis:** An evaluation of historical sales patterns focusing on revenue growth, order volume fluctuations, and changes in average order value (AOV). These trends help identify seasonal impacts, peak periods, and long-term performance shifts.
  * **Product Level Performance:** An Analysis of seller product lines to understand which categories and items drive the most revenue and customer interest. This includes identifying high-performing products and underperforming segments to guide inventory and marketing strategies.
  * **Marketplace Performance:** Assessment of key seller and customer metrics, including total sellers, active sellers, new and returning customers, as well as net performance score (NPS) and average review scores. This section uncovers user engagement trends and evolving sales behaviours.
  * **Logistics and Delivery Performance:** Evaluation of order fulfilment efficiency, focusing on delivery status, on-time-delivery rates, average delivery time, and delay attribution between sellers and carriers. Recommendations are provided to enhance supply chain reliability and customer satisfaction.
  * **Regional Comparisons and logistics:** Comparative analysis of sales and logistics metrics across Brazilian states, highlighting top-performing regions in terms of seller and revenue contribution, supporting regional strategy optimisation.

An interactive Power BI dashboard is available for viewing [here](https://app.powerbi.com/view?r=eyJrIjoiMGFiZjliNTgtNThhMS00NTE1LWI4Y2ItOTIwOTYzNjNlM2RiIiwidCI6IjJmOTEzM2NiLWJhNGEtNDFmYy1hZGQ5LTZjMGEzZTYwY2Q4ZSJ9&pageName=1570e4f308109be8638c).

The SQL queries utilised to inspect and perform quality checks can be found [here](https://github.com/ming-shan-lu/Olist-E-Commerce-Project/blob/main/Olist_1_DataPreparation.sql). 

Targeted SQL queries regarding various business questions can be found [here](https://github.com/ming-shan-lu/Olist-E-Commerce-Project/blob/main/Olist_2_sales_analysis.sql).

# Data Structure & Initial Checks

Olist’s database structure, as shown below, comprises seven tables: orders, items, customers, reviews, payments, sellers, and products, totalling 99,441 records.

<img width="1217" alt="1_Olist_ERD" src="https://github.com/user-attachments/assets/9f7d97f0-b0d7-455b-bddf-15778f37eff8" />

Before the analysis, various checks were conducted to control quality and familiarise the datasets. The SQL queries utilised to inspect and perform quality checks can be found [here](https://github.com/ming-shan-lu/Olist-E-Commerce-Project/blob/main/Olist_1_DataPreparation.sql).

# Executive Summary
### Overview of Findings

Since December 2016, Olist has experienced steady revenue growth, peaking in November 2017. Following this high point, revenue stabilised at around one million Brazilian Real.

In August 2018, the platform saw a sharp **450%** surge in active sellers. However, this expansion translated into only a modest 3% increase in order volume. Notably, total revenue fell by **4%**, and the average order value (AOV) declined from **R$170** to **R$157**. This pattern suggests that while seller activity grew, many newcomers may have entered with lower-priced items, contributing to smaller basket sizes per transaction.

The visual below provides an overview page from the Power BI dashboard; additional dashboard examples and detailed analyses are included throughout this report. The full interactive dashboard is accessible [here](https://app.powerbi.com/view?r=eyJrIjoiMGFiZjliNTgtNThhMS00NTE1LWI4Y2ItOTIwOTYzNjNlM2RiIiwidCI6IjJmOTEzM2NiLWJhNGEtNDFmYy1hZGQ5LTZjMGEzZTYwY2Q4ZSJ9&pageName=1570e4f308109be8638c).

![2_Olist_overview](https://github.com/user-attachments/assets/bbcac142-d088-4249-bc38-93a32887e1a1)

### Latest Performance Summary: July vs August 2018
<img width="920" alt="3_table" src="https://github.com/user-attachments/assets/22817253-503a-4512-a10d-376a97d6dda0" />

# Insights Deep Dive

### Historical Sales Trend Analysis:
  * The company’s monthly sales peaked in **November 2017**, with **7,288 orders** and a **revenue of R$1,153,393**. Although there was a slight dip in December, overall sales performance stabilised, averaging around **R$ 1 million per month** thereafter.
    
  * In **2018**, the company experienced significant **revenue growth of 22%**, despite data being available for only the first eight months of the year. By August 2018, total revenue had already surpassed that of 2017. A comparison of monthly averages shows an **83% increase in 2018 (R$1,056,491)** compared to **2017 (R$576,881)**. If the trend continues, the year-end revenue for 2018 could double that of 2017.<img width="1018" alt="4_revenue orders" src="https://github.com/user-attachments/assets/bdef4138-532c-49b8-aed0-3be3c1d566bc" /> 
  * In most months, a notable pattern was observed: **as order volume increased, the average order value (AOV) decreased**. This suggests a shift toward a volume-based growth strategy. Despite the lower AOV, total revenue and order volume continue to rise, reflecting successful customer acquisition and an expanding market reach. Profitability remained strong during this period, indicating healthy margins and scalable operations.
    
<img width="1027" alt="5_mom%" src="https://github.com/user-attachments/assets/583aaf68-5d55-4b6f-b3ac-d3194f720e1b" />

*Note: Due to significant fluctuations and limited data in the early months, the area chart begins in April 2017 to better represent meaningful trends.*

### Product Level Performance:
  * Around **37%** of products sold fell into four key categories: **bed_bath_table, health_beauty, sports_leisure, and computers_accessories**. On the other hand, the **watches_gifts** category stands out with a higher average price of **R$199**, ranked second in terms of total product price value, which highlights its premium positioning despite lower sales volume.
  * The **Health_beauty** category demonstrated a notable upward trend in both sales volume and price, outperforming other leading categories.<img width="1046" alt="6_product_category" src="https://github.com/user-attachments/assets/731bc231-8aeb-4736-9dfe-f0369455d182" />
  * While revenue and order volume demonstrate a consistent upward trend, **fluctuations in AOV, cost per order (CPO), and average product price** highlight seasonal demand patterns. This suggests that although the platform is attracting more customers over time, their spending per order is influenced by cyclical or promotional factors throughout the year.<img width="714" alt="7_avo_cpo_avgprice" src="https://github.com/user-attachments/assets/de08c796-56b8-4e20-b1b1-5316a0d8681f" />
  * Despite an average product price of **R$120**, the most popular product (bed_bath_table) is priced lower at **R$93**, indicating a clear **customer preference for more affordable products**. This supports the broader observation of rising order volume, coupled with a declining AOV, underscoring a volume-based growth strategy.

### Marketplace Performance:
  * The Olist platform saw a **265% increase in total sellers** and a **450% increase in active sellers** in August 2018 compared to the previous month, indicating a substantial expansion of the seller base.
  * **Customer traffic** peaked at **7,182 in November 2017**, likely driven by seasonal promotions such as Black Friday. However, this was followed by a notable **24% decline** in December, down to 5,450. Despite the drop, customer numbers stabilised at around 6,000 in the months that followed, indicating that the platform retained a sustained user base after the promotion. 
  * Only **2,801** of Olist’s 93,350 customers were **repeat customers**, accounting for just **3%** of the total customer base. While customer satisfaction appears relatively high, with an average **review score** of **4** out of 5, the low repeat rate suggests that while Olist has been successful in attracting new customers, customer retention remains a challenge.<img width="1029" alt="8_seller_customers" src="https://github.com/user-attachments/assets/36caaa43-e1ff-4a6f-b335-01220d29e559" />
  * In terms of **shopping behaviour:** 
    - **Weekly Trends:**  Customers were more active between **Monday and Wednesday**, with activity tapering off toward the weekend. **Weekends consistently recorded the lowest revenue**, possibly due to decreased online engagement or routine shifts during leisure days.
    - **Daily Trends:** Revenue peaked in the **afternoon hours (1-4 PM)**, followed by a gradual decline in the evening, indicating that midday may be the most effective window for promotions and marketing efforts.
   
### Logistics and delivery:
  * Olist maintained a strong **on-time delivery rate of 93%**, with **89,936 out of 96,478 delivered orders** arriving as scheduled. However, delivery performance varied across time. For instance, during the sales peak in **November 2017**, the on-time delivery rate dropped to **88%**, while the lowest monthly rate was recorded in **March 2018, at 81%**.
  * **The average delivery time** across all regions was **12 days**, with **São Paulo** standing out as the fastest, averaging just **8** days. Notably, delivery speed improved in 2018, with a consistent downward trend in delivery days compared to 2017, except for **March 2018, which had 16 days**. 
  * Among the **6,534 delayed orders (7%), 1,460 orders (1.5%)** were delayed due to **sellers failing to hand over products to carriers on time**. While this represents a small portion of all orders, it accounts for over **22%** of delivery delays, pointing to a key upstream logistics bottleneck.![9_logistics](https://github.com/user-attachments/assets/fdfdfaa3-9d0f-47ac-9db0-2ace77289350)


### Regional Comparisons:
  * **São Paulo** dominates the marketplace, hosting **70%** of all **sellers** and generating **51%** of the total **revenue (R$5,769,081)**. Paraná and Minas Gerais follow with 10% and 8% of seller distribution, respectively. Rounding out the top five seller locations are Rio de Janeiro and Santa Catarina.
  * The top-selling product categories in São Paulo are **“bed_bath_table,” “health_beauty,” and “sports_leisure.”** These categories also rank among the top three in Rio de Janeiro and Minas Gerais, reflecting consistent consumer preferences across these high-performing states. Overall, top-selling states are concentrated in Brazil’s Southeast and South regions.![10_regional_sales](https://github.com/user-attachments/assets/b87cb9c5-da77-4416-b977-55b3b70dfaeb)


#  Recommendation:
1. Sales:
  * **Leverage high-traffic** periods such as November (Black Friday) by planning targeted promotions and campaigns.
  * **Balance volume and value** by offering bundles or upsells to increase AOV without sacrificing affordability.
  * Forecast sales and inventory using the consistent upward trend in order volume and seasonality in AOV/CPO to optimise stock and pricing. 
2. Products:
  * **Focus on high-performing categories** like bed_bath_table, health_beauty, and sport_leisure by expanding their product ranges or boosting visibility.
  * **Monitor cyclical trends** in product sales and align inventory and marketing campaigns with peak periods. (e.g., Q4 promotional seasons)
  * **Reinforce value offerings** in popular low-price products (~R$93) while maintaining profitability through scale or operational efficiency.
3. Marketplace:
  * **Boost customer retention** by enhancing post-purchase experiences (e.g., loyalty programs, personalised follow-ups), as repeat customers currently make up only 3%.
  * **Use review scores** to identify areas for service improvement and communicate customer satisfaction back to sellers.
  * **Encourage seller quality** by offering training or incentives for consistent performance and buyer experience, especially with the sharp rise in active sellers.
4. Logistics and Delivery:
  * **Improve logistics reliability** during high-volume months (e.g., November), as on-time delivery rates tend to drop during peaks.
  * **Address upstream bottlenecks**, even if small (1.5% due to seller’s delays), to enhance overall delivery reliability and protect brand reputation.
  * Continue reducing average delivery time, especially in slower regions, by analysing successful patterns in states like São Paulo (avg. 8 days).
5. Regions:
  * **Prioritise regional expansion** in underrepresented but high-potential areas, such as Minas Gerais and Paraná, based on current revenue contributions.
  * **Tailor product offerings** by region based on top-selling categories to improve relevance and sales performance.
  * **Utilise regional performance** insights to guide resource allocation in marketing, logistics infrastructure, and seller support.





