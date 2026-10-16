# Findings and Business Interpretation

This note summarizes the source CSV and explains what the project can and cannot conclude. For final submission, rerun the SQL scripts in MySQL Workbench and replace or supplement these notes with your own exported query outputs.

## Catalog and availability

- Source rows: **3,732**
- Exact duplicate copies beyond the first occurrence: **2**
- Rows after exact-row deduplication: **3,730**
- Source rows marked out of stock: **453 (12.14%)**
- Category count: **14**

### Category stockout rates in the source snapshot

| Category | Rows | Out-of-stock rows | Stockout rate |
|---|---:|---:|---:|
| Biscuits | 147 | 42 | 28.57% |
| Beverages | 129 | 28 | 21.71% |
| Dairy, Bread & Batter | 129 | 28 | 21.71% |
| Meats, Fish & Eggs | 63 | 12 | 19.05% |
| Health & Hygiene | 97 | 13 | 13.40% |
| Cooking Essentials | 514 | 64 | 12.45% |
| Munchies | 514 | 64 | 12.45% |
| Chocolates & Candies | 388 | 45 | 11.60% |
| Packaged Food | 388 | 45 | 11.60% |
| Ice Cream & Desserts | 388 | 45 | 11.60% |
| Home & Cleaning | 194 | 19 | 9.79% |
| Fruits & Vegetables | 93 | 6 | 6.45% |
| Paan Corner | 344 | 21 | 6.10% |
| Personal Care | 344 | 21 | 6.10% |

## Data quality observations

- One source row has zero MRP.
- Four source rows have weight less than or equal to zero.
- There are 1,190 distinct product-name values associated with more than one category.

The last observation deserves particular attention. Some cross-category matches may be valid, but the number is large enough to warrant a taxonomy review. Do not merge or delete rows solely because names match.

## Interpretation

The stockout rate is a snapshot of catalog flags. It can help identify categories for further review, but it does not prove that a category has stronger demand, poorer replenishment, or more lost sales. Those questions require transaction and inventory-history data.

Price comparisons should be reported only after confirming the unit scale. If raw prices are stored in hundredths, the view's division by 100 is a transformation assumption that should be documented and validated.

## Recommended next steps

1. Review products listed under multiple categories.
2. Confirm the intended meaning of `availableQuantity` and `quantity`.
3. Confirm the price scale against a trusted source.
4. Rerun the SQL scripts and save genuine result exports or screenshots.
5. Present conclusions as descriptive findings, not causal claims.
