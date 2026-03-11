# Zepto-data-analysis project

📊 Project Overview

This project performs end-to-end data analysis on a Zepto product dataset using PostgreSQL. The goal is to explore product pricing, discounts, inventory distribution, and revenue contribution across categories in order to derive meaningful business insights for a quick-commerce platform.

The analysis demonstrates how SQL can be used to transform raw product data into actionable insights for business decision-making.

📌 Project Overview

The goal is to simulate how actual data analysts in the e-commerce or retail industries work behind the scenes to use SQL to:

✅ Set up a messy, real-world e-commerce inventory database

✅ Perform Exploratory Data Analysis (EDA) to explore product categories, availability, and pricing inconsistencies

✅ Implement Data Cleaning to handle null values, remove invalid entries, and convert pricing from paise to rupees

✅ Write business-driven SQL queries to derive insights around pricing, inventory, stock availability, revenue and more

📁 Dataset Overview

The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

🧾 Columns:

    * sku_id: Unique identifier for each product entry (Synthetic Primary Key)

    * name: Product name as it appears on the app

    * category: Product category like Fruits, Snacks, Beverages, etc.

    * mrp: Maximum Retail Price (originally in paise, converted to ₹)

    * discountPercent: Discount applied on MRP

    * discountedSellingPrice: Final price after discount (also converted to ₹)

    * availableQuantity: Units available in inventory

    * weightInGms: Product weight in grams

    * outOfStock: Boolean flag indicating stock availability

    * quantity: Number of units per package (mixed with grams for loose produce)

🛠 Tools & Technologies

* PostgreSQL

* SQL

* Kaggle Dataset

* GitHub


🔧 Project Workflow

Kaggle Dataset
      ↓
Data Import into PostgreSQL
      ↓
Data Cleaning
      ↓
Exploratory Data Analysis
      ↓
Business Analysis Queries
      ↓
Business Insights & Recommendations


Here’s a step-by-step breakdown of what we do in this project:
1. Database & Table Creation

* We start by creating a SQL table with appropriate data types:
CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER
);

2. Data Import

    * Loaded CSV using pgAdmin's import feature.

   * If you're not able to use the import feature, write this code instead:
   
    \copy zepto(category,name,mrp,discountPercent,availableQuantity,
            discountedSellingPrice,weightInGms,outOfStock,quantity)
  FROM 'data/zepto_v2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');

   * Faced encoding issues (UTF-8 error), which were fixed by saving the CSV file using CSV UTF-8 format.

   3. 🔍 Data Exploration

    * Counted the total number of records in the dataset

    * Viewed a sample of the dataset to understand structure and content

    * Checked for null values across all columns

    * Identified distinct product categories available in the dataset

    * Compared in-stock vs out-of-stock product counts

    * Detected products present multiple times, representing different SKUs

4. 🧹 Data Cleaning

    * Identified and removed rows where MRP or discounted selling price was zero

    * Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability

5.    📊 Business Insights

  📌 Revenue Concentration

A few product categories contribute a large share of the total estimated revenue, indicating that Zepto’s sales are concentrated in specific high-demand categories.

📌 Discount Strategy

Certain categories show significantly higher average discounts, suggesting aggressive promotional strategies to drive customer purchases.

📌 Premium Product Segments

Ranking analysis highlights premium products within several categories, indicating opportunities for higher-margin sales.

📌 Inventory Distribution

Large inventory value is concentrated in essential grocery categories, which likely represent the core demand on the platform.

📌 Best Value Products

Price-per-gram analysis identifies products offering superior value for customers, which can influence purchasing decisions.

📌 Stock Availability Risks

Several high-priced products are out of stock, which may represent missed revenue opportunities.


💡Recommendations-
Based on the analysis, the following recommendations can be made:

* Improve Stock Management-

  Ensure high-value products remain in stock to prevent lost revenue.

* Optimize Discount Strategies-

  Evaluate discount levels across categories to balance sales growth and profitability.

* Focus on High-Revenue Categories-

  Prioritize inventory and marketing efforts for categories contributing the most revenue.

* Promote Best-Value Products-

  Highlight products with lower price-per-gram ratios to attract price-sensitive customers.

  SQUERY VIEW-
  <img width="1329" height="880" alt="Best_value_products" src="https://github.com/user-attachments/assets/a4aaca14-fd36-4895-893a-ccd140e6002a" />
<img width="1349" height="883" alt="Expensive_products_per_category" src="https://github.com/user-attachments/assets/871e7cec-3569-45c7-a556-a9eac73f29ee" />
<img width="1260" height="875" alt="Highest_discount_pct" src="https://github.com/user-attachments/assets/7c96a51e-4240-4204-aff6-f07580a065ae" />
<img width="1200" height="793" alt="out_of_stock" src="https://github.com/user-attachments/assets/8b300254-4652-4d7b-b0bf-1e35a8c9574d" />
<img width="1172" height="879" alt="Revenue_by_category" src="https://github.com/user-attachments/assets/f689a0c1-e7ff-4700-b027-a61b9f064f11" />



