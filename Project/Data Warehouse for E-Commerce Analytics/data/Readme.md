# 🛒 E-Commerce Data Warehouse with PostgreSQL, dbt & Power BI

## 📖 Overview

This project builds a production-style E-Commerce Data Warehouse using the Brazilian Olist marketplace dataset. The solution follows a modern data engineering architecture where raw CSV files are ingested through a Python ETL pipeline, stored in PostgreSQL, transformed with dbt into a dimensional warehouse, and visualized using Power BI.

The project demonstrates core Data Engineering and ETL concepts including data ingestion, data cleaning, dimensional modeling, data quality testing, analytical SQL, and dashboard development.

---

## 🎯 Project Goal

Build a scalable and analytics-ready E-Commerce Data Warehouse that enables business users to analyze:

- Revenue trends
- Customer behavior
- Product performance
- Seller performance
- Order and payment analytics

---

## 🏗️ Architecture

```text
Olist Dataset (CSV)
       |
       V
Python ETL
       |
       V
PostgreSQL (Raw Layer)
       |
       V
dbt Models
       |
       V
Star Schema Warehouse
       |
       V
Analytics Layer
       |
       V
Power BI Dashboard
```

---

## 🛠️ Tech Stack

| Tool | Purpose |
|--------|---------|
| Python | ETL Development |
| Pandas | Data Transformation |
| PostgreSQL | Data Storage & Warehousing |
| dbt | Data Modeling & Testing |
| SQL | Data Analysis |
| Power BI | Dashboard & Reporting |
| GitHub | Version Control |

---

## 📂 Dataset

The project uses the Olist Brazilian E-Commerce Dataset containing:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation Data

Dataset Size:

- 100k+ Orders
- 300k+ Records Across Multiple Tables

---

## 🚀 ETL Pipeline

### Extract

Load raw CSV files using Python and Pandas.

### Transform

Data quality and standardization steps:

- Remove duplicates
- Handle null values
- Convert timestamps
- Standardize column names
- Validate business rules

### Load

Load transformed data into PostgreSQL Raw Layer.

---

## 🗄️ Data Warehouse Design

The warehouse follows a Star Schema architecture.

### Fact Table

#### fact_sales

Measures:

- Sales Amount
- Freight Cost
- Payment Value
- Quantity Sold

### Dimension Tables

#### dim_customer

- Customer Key
- Customer ID
- City
- State

#### dim_product

- Product Key
- Product ID
- Category
- Weight

#### dim_seller

- Seller Key
- Seller ID
- City
- State

#### dim_date

- Date Key
- Day
- Month
- Quarter
- Year

---

## ⭐ Star Schema

```text
                dim_customer
                      |
                      |
dim_date ---- fact_sales ---- dim_product
                      |
                      |
                 dim_seller
```

---

## 🔄 dbt Transformation Layers

### Staging Layer

Models:

- stg_customers
- stg_orders
- stg_products
- stg_sellers
- stg_payments

Purpose:

- Clean raw data
- Standardize columns
- Apply business logic

### Mart Layer

Models:

- dim_customer
- dim_product
- dim_seller
- dim_date
- fact_sales

Purpose:

- Create dimensional warehouse

### Analytics Layer

Models:

- monthly_sales
- customer_lifetime_value
- top_products
- seller_performance

Purpose:

- Business-ready datasets

---

## ✅ Data Quality Checks

Implemented using dbt tests.

### Tests

- Unique
- Not Null
- Relationships
- Accepted Values

Examples:

- No duplicate customers
- No null primary keys
- Valid foreign key relationships
- Revenue validation checks

---

## 📊 Business KPIs

### Sales Metrics

- Total Revenue
- Total Orders
- Average Order Value
- Monthly Revenue Growth

### Customer Metrics

- Active Customers
- Repeat Customers
- Customer Lifetime Value

### Product Metrics

- Top Selling Products
- Category Revenue

### Seller Metrics

- Top Sellers
- Seller Revenue Contribution

---

## 📈 Power BI Dashboard

Dashboard Pages:

### Executive Overview

- Revenue Summary
- Order Trends
- Customer Growth

### Sales Analysis

- Monthly Revenue
- Revenue by Category

### Customer Analysis

- Top Customers
- Repeat Purchase Rate

### Product Analysis

- Best Selling Products
- Category Performance

### Seller Analysis

- Top Sellers
- Revenue Contribution

---

## 🔍 Sample SQL Query

### Monthly Revenue Trend

```sql
SELECT
    d.year,
    d.month,
    SUM(f.sales_amount) AS revenue
FROM fact_sales f
JOIN dim_date d
ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
```

### Top Product Categories

```sql
SELECT
    p.category,
    SUM(f.sales_amount) AS revenue
FROM fact_sales f
JOIN dim_product p
ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;
```

---

## 📁 Project Structure

```text
ecommerce-data-warehouse/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── etl/
│   ├── extract.py
│   ├── transform.py
│   └── load.py
│
├── sql/
│   ├── ddl/
│   ├── dml/
│   └── analytics/
│
├── dbt/
│   ├── models/
│   ├── tests/
│   └── snapshots/
│
├── dashboards/
│   └── powerbi/
│
├── docs/
│   ├── architecture.png
│   └── star_schema.png
│
├── requirements.txt
└── README.md
```

---

## 🎓 Skills Demonstrated

- ETL Development
- PostgreSQL
- Advanced SQL
- Data Warehousing
- Star Schema Design
- dbt Modeling
- Data Quality Testing
- Power BI Dashboarding
- Analytical Reporting
- End-to-End Data Engineering

---

## 👨‍💻 Author

Built as a portfolio project to demonstrate ETL, SQL, Data Warehousing, dbt, and Business Intelligence skills for Data Engineer, ETL Developer, SQL Developer, and Analytics Engineer roles.
