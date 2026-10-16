
# Zepto Product Catalog Analysis | SQL Portfolio Project

A hands-on SQL portfolio project exploring a Zepto-style product catalog using **MySQL 8.0+**. The project covers data import, cleaning, validation, and business-focused analysis using SQL queries.

> **Scope note:** This dataset contains product-catalog information, not order or transaction history. The analysis can describe listed prices, discounts, catalog mix, and stock flags; it cannot establish revenue, profit, sales performance, or the causes of stockouts.

## Project goals

- Import a raw CSV into MySQL.
- Build a cleaned analysis view without deleting the original data.
- identify exact duplicate records and potential category-classification issues.
- Analyze catalog composition, listed discounts, price differences, stockout flags, and price per 100 grams.
- Translate SQL output into cautious, evidence-based business observations.

## Tools

- MySQL 8.0+
- MySQL Workbench (recommended for CSV import and running queries)
- SQL: CTEs, window functions, aggregation, conditional logic, subqueries, views, and data-quality checks

## Repository structure

```text
zepto-sql-portfolio/
├── data/
│   └── zepto_products.csv
├── sql/
│   ├── 01_setup_and_import.sql
│   ├── 02_cleaning_and_validation.sql
│   └── 03_business_analysis.sql
├── results/
│   └── findings.md
├── README.md
└── .gitignore
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

The source file's price values appear to be stored in hundredths of a currency unit (for example, `2500` may represent `25.00`). The SQL view converts prices by dividing by 100, but this convention should be validated against the source before publishing currency claims.

## How to run the project

### 1. Create the database and raw table

Open `sql/01_setup_and_import.sql` in MySQL Workbench and run it. It creates the `zepto_analytics` database and the `zepto_products_raw` staging table.

### 2. Import the CSV

In MySQL Workbench:

1. In the Schemas panel, expand `zepto_analytics`.
2. Right-click `zepto_products_raw`.
3. Choose **Table Data Import Wizard**.
4. Select `data/zepto_products.csv`.
5. Map the nine CSV columns to the table columns in order.
6. Finish the import and verify the row count.

If your Workbench version shows slightly different menu labels, use its CSV/Table Data Import Wizard flow. Do not import into a second table by accident.

### 3. Build the cleaned view

Run `sql/02_cleaning_and_validation.sql`. It creates `vw_zepto_products`, keeps raw values for traceability, removes exact duplicate copies from the analysis view, calculates savings and discount fields, and assigns a data-quality status.

The raw table remains unchanged.

### 4. Run the business analysis

Run the queries in `sql/03_business_analysis.sql` one at a time. Review the comments above each query to understand the business question.

## Key findings from the source CSV

These are descriptive findings from the provided file; query outputs can differ if the CSV or cleaning logic changes.

- **3,732 source rows** and **2 exact duplicate copies** were found, leaving **3,730 rows** after exact-row deduplication.
- **453 rows** are marked out of stock in the raw source, about **12.14%** of the catalog.
- The source contains **14 categories**.
- **Biscuits** has the highest raw-category stockout rate in this snapshot: **42 of 147 rows (28.57%)**.
- **Fruits & Vegetables** has a lower raw-category stockout rate: **6 of 93 rows (6.45%)**.
- **1,190 product-name values** appear under more than one category. This is a review signal, not proof that every occurrence is wrong.
- The source has **1 row with zero MRP** and **4 rows with non-positive weight**.

See [`results/findings.md`](results/findings.md) for interpretation and caveats.

## Business questions covered

1. What is the overall catalog and availability snapshot?
2. Which categories have the highest stockout rates?
3. What share of the catalog does each category represent?
4. Which in-stock products have listed discounts of 25% or more?
5. How do stockout rates compare across discount bands?
6. Which in-stock products have the largest listed price difference?
7. Are there suspicious price, weight, discount, or stock-flag values?
8. Are exact duplicate records present in the raw source?
9. Which product names occur under multiple categories?
10. Which unavailable products should be reviewed?
11. How do listed prices and weights vary by category?
12. How do in-stock products compare by price per 100 grams?

## Data limitations and responsible interpretation

- There is no transaction history, order volume, customer data, or inventory timeline.
- A stockout flag is a catalog snapshot, not evidence of lost sales or the cause of unavailability.
- Repeated product names across categories should be investigated, not automatically deleted.
- `availableQuantity` and `quantity` should not be assumed to mean the same thing without source documentation.
- Price units must be verified before presenting results as rupees or another currency.
- Query results should be regenerated from the SQL scripts rather than copied from illustrative examples.

## Suggested next steps

- Validate the category taxonomy and inspect cross-category product names.
- Confirm the price scale and the meaning of quantity fields.
- Export query outputs or screenshots from MySQL Workbench into the repository after rerunning the SQL.
- Add a short conclusion describing the strongest findings and the limitations.

## Author

**Your Name**  
Aspiring Data Analyst | SQL | MySQL

Replace this placeholder with your name and add your GitHub or LinkedIn links if you want them shown.
