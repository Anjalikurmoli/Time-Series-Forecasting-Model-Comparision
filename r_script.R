libraries <- c("dplyr", "readxl", "tidyr", "ggplot2", "tseries", "lubridate", 
               "forecast", "feasts", "prophet", "caret", 
               "randomForest", "xgboost")

# Load all libraries
invisible(lapply(libraries, library, character.only = TRUE))

#DATA 1 - Federal Funds rate
#Load the dataset
data1 <- read.csv("C:/Users/dhana/Desktop/Anjali/BDA 696/Module 6/Project dataset/Data 1.csv")

#Remove the rows with missing values
data1 <- na.omit(data1)

#Change the date format to ymd
data1 <- data1 |> mutate(DATE=as.Date(DATE,format="%Y-%m-%d"))

#Summary of data
summary(data1)

#Check if any missing values and remove duplicate rows
sum(is.na(data1))
data1 <- data1 |> distinct()

#Rename the column names
colnames(data1) <- c("Date", "Funds")

#Plot the data
ggplot(data1, aes(x=Date, y=Funds)) + geom_line() + labs(title = "Federal Funds Effective Rate over time(USA)",
                                                         x="Year",y="Funds") + theme_minimal()
#Perform Augmented Dickey-Fuller test to check for stationarity
adf.test(data1$Funds)

#Plot the ACF and PACF Plot to check for correlation
acf(data1$Funds, main="Autocorrelation of Federal Funds Rate")
pacf(data1$Funds, main="Partial Autocorrelation of Federal Funds Rate")

#Convert the dataset to time series object
funds_ts <- ts(data1$Funds, start = c(1954,7), end = c(2024,7), frequency = 12)

#Decompose the time series to plot to check for trend, seasonality and random components
decomp <- decompose(funds_ts)
plot(decomp)

#Fit an ETS model
ets_model <- ets(funds_ts)
summary(ets_model) #Summary of the fitted ETS model

#Forecast the ETS model for 24 months ahead
ets_forecast <- forecast(ets_model, h=24)

#Plot the forecast
autoplot(ets_forecast) + labs(title = "Ets model forecast", x="Year", y="Funds Rate")

#Calculate the accuracy metrics
ets_accuracy <- accuracy(ets_forecast)
ets_accuracy

#Fit an ARIMA model
arima_model <- auto.arima(funds_ts)
summary(arima_model)  #Summary of the fitted ARIMA model

#Forecast ARIMA model for 24 months ahead
arima_forecast <- forecast(arima_model, h=24)

#Plot the forecast
autoplot(arima_forecast) + labs(title="ARIMA model forecast", x="Year", y="Funds Rate")

#Calculate the accuracy metrics 
arima_accuracy <- accuracy(arima_forecast)
arima_accuracy

#Prepare the data for the Prophet model
prophet_data <- data1 |> rename(ds=Date, y=Funds)

#Fit the Prophet model
prophet_model <- prophet(prophet_data, daily.seasonality = TRUE, weekly.seasonality = TRUE)

#Forecast using the prophet model
future <- make_future_dataframe(prophet_model, periods = 24, freq = "month")
prophet_forecast <- predict(prophet_model, future)

#Plot the forecast for Prophet model
plot(prophet_model, prophet_forecast) + ggtitle("Prophet Forecast for Federal Funds Effective rate") +
  xlab("Year") + ylab("Funds")

#Extracting the actual values to calculate the accuracy metrics
actual <- window(funds_ts, start = c(2024, 7))

#Converting forecast to time series
forecast_ts <- ts(prophet_forecast$yhat[1:24], frequency = 12, start = c(2024,7))
prophet_accuracy <- accuracy(forecast_ts, actual)
prophet_accuracy

#Create lagged features for Random Forest Model
data1_lagged <- data1 |> mutate(Lag1 = lag(Funds,1),
                                Lag2 = lag(Funds,2)) |> na.omit()

#Split the data into train and test set
train_size <- nrow(data1_lagged) - 24
train_data <- data1_lagged[1:train_size,]
test_data <- data1_lagged[(train_size + 1):nrow(data1_lagged),]

#Fit the Random Forest model
rf_model <- randomForest(Funds ~ Lag1 + Lag2, data=train_data)

#Forecast using the Random Forest model
#Set the future value to the last observed value
future_data <- data.frame(Lag1 = tail(test_data$Funds, 1),
                          Lag2 = tail(test_data$Funds, 2))
forecast_values <- numeric(24)
for(i in 1:24){
  forecast_values[i] <- predict(rf_model, future_data)
  #Update future_data fir the next iteration
  future_data <- data.frame(Lag1 = forecast_values[i],
                            Lag2 = future_data$Lag1)
}

#Create a time series for the historical data and forecast data
historical_ts <- ts(data1$Funds, frequency = 12)
combined_ts <- ts(c(as.numeric(historical_ts), forecast_values), frequency = 12, start = start(historical_ts))

#Create a data frame for plotting
plot_data <- data.frame(Date = time(combined_ts),
                        Value = as.numeric(combined_ts),
                        Type = c(rep("Historical", length(historical_ts)), rep("Forecast", length(forecast_values))))
#Plot the forecast of Random Forest
ggplot(plot_data, aes(x=Date, y=Value, color=Type)) + geom_line(size=1) +
  labs(title = "Random Forest Forecast for Federal Funds Effective Rate", x="Year", y="Funds") +
  scale_color_manual(values = c("Historical"="black", "Forecast"="blue")) + theme_minimal()

#Extract actual values for accuracy metrics
actual <- ts(data1[(nrow(data1) - 23):nrow(data1), "Funds"], frequency = 12, start = c(2024, 8))
forecast_ts <- ts(forecast_values, frequency = 12, start=c(2024,8))
rf_accuracy <- accuracy(forecast_ts, actual)
rf_accuracy



#DATA 2 - Electricity Net Generation (Industrial Sector)
#Load the data set
data2 <- read_xlsx("C:/Users/dhana/Desktop/Anjali/BDA 696/Module 6/Project dataset/Data 2.xlsx")

#Select the required data
data2 <- data2 |> select(Month, `Electricity Net Generation Total (including from sources not shown), Industrial Sector`)

#Convert the Month column to Date format
data2 <- data2 |> mutate(Month=as.Date(Month, format="%Y-%m-%d"))

summary(data2)   #Summary of the dataset
sum(is.na(data2))   #Check for any missing values
data2 <- data2 |> distinct()    # Remove duplicates

#Rename the column name
colnames(data2) <- c("Month","Electricity_Industrial")

#Plot the data
ggplot(data2, aes(x=Month, y=Electricity_Industrial)) + geom_line() + 
  labs(title = "Electricity Net Generation (Industrial Sector)", x="Month", y="Net Electricity") + theme_minimal()

#Convert the data to time series object
ts_data2 <- ts(data2$Electricity_Industrial, frequency = 12, start = c(1973, 1), end = c(2024, 4))

#Decompose the time series and plot to analyze the trend, seasonality and random components
decomp <- decompose(ts_data2)
plot(decomp)

#Perform Augmented Dickey-Fuller test to check for stationary
adf.test(data2$Electricity_Industrial)

#Plot ACF and PACF plots to check for correlation
acf(data2$Electricity_Industrial, main="Autocorrelation of Net Electricity")
pacf(data2$Electricity_Industrial, main="Partial Autocorrelation of Net Electricity")

#Fit an ETS model
ets_model <- ets(ts_data2)
summary(ets_model)    #Summary of the fitted ETS Model

#Forecast using the ETS model for 24 months ahead
ets_forecast <- forecast(ets_model, h = 24) 

#Plot the ETS forecast
autoplot(ets_forecast) + labs(title = "ETS Forecast for Electricity Net Generation (Industrial Sector)", 
                              x = "Month", y = "Net Electricity Generation")

#Calculate the accuracy metrics
ets_accuracy <- accuracy(ets_forecast)
ets_accuracy

#Fit ARIMA model
arima_model <- auto.arima(ts_data2)
summary(arima_model)    #Summary of the fitted ARIMA model

#Forecast for the next 24 months
arima_forecast <- forecast(arima_model, h=24)

#Plot the forecast
autoplot(arima_forecast) + labs(title = "ARIMA Forecast for Electricity Net Generation (Industrial Sector)",
                                x = "Month", y = "Net Electricity Generation")

#Calculate the accuracy metrics
arima_accuracy <- accuracy(arima_forecast)
arima_accuracy

#Prepare the data for Prophet model
prophet_data <- data2 |> rename(ds=Month, y=Electricity_Industrial)

#Fit the Prophet model
prophet_model <- prophet(prophet_data, daily.seasonality = TRUE, weekly.seasonality = TRUE)

#Forecast using prophet model for 24 months
future <- make_future_dataframe(prophet_model, periods = 24, freq = "month")
prophet_forecast <- predict(prophet_model, future)

#Plot the forecast
plot(prophet_model, prophet_forecast) + 
  ggtitle("Prophet Forecast for Electricity Net Generation (Industrial Sector)") + 
  xlab("Month") + ylab("Net Electricity Generation")

#Extract the actual values and calculate the accuracy metrics
actual <- window(ts_data2, start = c(2024, 1))
forecast_ts <- ts(prophet_forecast$yhat[1:24], frequency = 12, start = c(2024, 1))
prophet_accuracy <- accuracy(forecast_ts, actual)
prophet_accuracy

#Prepare the data for XGBoost model with lag features
# Convert ts_data to a data frame for processing
data2_df <- data.frame(Date = time(ts_data2), Electricity_Industrial = as.numeric(ts_data2))
data2_lagged <- data2_df |>  mutate(Lag1 = lag(Electricity_Industrial, 1),
                                    Lag2 = lag(Electricity_Industrial, 2)) |>  na.omit()

#Create matrix for XGBoost
data2_matrix <- as.matrix(data2_lagged %>% select(Lag1, Lag2))
data2_label <- data2_lagged$Electricity_Industrial

# Create DMatrix for XGBoost
dtrain <- xgb.DMatrix(data = data2_matrix, label = data2_label)

# Fit Gradient Boosting model
xgb_model <- xgboost(data = dtrain, nrounds = 100, objective = "reg:squarederror")
xgb_forecast_values <- numeric(24) 

# Start with the last observed values 
last_observed <- tail(data2_lagged, 1) 
for (i in 1:24) {
  #Set new data for prediction
  new_data_matrix <- as.matrix(last_observed |> select(Lag1, Lag2))
  #Forecast the next value
  xgb_forecast_values[i] <- predict(xgb_model, new_data_matrix)
  #Update last_observed for next iteration
  last_observed <- data.frame(Electricity_Industrial = xgb_forecast_values[i],
                              Lag1 = last_observed$Electricity_Industrial,
                              Lag2 = lag(last_observed$Electricity_Industrial,1))
  #Handling the lag values
  last_observed$Lag2 <- ifelse(is.na(last_observed$Lag2), NA, last_observed$Lag1)
  last_observed$Lag1 <- last_observed$Electricity_Industrial 
}

#Convert forecast values to a time series object for plotting 
forecast_ts <- ts(xgb_forecast_values, frequency = 12, start = c(2024, 1)) 
combined_ts <- ts(c(as.numeric(ts_data2), xgb_forecast_values), frequency = 12, start = start(ts_data2))

# Create a data frame for plotting 
plot_data <- data.frame( Date = time(combined_ts), Value = as.numeric(combined_ts), 
                         Type = c(rep("Historical", length(ts_data2)), rep("Forecast", length(xgb_forecast_values))) )

# Plot historical data and forecast 
ggplot(plot_data, aes(x = Date, y = Value, color = Type)) + geom_line(size = 1) + 
  labs(title = "Historical Data and XGBoost Forecast for Electricity Net Generation (Industrial Sector)",
       x = "Month", y = "Net Electricity Generation") + 
  scale_color_manual(values = c("Historical" = "black", "Forecast" = "blue")) + theme_minimal()

#Calculate the accuracy metrics
xgb_accuracy <- accuracy(forecast_ts, actual)
xgb_accuracy
