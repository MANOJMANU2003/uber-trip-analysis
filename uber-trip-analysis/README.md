# 🚕 Uber Trip Analysis

An end-to-end data analytics portfolio project exploring ride volume, trip timing, pickup and drop-off locations, ride categories, payment methods, fares and surge pricing.

> **Dataset note:** This repository contains the 1,000-row CSV dataset supplied with the project. It is a small sample dataset and its provenance is not documented in the uploaded files. Do not interpret it as an official Uber production dataset or as representative of all Uber trips.

## Project objectives

- Understand trip demand by hour, weekday and weekend.
- Compare ride types and payment methods.
- Identify frequent pickup and drop-off locations and common routes.
- Explore fare and revenue patterns.
- Examine how surge multipliers relate to fares and trip activity.
- Present findings through Python analysis, MySQL queries and a Power BI report.

## Tools

- **Python:** pandas, NumPy, Matplotlib, Seaborn
- **Database:** MySQL
- **BI:** Power BI Desktop (`Uber.pbix`)
- **Notebook:** Jupyter Notebook

## Repository structure

```text
uber-trip-analysis/
├── data/
│   ├── uber_data.csv                 # Original sample data
│   └── cleaned/
│       └── uber_clean.csv            # Prepared data with time features
├── notebooks/
│   └── uber_trip_analysis.ipynb      # Exploratory data analysis
├── sql/
│   └── uber_trip_analysis.sql        # Table definition and analysis queries
├── Uber.pbix                         # Power BI report
├── prepare_data.py                   # Rebuild cleaned CSV from raw CSV
├── requirements.txt
├── .gitignore
└── README.md
```

## Dataset overview

The supplied raw dataset contains **1,000 rows and 10 columns** covering pickup timestamps, pickup/drop-off locations, trip distance, fare, surge multiplier, payment type and ride type. The cleaned file contains **17 columns**, including derived hour, day, weekday name, month, year and weekend fields.

| File | Rows | Columns | Purpose |
|---|---:|---:|---|
| `data/uber_data.csv` | 1,000 | 10 | Original sample |
| `data/cleaned/uber_clean.csv` | 1,000 | 17 | Analysis-ready sample |

The raw distance field has 50 missing values. The prepared dataset fills missing distances with the raw dataset's median and derives calendar features from `Pickup_Date`. The cleaned file has no missing values in the inspected columns. See the notebook and `prepare_data.py` for the preparation logic.

## Run the Python analysis

1. Clone or download this repository.
2. Create and activate a virtual environment.
3. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

4. Rebuild the cleaned dataset:

   ```bash
   python prepare_data.py
   ```

5. Start Jupyter and open `notebooks/uber_trip_analysis.ipynb`:

   ```bash
   jupyter notebook
   ```

The notebook uses relative paths, so run it from the notebook file in the repository structure above.

## Run the MySQL analysis

1. Open MySQL Workbench or your preferred MySQL client.
2. Run `sql/uber_trip_analysis.sql` to create the database and table and review the analysis queries.
3. Import `data/cleaned/uber_clean.csv` into the `uber_trips` table using the Table Data Import Wizard, or enable `LOCAL INFILE` and adapt the optional `LOAD DATA LOCAL INFILE` example in the SQL file to your local file path.

The SQL file includes queries for trip counts, hourly demand, weekday/weekend comparisons, ride types, payment methods, popular locations, routes and surge analysis.

## Power BI report

Open `Uber.pbix` with Power BI Desktop. The report file is included as supplied. If its data source path is local to the original machine, update the source in **Transform data → Data source settings** and point it to `data/cleaned/uber_clean.csv`.

For a polished portfolio presentation, add exported dashboard screenshots to this README after confirming the report refreshes successfully on your machine.

## Analysis questions

- What are the busiest and quietest pickup hours?
- How does trip volume differ between weekdays and weekends?
- Which ride types contribute the most trips and fare value?
- Which payment methods are most frequently used?
- Which pickup and drop-off locations appear most often?
- Which pickup/drop-off routes have the highest trip counts and fare totals?
- How do trip count and average fare vary by surge multiplier?

## Important interpretation notes

- Fare values are shown in the units present in the supplied dataset; the source does not specify a currency. Do not add a currency symbol without verifying it.
- This dataset covers a short date range and only 1,000 sample trips. Treat findings as descriptive of this sample, not as general conclusions about Uber's full business.
- A higher total fare does not necessarily mean higher profitability because driver costs, platform fees, incentives and other expenses are not included.

## Author

**Manoj M**  
Aspiring Data Analyst | Data Scientist  
[GitHub](https://github.com/MANOJMANU2003) · [LinkedIn](https://www.linkedin.com/in/manojm112003/)

---

*Turning trip data into actionable insights.*
