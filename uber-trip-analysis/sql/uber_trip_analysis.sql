-- Uber Trip Analysis | MySQL
-- Run this script in MySQL Workbench. Import data/cleaned/uber_clean.csv
-- into uber_trips using the Table Data Import Wizard, or adapt the optional
-- LOAD DATA statement at the bottom to your local file path.

CREATE DATABASE IF NOT EXISTS uber_analysis;
USE uber_analysis;

CREATE TABLE IF NOT EXISTS uber_trips (
    Trip_ID BIGINT PRIMARY KEY,
    Pickup_Date DATETIME NOT NULL,
    Pickup_Location VARCHAR(100),
    Dropoff_Location VARCHAR(100),
    Trip_Distance_km DECIMAL(10,2),
    Fare_Amount DECIMAL(12,2),
    Surge_Multiplier DECIMAL(5,2),
    Payment_Type VARCHAR(40),
    Ride_Type VARCHAR(40),
    Total_Fare DECIMAL(12,2),
    Hour TINYINT,
    Day TINYINT,
    Day_Name VARCHAR(15),
    Month TINYINT,
    Month_Name VARCHAR(15),
    Year SMALLINT,
    Is_Weekend BOOLEAN
);

-- 1. Overall trip and fare KPIs
SELECT COUNT(*) AS total_trips,
       ROUND(SUM(Total_Fare), 2) AS total_fare_value,
       ROUND(AVG(Total_Fare), 2) AS average_total_fare,
       ROUND(AVG(Trip_Distance_km), 2) AS average_trip_distance_km
FROM uber_trips;

-- 2. Trips by hour
SELECT Hour, COUNT(*) AS trip_count
FROM uber_trips
GROUP BY Hour
ORDER BY trip_count DESC;

-- 3. Weekday versus weekend demand
SELECT CASE WHEN Is_Weekend = 1 THEN 'Weekend' ELSE 'Weekday' END AS day_type,
       COUNT(*) AS trip_count
FROM uber_trips
GROUP BY Is_Weekend
ORDER BY trip_count DESC;

-- 4. Demand by day of week
SELECT Day_Name, COUNT(*) AS trip_count
FROM uber_trips
GROUP BY Day_Name
ORDER BY FIELD(Day_Name, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- 5. Ride type performance
SELECT Ride_Type,
       COUNT(*) AS trip_count,
       ROUND(SUM(Total_Fare), 2) AS total_fare_value,
       ROUND(AVG(Total_Fare), 2) AS average_total_fare
FROM uber_trips
GROUP BY Ride_Type
ORDER BY trip_count DESC;

-- 6. Payment method analysis
SELECT Payment_Type,
       COUNT(*) AS trip_count,
       ROUND(SUM(Total_Fare), 2) AS total_fare_value,
       ROUND(AVG(Total_Fare), 2) AS average_total_fare
FROM uber_trips
GROUP BY Payment_Type
ORDER BY trip_count DESC;

-- 7. Top pickup locations
SELECT Pickup_Location, COUNT(*) AS trip_count,
       ROUND(SUM(Total_Fare), 2) AS total_fare_value
FROM uber_trips
GROUP BY Pickup_Location
ORDER BY trip_count DESC
LIMIT 10;

-- 8. Top drop-off locations
SELECT Dropoff_Location, COUNT(*) AS trip_count,
       ROUND(SUM(Total_Fare), 2) AS total_fare_value
FROM uber_trips
GROUP BY Dropoff_Location
ORDER BY trip_count DESC
LIMIT 10;

-- 9. Most frequent routes
SELECT Pickup_Location, Dropoff_Location,
       COUNT(*) AS trip_count,
       ROUND(AVG(Total_Fare), 2) AS average_total_fare
FROM uber_trips
GROUP BY Pickup_Location, Dropoff_Location
ORDER BY trip_count DESC
LIMIT 10;

-- 10. Surge multiplier analysis
SELECT Surge_Multiplier,
       COUNT(*) AS trip_count,
       ROUND(AVG(Total_Fare), 2) AS average_total_fare,
       ROUND(AVG(Trip_Distance_km), 2) AS average_distance_km
FROM uber_trips
GROUP BY Surge_Multiplier
ORDER BY Surge_Multiplier;

-- OPTIONAL: CSV import. Replace the path with the absolute path on your PC.
-- This requires LOCAL INFILE to be enabled in both MySQL client and server.
-- LOAD DATA LOCAL INFILE 'C:/your/path/uber_clean.csv'
-- INTO TABLE uber_trips
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;
