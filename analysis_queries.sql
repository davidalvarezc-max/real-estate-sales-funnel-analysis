-- =========================================================
-- Real Estate Sales Funnel Analysis
-- SQL Analysis Queries
-- Dataset: Fictional real estate development
-- Tool: SQLite
-- =========================================================


-- =========================================================
-- 1. Inventory status
-- Objective:
-- Understand how many lots are sold vs available.
-- =========================================================
SELECT
    status,
    COUNT(*) AS total_lots,
    SUM(CAST(price_mxn AS REAL)) AS total_value
FROM lots
GROUP BY status;


-- =========================================================
-- 2. Total inventory
-- Objective:
-- Confirm total number of lots in the project.
-- =========================================================
SELECT
    COUNT(*) AS total_lots
FROM lots;


-- =========================================================
-- 3. Leads by marketing source
-- Objective:
-- Identify which channels generate the highest lead volume.
-- =========================================================
SELECT
    lead_source,
    COUNT(*) AS total_leads
FROM leads
GROUP BY lead_source
ORDER BY total_leads DESC;


-- =========================================================
-- 4. Pipeline structure by stage
-- Objective:
-- Understand how opportunities are distributed across the funnel.
-- =========================================================
SELECT
    stage,
    COUNT(*) AS total_opportunities
FROM pipeline
GROUP BY stage
ORDER BY total_opportunities DESC;


-- =========================================================
-- 5. Sales by salesperson
-- Objective:
-- Evaluate sales performance by sales rep.
-- =========================================================
SELECT
    "salesperson",
    COUNT(*) AS total_sales,
    SUM(CAST("sale_price_mxn" AS REAL)) AS revenue
FROM "sales"
GROUP BY "salesperson"
ORDER BY total_sales DESC;


-- =========================================================
-- 6. Sales by lead source
-- Objective:
-- Determine which marketing sources generate actual sales.
-- =========================================================
SELECT
    l.lead_source,
    COUNT(s.sale_id) AS total_sales,
    SUM(CAST(s.sale_price_mxn AS REAL)) AS revenue
FROM sales s
JOIN leads l
    ON s.lead_id = l.lead_id
GROUP BY l.lead_source
ORDER BY total_sales DESC;


-- =========================================================
-- 7. Conversion rate by lead source
-- Objective:
-- Compare the effectiveness of each lead source.
-- =========================================================
SELECT
    l.lead_source,
    COUNT(DISTINCT l.lead_id) AS leads,
    COUNT(DISTINCT s.sale_id) AS sales,
    ROUND(
        COUNT(DISTINCT s.sale_id) * 1.0 /
        COUNT(DISTINCT l.lead_id),
        4
    ) AS conversion_rate
FROM leads l
LEFT JOIN sales s
    ON l.lead_id = s.lead_id
GROUP BY l.lead_source
ORDER BY conversion_rate DESC;


-- =========================================================
-- 8. Sales by month
-- Objective:
-- Measure sales velocity over time.
-- =========================================================
SELECT
    strftime('%Y-%m', sale_date) AS sale_month,
    COUNT(*) AS total_sales,
    SUM(CAST(sale_price_mxn AS REAL)) AS revenue
FROM sales
GROUP BY sale_month
ORDER BY sale_month;


-- =========================================================
-- 9. Average time to close
-- Objective:
-- Estimate how many days it takes to convert a lead into a sale.
-- =========================================================
SELECT
    ROUND(
        AVG(julianday(s.sale_date) - julianday(l.date_generated)),
        2
    ) AS avg_days_to_close
FROM sales s
JOIN leads l
    ON s.lead_id = l.lead_id;


-- =========================================================
-- 10. Salesperson performance classification
-- Objective:
-- Classify sales reps according to sales volume.
-- =========================================================
SELECT
    salesperson,
    COUNT(*) AS total_sales,
    CASE
        WHEN COUNT(*) >= 7 THEN 'Top Performer'
        WHEN COUNT(*) >= 4 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS performance_level
FROM sales
GROUP BY salesperson
ORDER BY total_sales DESC;


-- =========================================================
-- 11. Funnel structure with percentage of total
-- Objective:
-- Estimate the relative size of each stage in the sales funnel.
-- =========================================================
WITH funnel AS (
    SELECT 'Lead' AS stage, COUNT(*) AS leads_count, 1 AS stage_order
    FROM pipeline
    WHERE stage = 'Lead'

    UNION ALL

    SELECT 'Contacted' AS stage, COUNT(*) AS leads_count, 2 AS stage_order
    FROM pipeline
    WHERE stage = 'Contacted'

    UNION ALL

    SELECT 'Qualified' AS stage, COUNT(*) AS leads_count, 3 AS stage_order
    FROM pipeline
    WHERE stage = 'Qualified'

    UNION ALL

    SELECT 'Visit' AS stage, COUNT(*) AS leads_count, 4 AS stage_order
    FROM pipeline
    WHERE stage = 'Visit'

    UNION ALL

    SELECT 'Negotiation' AS stage, COUNT(*) AS leads_count, 5 AS stage_order
    FROM pipeline
    WHERE stage = 'Negotiation'

    UNION ALL

    SELECT 'Reserved' AS stage, COUNT(*) AS leads_count, 6 AS stage_order
    FROM pipeline
    WHERE stage = 'Reserved'

    UNION ALL

    SELECT 'Closed' AS stage, COUNT(*) AS leads_count, 7 AS stage_order
    FROM pipeline
    WHERE stage = 'Closed'
),
total AS (
    SELECT COUNT(*) AS total_leads
    FROM pipeline
)
SELECT
    f.stage,
    f.leads_count,
    ROUND(f.leads_count * 100.0 / t.total_leads, 2) AS pct_of_total
FROM funnel f
CROSS JOIN total t
ORDER BY f.stage_order;


-- =========================================================
-- 12. Funnel conversion from previous stage
-- Objective:
-- Estimate stage-to-stage conversion using current pipeline distribution.
-- =========================================================
WITH funnel AS (
    SELECT 'Lead' AS stage, COUNT(*) AS leads_count, 1 AS stage_order
    FROM pipeline
    WHERE stage = 'Lead'

    UNION ALL

    SELECT 'Contacted' AS stage, COUNT(*) AS leads_count, 2 AS stage_order
    FROM pipeline
    WHERE stage = 'Contacted'

    UNION ALL

    SELECT 'Qualified' AS stage, COUNT(*) AS leads_count, 3 AS stage_order
    FROM pipeline
    WHERE stage = 'Qualified'

    UNION ALL

    SELECT 'Visit' AS stage, COUNT(*) AS leads_count, 4 AS stage_order
    FROM pipeline
    WHERE stage = 'Visit'

    UNION ALL

    SELECT 'Negotiation' AS stage, COUNT(*) AS leads_count, 5 AS stage_order
    FROM pipeline
    WHERE stage = 'Negotiation'

    UNION ALL

    SELECT 'Reserved' AS stage, COUNT(*) AS leads_count, 6 AS stage_order
    FROM pipeline
    WHERE stage = 'Reserved'

    UNION ALL

    SELECT 'Closed' AS stage, COUNT(*) AS leads_count, 7 AS stage_order
    FROM pipeline
    WHERE stage = 'Closed'
)
SELECT
    stage,
    leads_count,
    ROUND(
        leads_count * 100.0 /
        LAG(leads_count) OVER (ORDER BY stage_order),
        2
    ) AS conversion_from_previous_stage
FROM funnel
ORDER BY stage_order;