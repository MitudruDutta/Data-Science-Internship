USE ev_sales_db;

-- Q1) How many unique manufacturers / makers are there in the 2-wheeler category?
SELECT
    COUNT(DISTINCT maker) AS number_of_makers
FROM ev_sales_db.electric_vehicle_sales_by_makers
WHERE vehicle_category = '2-Wheelers';


-- Q2) Top 3 makers for fiscal years 2023 and 2024 in terms of 2-wheeler EVs sold (year-wise)
WITH maker_yearly_sales AS (
    SELECT
        dd.fiscal_year,
        evm.maker,
        SUM(evm.electric_vehicles_sold) AS total_sold
    FROM ev_sales_db.electric_vehicle_sales_by_makers evm
    JOIN ev_sales_db.dim_date dd
        ON evm.date = dd.date
    WHERE evm.vehicle_category = '2-Wheelers'
      AND dd.fiscal_year IN (2023, 2024)
    GROUP BY dd.fiscal_year, evm.maker
),
ranked_makers AS (
    SELECT
        fiscal_year,
        maker,
        total_sold,
        DENSE_RANK() OVER (
            PARTITION BY fiscal_year
            ORDER BY total_sold DESC
        ) AS maker_rank
    FROM maker_yearly_sales
)
SELECT
    fiscal_year,
    maker,
    total_sold
FROM ranked_makers
WHERE maker_rank <= 3
ORDER BY fiscal_year, maker_rank, maker;


-- Q3) Average number of total vehicles sold per month in fiscal year 2024
SELECT
    ROUND(AVG(monthly_sales.total_vehicle_sales), 0) AS avg_total_sales_per_month
FROM (
    SELECT
        dd.date AS month_start,
        SUM(evs.total_vehicles_sold) AS total_vehicle_sales
    FROM ev_sales_db.electric_vehicle_sales_by_state evs
    JOIN ev_sales_db.dim_date dd
        ON evs.date = dd.date
    WHERE dd.fiscal_year = 2024
    GROUP BY dd.date
) AS monthly_sales;


-- Q4) Top 5 states with highest penetration rate in FY 2024 for both 2-wheelers and 4-wheelers
WITH state_penetration AS (
    SELECT
        evs.vehicle_category,
        evs.state,
        ROUND(
            (SUM(evs.electric_vehicles_sold) * 100.0)
            / NULLIF(SUM(evs.total_vehicles_sold), 0),
            2
        ) AS penetration_rate
    FROM ev_sales_db.electric_vehicle_sales_by_state evs
    JOIN ev_sales_db.dim_date dd
        ON evs.date = dd.date
    WHERE dd.fiscal_year = 2024
      AND evs.vehicle_category IN ('2-Wheelers', '4-Wheelers')
    GROUP BY evs.vehicle_category, evs.state
),
ranked_states AS (
    SELECT
        vehicle_category,
        state,
        penetration_rate,
        ROW_NUMBER() OVER (
            PARTITION BY vehicle_category
            ORDER BY penetration_rate DESC
        ) AS rn
    FROM state_penetration
)
SELECT
    vehicle_category,
    state,
    penetration_rate
FROM ranked_states
WHERE rn <= 5
ORDER BY vehicle_category, penetration_rate DESC;


-- Q5) States with highest and lowest total vehicle sales in fiscal year 2023
WITH state_sales AS (
    SELECT
        evs.state,
        SUM(evs.total_vehicles_sold) AS total_vehicle_sales
    FROM ev_sales_db.electric_vehicle_sales_by_state evs
    JOIN ev_sales_db.dim_date dd
        ON evs.date = dd.date
    WHERE dd.fiscal_year = 2023
    GROUP BY evs.state
)
SELECT
    state,
    total_vehicle_sales,
    CASE
        WHEN total_vehicle_sales = (SELECT MAX(total_vehicle_sales) FROM state_sales) THEN 'Highest'
        WHEN total_vehicle_sales = (SELECT MIN(total_vehicle_sales) FROM state_sales) THEN 'Lowest'
    END AS sales_extreme
FROM state_sales
WHERE total_vehicle_sales = (SELECT MAX(total_vehicle_sales) FROM state_sales)
   OR total_vehicle_sales = (SELECT MIN(total_vehicle_sales) FROM state_sales);


-- Q6) Peak and low season months for EV sales from fiscal year 2022 to 2024
WITH month_sales AS (
    SELECT
        MONTH(dd.date) AS month_num,
        DATE_FORMAT(dd.date, '%M') AS month_name,
        SUM(evs.electric_vehicles_sold) AS total_ev_sales
    FROM ev_sales_db.electric_vehicle_sales_by_state evs
    JOIN ev_sales_db.dim_date dd
        ON evs.date = dd.date
    WHERE dd.fiscal_year BETWEEN 2022 AND 2024
    GROUP BY MONTH(dd.date), DATE_FORMAT(dd.date, '%M')
),
ranked_months AS (
    SELECT
        month_num,
        month_name,
        total_ev_sales,
        ROW_NUMBER() OVER (ORDER BY total_ev_sales DESC) AS peak_rank,
        ROW_NUMBER() OVER (ORDER BY total_ev_sales ASC) AS low_rank
    FROM month_sales
)
SELECT
    'Peak Season' AS season_type,
    month_name,
    total_ev_sales
FROM ranked_months
WHERE peak_rank = 1
UNION ALL
SELECT
    'Low Season' AS season_type,
    month_name,
    total_ev_sales
FROM ranked_months
WHERE low_rank = 1;


-- Q7) CAGR in 2-wheeler units for the top 4 makers from FY 2022 to FY 2024
WITH maker_sales AS (
    SELECT
        evm.maker,
        SUM(CASE WHEN dd.fiscal_year = 2022 THEN evm.electric_vehicles_sold ELSE 0 END) AS start_value,
        SUM(CASE WHEN dd.fiscal_year = 2024 THEN evm.electric_vehicles_sold ELSE 0 END) AS end_value
    FROM ev_sales_db.electric_vehicle_sales_by_makers evm
    JOIN ev_sales_db.dim_date dd
        ON evm.date = dd.date
    WHERE evm.vehicle_category = '2-Wheelers'
      AND dd.fiscal_year IN (2022, 2024)
    GROUP BY evm.maker
),
top_4_makers AS (
    SELECT
        maker,
        start_value,
        end_value
    FROM maker_sales
    ORDER BY end_value DESC
    LIMIT 4
)
SELECT
    maker,
    start_value,
    end_value,
    ROUND(
        (POWER((end_value * 1.0) / NULLIF(start_value, 0), 1 / 2.0) - 1) * 100,
        2
    ) AS cagr_percentage
FROM top_4_makers
ORDER BY cagr_percentage DESC;


-- Q8) Categorize states by EV penetration rate in fiscal year 2024
SELECT
    evs.state,
    SUM(evs.electric_vehicles_sold) AS total_ev_sales,
    SUM(evs.total_vehicles_sold) AS total_vehicles_sold,
    ROUND(
        (SUM(evs.electric_vehicles_sold) * 100.0)
        / NULLIF(SUM(evs.total_vehicles_sold), 0),
        2
    ) AS penetration_rate,
    CASE
        WHEN (SUM(evs.electric_vehicles_sold) * 100.0) / NULLIF(SUM(evs.total_vehicles_sold), 0) > 7 THEN 'Above 7%'
        WHEN (SUM(evs.electric_vehicles_sold) * 100.0) / NULLIF(SUM(evs.total_vehicles_sold), 0) > 5 THEN 'Above 5%'
        WHEN (SUM(evs.electric_vehicles_sold) * 100.0) / NULLIF(SUM(evs.total_vehicles_sold), 0) > 3 THEN 'Above 3%'
        WHEN (SUM(evs.electric_vehicles_sold) * 100.0) / NULLIF(SUM(evs.total_vehicles_sold), 0) > 1 THEN 'Above 1%'
        ELSE 'Below 1%'
    END AS penetration_category
FROM ev_sales_db.electric_vehicle_sales_by_state evs
JOIN ev_sales_db.dim_date dd
    ON evs.date = dd.date
WHERE dd.fiscal_year = 2024
GROUP BY evs.state
ORDER BY penetration_rate DESC;
