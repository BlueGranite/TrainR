library(devtools)
#install_github("ramnathv/rChartsCalmap")

library(readr)
library(lubridate)
library(rChartsCalmap)

#taxi_data <- read_csv("NYC_taxi/NYC_Sample.csv")
taxi_sample <- sample_n(taxi_data, 1000)

taxi_sample <- mutate(taxi_sample, date_value = date(tpep_pickup_datetime))

r1 <- calheatmap(x = 'date_value', 
                 y = 'fare_amount',
                 data = taxi_sample, 
                 domain = 'month',
                 start = "2016-01-01",
                 legend = seq(10, 50, 10),
                 itemName = 'point',
                 range = 6
)
r1
