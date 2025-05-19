# 🎶 Media Music Database – End-to-End SQL Project

This project involved cleaning, normalizing, transforming, and analyzing a music dataset using advanced SQL techniques in SQLite. It simulates a real-world data pipeline for digital media platforms, demonstrating skills in ETL, schema design, query writing, and performance optimization.

---

## 📁 Project Overview

* Refactored a non-normalized music dataset into a fully normalized relational schema
* Cleaned and validated raw CSV data using staging tables and batch logic
* Used SQL scripts to implement ETL, add constraints, correct dates, and populate target tables
* Performed analytical queries and implemented indexing for performance

---

## 🗃️ Schema Design & Normalization

* Designed 3NF schema with separate `Artists`, `Albums`, `Tracks`, `Genres`, and `MediaType` tables
* Removed redundant and transient dependencies
* Used `CHECK`, `FOREIGN KEY`, and `NOT NULL` constraints
* Built new tables through iterative transformation of raw data

---

## 🔁 ETL & Transformation Steps

* Loaded CSVs via SQLite CLI and validated with cross-table foreign key checks
* Cleaned text fields, removed duplicates, and formatted date strings
* Converted release and birth dates into ISO format
* Created new normalized tables and migrated cleaned data into them

---

## 📊 Analytical SQL Queries

* Top artists by album count
* Most played tracks by total duration
* Genre popularity based on artist count
* Time-based partitioning (e.g., artists born in 1986/1987)
* View creation for simplified analysis (e.g., `Popular_Artists`)

---

## ⚙️ Optimization Techniques

* Created indexes on artist names, album titles, durations
* Used `EXPLAIN QUERY PLAN` to evaluate query cost
* Simulated batch updates and parallel execution logic
* Partitioned datasets by year to optimize scan performance

---

## 🎧 MediaType Classification

* Introduced a `MediaType` lookup table to categorize tracks by duration
* Added `MediaTypeID` column to `Tracks`
* Updated values using custom business logic:

  * <180s → MPEG
  * 180–239s → Protected AAC
  * 240–299s → MPEG-4 video
  * 300–359s → Purchased AAC
  * 360s+ → AAC

---

## 🧠 Skills Demonstrated

* SQL data cleaning and validation
* Normalization (1NF, 2NF, 3NF)
* Staging → cleaned → final table workflows
* Advanced SQL joins, subqueries, views
* Query tuning & indexing
* Business logic implementation

---

## 💻 Tools Used

* SQLite (via CLI & DB Browser)
* `.sql` scripts for transformation, loading, and validation
* `.csv` raw files (Artists, Albums, Tracks, Genres)


---

## 📌 Project Type

Advanced SQL & Data Management Capstone (SQLite, ETL, Analytics)

> *"This project reflects a full SQL lifecycle — from raw import to schema design, ETL, analysis, and optimization — ideal for database portfolio showcase."*

