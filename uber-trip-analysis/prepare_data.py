"""Reproducible data preparation for the Uber trip analysis project."""
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent
RAW_PATH = ROOT / "data" / "uber_data.csv"
CLEAN_PATH = ROOT / "data" / "cleaned" / "uber_clean.csv"

def main():
    df = pd.read_csv(RAW_PATH)
    df["Pickup_Date"] = pd.to_datetime(
        df["Pickup_Date"], format="mixed", dayfirst=True, errors="coerce"
    )
    df["Trip_Distance_km"] = pd.to_numeric(df["Trip_Distance_km"], errors="coerce")
    median_distance = df["Trip_Distance_km"].median()
    df["Trip_Distance_km"] = df["Trip_Distance_km"].fillna(median_distance)

    # Derive time features from the parsed pickup timestamp.
    df["Hour"] = df["Pickup_Date"].dt.hour
    df["Day"] = df["Pickup_Date"].dt.day
    df["Day_Name"] = df["Pickup_Date"].dt.day_name()
    df["Month"] = df["Pickup_Date"].dt.month
    df["Month_Name"] = df["Pickup_Date"].dt.month_name()
    df["Year"] = df["Pickup_Date"].dt.year
    df["Is_Weekend"] = df["Pickup_Date"].dt.dayofweek >= 5

    CLEAN_PATH.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(CLEAN_PATH, index=False)
    print(f"Saved {len(df):,} rows to {CLEAN_PATH.relative_to(ROOT)}")
    print(f"Median distance used for missing values: {median_distance:.2f} km")
    print(f"Remaining missing values: {int(df.isna().sum().sum())}")

if __name__ == "__main__":
    main()
