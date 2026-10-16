
# Zepto Product Catalog Analysis | SQL Portfolio Project

A hands-on SQL portfolio project exploring a Zepto-style product catalog using **MySQL 8.0+**. The project covers data import, cleaning, validation, and business-focused analysis using SQL queries.

> **Scope note:** This dataset contains product-catalog information, not order or transaction history. The analysis can describe listed prices, discounts, catalog mix, and stock flags; it cannot establish revenue, profit, sales performance, or the causes of stockouts. And the objective is to practice advanced SQL functions.

## Project goals

- Import a raw CSV into MySQL.
- Build a cleaned analysis view without deleting the original data.
- identify exact duplicate records and potential category-classification issues.
- Analyze catalog composition, listed discounts, price differences, stockout flags.
- Translate SQL output into business observations.

## Tools

- MySQL 
- SQL: CTEs, window functions, aggregation, conditional logic, subqueries, views, aggregation, Row_number etc.

## Repository structure

```text
zepto-sql-portfolio/
├── data/
│   └── zepto_products.csv
├── sql/
│   ├── 01_setup_data_import.sql
│   ├── 02_cleaning_and_validation.sql
│   └── 03_business_analysis.sql
├── results/
│   └── findings.md
├── README.md
```

## Dataset

The included CSV has **3,732 rows and 9 columns**:

- `Category`
- `name`
- `mrp`
- `discountPercent`
- `availableQuantity`
- `discountedSellingPrice`
- `weightInGms`
- `outOfStock`
- `quantity`

## Business questions covered

1. What is the overall catalog and availability snapshot?
2. Which categories have the highest stockout rates?
3. What share of the catalog does each category represent?
4. Which in-stock products have listed discounts of 25% or more?
5. How do stockout rates compare across discount bands?
6. Which in-stock products have the largest listed price difference?
7. Are exact duplicate records present in the raw source?
8. Which product names occur under multiple categories?
9. Which unavailable products should be reviewed?
10. How do listed prices and weights vary by category?


## Author
www.linkedin.com/in/prateeksha-singh-1738a7302
