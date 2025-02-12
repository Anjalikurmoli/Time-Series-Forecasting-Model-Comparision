# Time Series Forecasting with Multiple Models

## Project Overview
This project explores time series forecasting using multiple models on two datasets:

1. **Federal Funds Rate** (USA): The Federal Funds Effective Rate (FEDFUNDS) dataset was sourced from the Federal Economic Data (FRED) database, maintained by the Federal Reserve Bank of St. Louis. The Federal Funds rate is a crucial economic indicator, reflecting the interest rate at which depository institutions trade federal funds with each other overnight. This rate is a key tool in monetary policy, influencing everything from inflation to employment levels. The dataset spans from July 1954 to July 2024, providing a comprehensive historical view of the rate’s fluctuations over time.
- Metadata details: 
•	Frequency – Monthly
•	Units – Percent
•	Time Period Covered – July 1954 to July 2024
•	Source – Federal Reserve Bank of St. Louis

2. **Electricity Net Generation (Industrial Sector)**: The second dataset pertains to electricity net generation in the commercial and industrial sector, sourced from the U.S. Energy Information Administration (EIA). For the project, the focus is on electricity net generation in the industrial sector. This dataset captures the total amount of electricity generated by the industrial sector, which is a critical metric for understanding energy consumption patterns within a major sector of the economy.
- Metadata details:
•	Frequency – Monthly
•	Units – Million Kilowatt-hours
•	Time Period Covered – January 1973 to April 2024
•	Source – U.S. Energy Information Administration

The goal is to apply various time series forecasting models and compare their performance.

## Datasets
1. **Federal Funds Rate (Data 1)**: A CSV file containing monthly data on the Federal Funds rate from 1954 to 2024.
   - File: [Data 1.csv](Data_1.csv)

2. **Electricity Net Generation (Industrial Sector, Data 2)**: An Excel file containing monthly data on net electricity generation for the industrial sector from 1973 to 2024.
   - File: [Data 2.xlsx](Data_2.xlsx)

## Applied Models
- **ETS (Exponential Smoothing)**: Applied to model and forecast both datasets.
- **ARIMA (AutoRegressive Integrated Moving Average)**: Used to predict future values based on historical data.
- **Prophet**: A forecasting model developed by Facebook for time series data with daily, weekly, or yearly seasonality.
- **Random Forest**: A machine learning method used to create lagged features and make predictions.
- **XGBoost**: A gradient boosting algorithm for time series forecasting.

### Forecast Plots:
- The forecast plots for both datasets and all models are available in the `plots/` folder.

## Model Performance Comparison

### Federal Funds Rate (Data 1)

| Model       | RMSE    | MAE     | MPE      | MAPE    |
|-------------|---------|---------|----------|---------|
| **ETS**     | 0.485   | 0.229   | -1.772   | 8.300%  |
| **ARIMA**   | 0.438   | 0.214   | -0.987   | 7.823%  |
| **Prophet** | 4.231   | 4.231   | 79.381%  | 79.381% |
| **RF**      | 1.135   | 0.651   | -18.245% | 20.496% |

### Electricity Net Generation (Data 2)

| Model       | RMSE     | MAE     | MPE      | MAPE    |
|-------------|----------|---------|----------|---------|
| **ETS**     | 559.580  | 307.112 | -0.345   | 15.189% |
| **ARIMA**   | 572.597  | 285.792 | -0.121   | 3.910%  |
| **Prophet** | 11,553.6 | 11,549.4| 100.495% | 100.495%|
| **XGBoost** | 1,863.0  | 1,816.3 | 15.908%  | 15.908% |

---

### Notes:
- **RMSE** = Root Mean Squared Error
- **MAE** = Mean Absolute Error
- **MPE** = Mean Percentage Error
- **MAPE** = Mean Absolute Percentage Error

---
