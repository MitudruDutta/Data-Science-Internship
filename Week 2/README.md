# Week 2: E-Commerce Analytics & Electric Vehicle Market Analysis

This directory contains two distinct data analysis tasks completed during the second week of the internship. The tasks focus on deriving actionable business insights using Python (Pandas) and SQL.

---

## 📁 Task 1: E-Commerce Customer Analysis (Python)

### 📌 Overview
This task analyzes customer behavior data from an e-commerce platform. The goal is to understand demographics, spending patterns, and identify key drivers for cross-selling success.

### 🎯 Key Objectives
- Analyze customer demographics (Age, Gender) and their correlation with purchasing behavior.
- Investigate the relationship between the time spent on the website and the average monthly amount spent.
- Evaluate the **Cross-Sell Conversion Rate**, which indicates the probability of a customer purchasing additional items after an initial purchase.

### 🛠️ Tech Stack & Files
- **Tools**: Python, Pandas, Matplotlib, Seaborn
- **Main Notebook**: `Task 1/task1.ipynb`
- **Data Attributes**: Customer ID, Gender, Age, Number of Purchases, Amount Spent, Time Spent on Site, Cross-Sell Conversion Rate.

---

## 📁 Task 2: Electric Vehicle (EV) Market Analysis (SQL)

### 📌 Overview
This task involves querying a relational database (`ev_sales_db`) to analyze the rapidly growing Electric Vehicle market in India. The analysis covers both 2-wheeler and 4-wheeler categories across different states and manufacturers.

### 🎯 Key Objectives
- Identify top-performing EV manufacturers (makers) across different fiscal years.
- Calculate and analyze key market metrics:
  - **Penetration Rate**: The percentage of total vehicles sold that are electric `(Electric Vehicles Sold / Total Vehicles Sold) * 100`.
  - **Compound Annual Growth Rate (CAGR)**: Evaluating the year-over-year sales growth of top manufacturers.
- Analyze geographical trends to see which states lead in EV adoption.

### 🛠️ Tech Stack & Files
- **Tools**: SQL (MySQL/PostgreSQL compatible)
- **Queries File**: `Task 2/sql/fixed_sql_queries.sql`
- **Database Schema**:
  - `electric_vehicle_sales_by_state`: Sales data aggregated by state and vehicle category.
  - `electric_vehicle_sales_by_makers`: Sales data aggregated by manufacturer and vehicle category.
  - `dim_date`: Date dimension table including fiscal years and quarters.

---

## 🚀 How to Run
- **For Task 1**: Navigate to the `Task 1` folder and run `jupyter notebook task1.ipynb`.
- **For Task 2**: Import the SQL dump (if available) into your preferred SQL RDBMS and execute the queries found in `Task 2/sql/fixed_sql_queries.sql`.

*Note: Raw datasets and database dumps have been excluded from this repository via `.gitignore`.*
