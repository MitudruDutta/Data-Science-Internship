# Data Science & Machine Learning Internship Portfolio

This repository contains the projects and tasks completed during a comprehensive Data Science and Machine Learning internship. The work spans across data analysis, SQL querying, and an end-to-end machine learning application deployment.

The repository is structured into distinct weeks, each focusing on different skill sets and business domains.

---

## 📁 Repository Structure

### 🔹 Week 1: FMCG Promotion Analysis (Nova Mart)
This week focused on analyzing promotional campaign performance for an FMCG brand to answer client-facing business questions using data visualization and KPI-based insights.
- **Core KPIs**: Analyzed Incremental Revenue (IR%) and Incremental Sold Units (ISU%).
- **Key Deliverables**: 
  - Explored which cities and product categories responded best to specific promotional campaigns (e.g., Diwali, Sankranti).
  - Evaluated the effectiveness of various promo types (BOGOF, 50% Off, Cashback) on volume versus revenue.
- **Tech Stack**: Python, Pandas, Matplotlib, Seaborn, Jupyter Notebooks.

### 🔹 Week 2: E-Commerce Analytics & EV Sales SQL Analysis
This week was split into two distinct analytical tasks:
- **Task 1: E-commerce Customer Analysis (Python)**
  - Analyzed customer demographics, spending habits, and site engagement.
  - Explored factors affecting the *cross-sell conversion rate* to understand how likely a customer is to buy extra products.
- **Task 2: Electric Vehicle (EV) Market Analysis (SQL)**
  - Executed advanced SQL queries to analyze EV sales data across Indian states and manufacturers.
  - Computed financial and market metrics such as *Penetration Rate* and *Compound Annual Growth Rate (CAGR)* across different fiscal years.

### 🔹 Week 3 and 4: CodeX Beverage Price Prediction (End-to-End ML)
The capstone project involved building a complete Machine Learning solution to predict the optimal price range for a new energy drink based on consumer survey responses.
- **Data Pipeline**: Cleaned raw survey data and engineered derived features (e.g., Health Concern scores, Brand Awareness).
- **Modeling**: Trained and evaluated various classification models (LightGBM, XGBoost, Random Forest, SVM) and tracked experiments using MLflow.
- **Deployment**: 
  - Developed a **FastAPI** backend to serve the serialized LightGBM model.
  - Built an interactive **Streamlit** frontend allowing users to input consumer profiles and instantly receive pricing predictions along with model confidence probabilities.
- **Tech Stack**: Scikit-Learn, LightGBM, MLflow, FastAPI, Streamlit, Pandas.

---

## 🚀 How to Run the Projects

1. **Clone the repository** and navigate to the project root.
2. **Create a virtual environment** and install dependencies:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   pip install -r requirements.txt
   ```
3. **Navigating the Code**:
   - For **Week 1 & 2** (Analysis): Open Jupyter Notebook (`jupyter notebook`) and navigate to the respective `.ipynb` files.
   - For **Week 3 and 4** (CodeX Project Web App): Navigate to the `Week 3 and 4/CodeX Project` directory and follow the instructions in its specific `README.md` to start the FastAPI server and Streamlit frontend.

---

## 📝 Notes & Data Privacy
- Raw datasets, specific client instruction PDFs, and database dump files are intentionally excluded via `.gitignore` to maintain confidentiality and reduce repository size.
- Presentation scripts and helper files generated during the process are also untracked to keep the repository clean.
