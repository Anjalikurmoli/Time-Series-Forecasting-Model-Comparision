# Time Series Forecasting with Multiple Models

## Project Overview
This project explores time series forecasting using multiple models on two datasets:

1. **Federal Funds Rate** (USA): Monthly data on the Federal Funds effective rate.
2. **Electricity Net Generation (Industrial Sector)**: Monthly electricity net generation data for the industrial sector.

The goal is to apply various time series forecasting models and compare their performance.

## Datasets
1. **Federal Funds Rate (Data 1)**: A CSV file containing monthly data on the Federal Funds rate from 1954 to 2024.
   - File: [Data 1.csv](data/Data%201.csv)

2. **Electricity Net Generation (Industrial Sector, Data 2)**: An Excel file containing monthly data on net electricity generation for the industrial sector from 1973 to 2024.
   - File: [Data 2.xlsx](data/Data%202.xlsx)

## Applied Models
- **ETS (Exponential Smoothing)**: Applied to model and forecast both datasets.
- **ARIMA (AutoRegressive Integrated Moving Average)**: Used to predict future values based on historical data.
- **Prophet**: A forecasting model developed by Facebook for time series data with daily, weekly, or yearly seasonality.
- **Random Forest**: A machine learning method used to create lagged features and make predictions.
- **XGBoost**: A gradient boosting algorithm for time series forecasting.

## Results
- **Federal Funds Rate (Data 1)**: Forecasts were generated for 24 months using ETS, ARIMA, Prophet, Random Forest, and XGBoost models. The results were compared, and accuracy metrics such as RMSE, MAE, and MAPE were calculated for each model.
  
- **Electricity Net Generation (Data 2)**: Similar to Data 1, forecasts for 24 months ahead were made using the same models. Accuracy was evaluated, and visualizations of the forecast were provided.

### Forecast Plots:
- The forecast plots for both datasets and all models are available in the `results/forecast_plots/` folder.

### Accuracy Metrics:
- The accuracy of each model was measured using various evaluation metrics (RMSE, MAE, MAPE). These metrics are available in the results for each model and dataset.

## Conclusion
This project demonstrates the use of multiple forecasting models to predict time series data. It provides insights into the effectiveness of each model in forecasting key economic and industrial indicators, with a focus on Federal Funds rate and electricity generation.

---

Feel free to explore the results, visualizations, and accuracy metrics generated in this project.
