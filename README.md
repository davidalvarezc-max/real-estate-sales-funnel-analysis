# real-estate-sales-funnel-analysis
Real estate sales funnel analysis using SQL and Power BI to identify bottlenecks, evaluate lead sources, and optimize commercial performance.

# Real Estate Sales Funnel Analysis

SQL and Power BI analysis of a fictional real estate development to identify sales funnel bottlenecks, evaluate marketing lead sources, and improve commercial performance.

---

# Project Overview

This project analyzes the sales funnel of a fictional real estate development with **185 residential lots**.  
The objective is to evaluate the commercial performance of the project by analyzing marketing leads, pipeline stages, and completed sales.

The analysis focuses on identifying **conversion bottlenecks**, evaluating **lead source effectiveness**, and assessing the **sales team's performance**.

The final output includes SQL-based analysis and a Power BI dashboard to support decision-making.

---

# Business Problem

The real estate project has a total inventory of **185 lots**, but only **25 have been sold**.

To ensure financial sustainability, the developer needs to increase the **sales velocity** and improve the **conversion rate of the commercial funnel**.

Key business questions:

- Where is the sales funnel bottleneck?
- Which marketing channels generate the most effective leads?
- Which salespeople perform best?
- Is the current sales velocity sufficient to absorb the inventory?

---

# Dataset Description

The dataset simulates the commercial operation of a real estate development.

### Tables included

| Table | Description |
|------|-------------|
| lots | Inventory of residential lots |
| leads | Marketing leads generated from different channels |
| pipeline | Current stage of each lead in the sales funnel |
| sales | Completed sales transactions |
| salespeople | Information about the sales team |

---

# Data Model

Relationships between tables:

leads
│
│ lead_id
▼
pipeline
│
│ lead_id
▼
sales
▲
│ lot_id
lots

salespeople
│
│ salesperson
▼
sales



### Primary Keys

| Table | Primary Key |
|------|-------------|
| lots | lot_id |
| leads | lead_id |
| pipeline | opportunity_id |
| sales | sale_id |
| salespeople | salesperson |

### Record Counts

| Table | Records |
|------|--------|
| lots | 185 |
| leads | ~900 |
| pipeline | ~900 |
| sales | 25 |
| salespeople | 5 |

---

# SQL Analysis

SQL was used to explore the dataset and evaluate key commercial metrics.

Examples of analyses performed:

### Inventory status

```sql
SELECT
    status,
    COUNT(*) AS total_lots
FROM lots
GROUP BY status;







