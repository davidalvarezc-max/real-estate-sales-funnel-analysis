🔹 Real Estate Sales Funnel Analysis

SQL and Power BI analysis of a real estate development to evaluate sales funnel performance, identify bottlenecks, and uncover data quality issues affecting decision-making.

🔹 Project Overview

This project analyzes the commercial performance of a fictional real estate development with 185 residential lots.

The objective is to understand how leads progress through the sales funnel, identify conversion bottlenecks, and evaluate whether the current process supports sustainable sales growth.

The analysis combines SQL for data exploration and Power BI for visualization.

🔹 Business Problem

Out of 185 available lots, only 25 have been sold.

To ensure financial sustainability, the developer needs to:

Increase conversion rates

Improve sales velocity

Identify inefficiencies in the commercial process

🔹 Key Questions

Where are the main bottlenecks in the sales funnel?

Which lead sources generate the most effective conversions?

How does salesperson performance vary?

Is the current sales velocity sufficient to absorb inventory?

🔹 Data Model

🔹 Dashboard

🔹 Key Metrics

Total Leads: 900

Total Sales: 25

Conversion Rate: 3%

Avg Days to Close: 14.4

🔹 Key Insights

The pipeline is not strictly sequential, as some stages contain more records than their preceding stages. This suggests multiple entry points or inconsistent tracking.

The largest drop-off occurs between Qualified and Negotiation, indicating friction before purchase intent.

Some stage-to-stage conversions exceed 100%, revealing potential data quality issues or gaps in pipeline tracking.

The current sales velocity is insufficient to absorb available inventory efficiently.

🔹 Business Recommendations

Standardize the definition and progression of pipeline stages

Improve lead qualification before advancing to later stages

Focus on improving conversion from Qualified to Negotiation

Align CRM tracking with a consistent commercial process

🔹 Tools Used

SQL (SQLite)

Power BI

Excel

GitHub

🔹 Project Files

analysis_queries.sql → SQL queries

real_estate_case.pbix → Power BI dashboard

real_estate_dashboard.jpg → Dashboard screenshot

data_model_diagram.png → Data model




