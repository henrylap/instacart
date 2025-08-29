## Table of Contents
- [Project Background](#project-background)
- [Tools Used](#tools-used)
- [Data Description](#data-description)
- [Executive Summary](#executive-summary)
- [Key KPIs](#key-kpis)
- [Exploratory Insights](#exploratory-insights)
  - [Customer Retention](#customer-retention)
  - [Basket Analysis](#basket-analysis)
  - [Order Behavior Over Time](#order-behavior-over-time)
  - [Product & Category Insights](#product--category-insights)
- [Recommendations](#recommendations)

## Project Background
Instacart is a U.S.-based online grocery delivery and pickup platform, partnering with over 1,800 retailers and servicing more than 100,000 individual stores.  

This project analyzes a combined dataset of ~1.4 million orders across ~120,000 users, created by joining the **prior** and **train** order subsets. The analysis focuses on market behavior, including customer retention, basket analysis, order behavior over time, and product & category insights.

## Tools Used
- [Alteryx for data preparation (joins)](./alteryx-workflow)
- [PostgreSQL for querying and analysis](./sql-eda)
- Tableau for basic visualizations (pictured below)

## Data Description
1. **Orders** – Contains information on each order placed, including order ID, user ID, order number, evaluation set (prior/train/test), day of week, hour of day, and days since prior order.  
2. **Order_Products** – Line-item detail linking orders to products purchased, including product ID, add-to-cart order, and whether the product was reordered. Provided in two subsets:  
   - `order_products__prior` (historical orders)  
   - `order_products__train` (final orders with released products)  
3. **Products** – Contains product-level details, including product ID, product name, aisle ID, and department ID.  
4. **Aisles** – Describes aisle IDs and aisle names.  
5. **Departments** – Describes department IDs and department names.

*Dataset link: https://www.kaggle.com/datasets/yasserh/instacart-online-grocery-basket-analysis-dataset*

_Relational Schema of the Instacart dataset_

<table>
  <tr>
    <td><img width="584" height="357" alt="instacart RS" src="https://github.com/user-attachments/assets/7dc912b7-caf9-44a5-8c1f-f0b63805f93a" /></td>
   </tr>
</table>


## Executive Summary
Instacart's basket analsyis of around 1.4 million orderes across 120k users showed an average basket size of 3 items and an overall reorder rate near 80%. Sunday and Monday were the top two days in terms of order volume, with most activity occuring between 9 AM and 4 PM. Produce was the leading department with around 1.4 million items purchased, and a high reorder rate of around 81%. Regarding customer retention, 93% of users placed at least two orders, however that share dropped to 64% at five orders and 37% at ten. Basket analysis revealed that Instacart is mostly used for specific, time-sensitive needs as 35% of all orders only contained one item.
 

## Key KPIs
<table>
  <tr>
    <td><img width="1104" height="106" alt="Screenshot 2025-08-28 at 5 36 37 PM" src="https://github.com/user-attachments/assets/c2948617-6412-4f04-ad82-e88f8112302f" /></td>
   </tr>
</table>


## Exploratory Insights

### Customer Retention
Most users who continue to use Instacart place their second order within 7 days, and there's another group that waits until about 30 days. In total, 93% of users placed at least two orders, however the share drops to 64% at five orders and 37% at ten. Once a customer reaches 5+ orders, however, their loyalty becomes relativelty strong with reorder rates stablizing above 90%.


<table>
  <tr>
    <td><img width="1003" height="562" alt="Days Until Second Order" src="https://github.com/user-attachments/assets/afd33a71-9117-428e-9c7e-fc306b4f8822" /></td>
    <td><img width="1000" height="565" alt="Reorder Rate by Order Number" src="https://github.com/user-attachments/assets/e2970966-4aad-47e2-87a4-8afac0499f14" /></td>
 </tr>
</table>


 ### Basket Analysis 
The data reveals that Instacart shoppers usually make small, time-sensitive purchases rather than a full-blown grocery run. With an overall average basket size of around 3 items, and 35% of all orders containing just one item, it's clear that the main use for the platform is for specific needs. This behavior is reinforced by the department diversity data, which shows that shoppers generally stick to a single department per order.

<table>
  <tr>
  <td><img width="878" height="601" alt="Basket Distribution" src="https://github.com/user-attachments/assets/35752b2d-bf93-4ee2-b226-6c20e35aaa05" /><td>
  <td><img width="744" height="608" alt="Department Diversity" src="https://github.com/user-attachments/assets/e7cf0262-5ab4-4565-abcf-7a3ca0604863" /><td>
   </tr>
</table>

### Order Behavior Over Time
Order volume peaks on Sundays and Mondays, which indicates that customers are most likely to stock up at the start of the week. Furthermore, order activity increases heavily in the morning, peaks between 10 AM and 3 PM, and then slowly tapers off into the evening. Reorders, however, follow a different pattern, peaking in the morning hours (6 AM - 10 AM), especially on weekdays. While overall traffic peaks mid-day, repeat customers are more liekly to place orders earlier in the morning.

<table>
  <tr>
    <td><img width="400" height="400" alt="Order Volume by Day of Week" src="https://github.com/user-attachments/assets/5726ed86-e0d8-47cc-8295-1834aadcd8d4" /></td>
    <td><img width="500" height="500" alt="Order Volume by Hour of Day" src="https://github.com/user-attachments/assets/b2fe59e8-37d9-4b5e-9aac-11777b58cbbd" /></td>
  </tr>
</table>

<table>
  <tr>
    <td><img width="900" height=300" alt="Reorder Rate by Hour of Day" src="https://github.com/user-attachments/assets/25209990-2c2d-4722-8e56-9763f1940d0e" /></td>
   </tr>
</table>

### Product & Category Insights
Produce was the leading department in terms of total order volume with over 1.4 million orders, indicating that users rely on Instacart most often for fresh groceries. Behind produce was dairy & eggs and beverages. In terms of loyalty, dairy & eggs and beverages have the highest reorder rates hovering around 84%, slightly higher than produce which sits at around 81%. While produce drives the total order volume, customers are just as likely to keep coming back for packaged staples like drinks and dairy. In addition, when analyzing first-time orders, produce leads again, revealing that new users tend to start with fresh items before expanding in to other product departments and categories.

<table>
  <tr>
    <td><img width="986" height="389" alt="Top 15 dep by OV" src="https://github.com/user-attachments/assets/53ed1112-05bf-411a-a88e-39fe9dcdb28e" /></td>
   </tr>
</table>

<table>
  <tr>
    <td><img width="647" height="197" alt="1" src="https://github.com/user-attachments/assets/0538dca4-c26c-408a-a90b-30f96dc4c2ed" /></td>
    <td>
<img width="305" height="196" alt="2" src="https://github.com/user-attachments/assets/4a600564-77e4-414f-9152-5e79de367c1b" /></td>
   </tr>
</table>

## Recommendations

### Customer Retention

Instacart should further analyze inividual shopping patterns in order to classify customers as one-time, short-term, or loyal, recurring shoppers with predictable cycles. Promotions can then be timed around two key reorder windows (7 days and 30 days). Smaller incentives, such as a 5-10% discount or waived delivery fee would be appropriate to offer at 7 days, while larger promotions could be tested at the 30-day mark to retain less frequent users. Since loyalty dramatically strengthens after ~5 orders, the highest leverage is converting first-time shoppers into reoccuring users. Sustained promotions targeted around that first to second order gap would greatly increase the chance of repeat use.

## Basket Analysis
Instacart users often use the platform for niche, time-sensitive needs, averaging only three items and typically confined within a single product department. Instacart could use this as an opportunity to grow order value by promoting cross-department add-ons, such as curated bundles, and using personalized reccomendations in an attempt to expand basket size. Incentives such as discounts and waived delivery fees are a perfect way to push shoppers towards larger purchases.

### Order Behavior Over Time

Instacart already issues push notificatons, but they can be slightly generic. These could be improved by tying offers directly to peak activity windows (10 AM - 3 PM) and peak days (Sunday and Monday). Examples could include, "Order within the next 2 hours to save on delivery fees" or "Stock up today and save 10%." Targeted messages for repeat shoppers, who often shop earlier in the morning (6 AM - 10 AM), would further enhance engagement. That way, these notifications can act as time-sensitive purchase drivers.

### Product & Category

Instacart should target promotional offers on leading departments by order volume, namely produce and dairy & eggs. While these categories already show high reorder rates, their greater significance is that they make up most customers’ first orders. Promotions could include bundled items within produce, dairy & eggs, or across both. In addition, Instacart could enhance its recipe feature by linking curated recipes directly to promotional bundles, turning them into a lever to grow basket size.

