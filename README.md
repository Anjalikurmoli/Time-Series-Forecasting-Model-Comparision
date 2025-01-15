# Time-Series-Forecasting-Model-Comparision
Project Overview:

This repository contains a comparative analysis of time series forecasting models used to predict two key datasets: Federal Funds Effective Rate and Electricity Net Generation in the industrial sector. We applied and evaluated the performance of several forecasting models—ARIMA, ETS, Prophet, Random Forest, and XGBoost—to determine the most effective model for predicting future trends in these fields.

The goal of the project is to:

a) Compare the accuracy of different forecasting models on economic and energy data.

b) Generate forecasts to guide decision-making in economic policy, financial forecasting, and energy planning.

Datasets:

Federal Funds Effective Rate: Contains historical data on U.S. Federal Funds rates.
Electricity Net Generation: Includes data on electricity generation within the industrial sector.

Key Models Used:

1. ARIMA (AutoRegressive Integrated Moving Average) - 
A statistical time series model that captures patterns and seasonality in data based on past values.

2. ETS (Exponential Smoothing State Space Model) - 
A model for forecasting that accounts for error, trend, and seasonality in time series data.

3. Prophet - 
A forecasting tool developed by Facebook, designed to handle missing data, seasonality, and irregular time intervals.

4. Random Forest - 
A machine learning algorithm that uses an ensemble of decision trees for regression tasks.

5. XGBoost -
A gradient boosting machine learning model designed for accuracy and performance in regression tasks.

Results:

The models were evaluated using performance metrics such as RMSE, MAE, and MAPE. Key findings include:

a) ARIMA outperformed the other models in both datasets, demonstrating strong accuracy and alignment with historical trends.

b) ETS followed closely, showing good performance with slightly higher uncertainty.

c) Prophet performed poorly, with high error rates, suggesting it may not be suitable for all time series datasets.

d) Random Forest and XGBoost showed promise but required further refinement for time series forecasting tasks.

