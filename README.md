# 🛒 E-Commerce Sales Analysis Using SQL

## 📌 Project Overview
This project performs an end-to-end exploratory and analytical investigation of customer orders, product sales, and profit margins using an E-Commerce Superstore dataset. It covers the entire lifecycle of a database project: designing a relational schema with constraints, enforcing data integrity, running validation scripts, and executing advanced SQL queries (including Window Functions, CTEs, and Subqueries) to extract actionable strategic insights.

---

## 🎯 Key Objectives
* Design and implement a multi-table relational schema with primary and foreign key dependencies.
* Load, sanitize, and validate structured CSV datasets.
* Calculate core business performance metrics (Total Sales, Order Volume, AOV, Sales Extrems).
* Perform multi-dimensional analyses by product category, region, and customer segments.
* Classify customers and products into performance tiers using conditional logic (`CASE` statements).
* Apply advanced analytical tools such as `RANK()`, `DENSE_RANK()`, and cumulative running totals (`SUM() OVER()`).
* Synthesize raw output data into clear business insights to guide pricing, stock allocation, and operational strategies.

---

## 🗄️ Database Architecture & Schema

The relational structure comprises **4 primary tables** linked via primary and foreign keys. Data must be imported in strict order to maintain referential integrity.

### Data Model Diagram
```text
[customers] (1) ─── (N) [orders] (1) ─── (N) [order_items] (N) ─── (1) [products]
```
## Strategic Business Insights
* Top Revenue Generator: The Technology category generates the highest total sales across all regions, primarily driven by higher unit purchase prices.

* Profitability Dynamics: The Western Region generates the highest cumulative net profit, while specific states in the Central region yield slimmer          margins due to heavy promotional discounting.

* Loss Leaders: Detailed line-item filtering reveals that certain high-volume products consistently generate net losses, suggesting a need to adjust         discounting strategies or product bundling.

* Customer Value Concentration: A minor tier of High-Value Customers contributes a majority share of total enterprise revenue, underscoring the importance   of target retention strategies.



