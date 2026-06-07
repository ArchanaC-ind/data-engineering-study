Goal
Build a production-style e-commerce data warehouse.
Architecture
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
