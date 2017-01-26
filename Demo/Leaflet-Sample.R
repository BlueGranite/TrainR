setwd("C:/data")

#install.packages("leaflet")
#install.packages("lawn")

library(leaflet)
library(lawn)
library(dplyr)
library(readr)
library(lubridate)

#leaflet_data <- read_csv("NYC_taxi/NYC_Sample.csv")

leaflet_sample <- sample_n(leaflet_data, 1)

pickup <- lawn_point(c(leaflet_sample$pickup_longitude, leaflet_sample$pickup_latitude))
dropoff <- lawn_point(c(leaflet_sample$dropoff_longitude, leaflet_sample$dropoff_latitude))

distance_measured <- lawn_distance(pickup, dropoff)
trip_duration <- difftime(leaflet_sample$tpep_dropoff_datetime, leaflet_sample$tpep_pickup_datetime, units = "mins")

m <- leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircles(lng=leaflet_sample$pickup_longitude, lat=leaflet_sample$pickup_latitude, 
              radius = 50, popup=paste("Pickup:", leaflet_sample$tpep_pickup_datetime), 
              fillColor = "red", color = "green", weight = 2) %>%
  addCircles(lng=leaflet_sample$dropoff_longitude, lat=leaflet_sample$dropoff_latitude, 
              radius = 100, popup=paste("Dropoff:", leaflet_sample$tpep_dropoff_datetime),
             fillColor = "black", color = "yellow", weight = 2) %>%
  addPolylines(lng=c(leaflet_sample$pickup_longitude, leaflet_sample$dropoff_longitude), lat=c(leaflet_sample$pickup_latitude, leaflet_sample$dropoff_latitude), popup=paste("Distance:", round(distance_measured,2), "miles, Fare:", paste0("$",leaflet_sample$fare_amount), ", Duration:", round(trip_duration,2), "minutes"))
m  # Print the map
