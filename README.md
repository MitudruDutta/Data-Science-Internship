# Nova Mart FMCG Promotion Analysis

This project analyzes promotional campaign performance for **Nova Mart** and answers client-facing business questions using data visualization and KPI-based insights.

## Business Problem
Nova Mart runs promotional campaigns (for example, Diwali and Sankranti) across multiple cities and product categories.  
The client needs to understand:
- Which cities and categories respond best to promotions
- Which promotion types drive volume vs revenue
- Where campaign strategy should be optimized

## Analysis Objectives
The analysis is built around two core business KPIs:
- **IR% (Incremental Revenue %)**  
  `((Revenue After Promo - Revenue Before Promo) / Revenue Before Promo) * 100`
- **ISU% (Incremental Sold Units %)**  
  `((Units Sold After Promo - Units Sold Before Promo) / Units Sold Before Promo) * 100`

## What Was Solved
The notebooks answer client questions such as:
- City-level store footprint and promotion response
- Category contribution to campaign sales
- Relationship between post-promo price and sales quantity
- City-wise ISU% comparison
- Promo-type performance trade-offs (IR% vs ISU%)
- Category-wise revenue impact before vs after promotions

## How the Analysis Was Done
1. Load and clean campaign event data.
2. Join fact data with store, product, and campaign dimensions.
3. Create derived revenue fields (`revenue_before`, `revenue_after`).
4. Compute `IR%` and `ISU%` at city/category/promo-type levels.
5. Build charts using `Matplotlib` and `Seaborn`.
6. Convert outputs into presentation-ready insights.

## How to Run
1. Create and activate a Python environment.
2. Install dependencies:
   `pip install -r requirements.txt`
3. Launch Jupyter:
   `jupyter notebook`
4. Run the notebooks in order:
   - `Week 1/Task 1/task1.ipynb`
   - `Week 1/Task 2/task2.ipynb`

## Notes
- Raw datasets and `client_requests.pdf` files are intentionally excluded via `.gitignore`.
- Presentation/script helper files are also excluded from Git tracking for clean GitHub publishing.
