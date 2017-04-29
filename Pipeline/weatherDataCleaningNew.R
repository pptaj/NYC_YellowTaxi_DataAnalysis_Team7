install.packages("weatherData")
install.packages("tables")
library(weatherData)

#filtering the weather data for 2016
weatherData1 <- getWeatherForDate("KNYC",start_date = "2015-01-01",end_date ="2015-12-31", opt_detailed =T, opt_custom_columns =T,custom_columns=c(2:13))
head(weatherData1)
weatherData1
head(weatherData1$Time)
install.packages("lubridate")
library(lubridate)
weatherData1$date <- date(weatherData1$Time)
weatherData1$hour <- hour(weatherData1$Time)
head(table(weatherData1$hour))
#View(weatherData11[which(weatherData11$date == "2016-01-01")])

#required formats
weatherData1$date <- as.Date(weatherData11$date, "%m %d %Y")
weatherData1$TemperatureF <- as.numeric(weatherData1$TemperatureF)
weatherData1$Dew_PointF <- as.numeric(weatherData1$Dew_PointF)
weatherData1$Sea_Level_PressureIn <- as.numeric(weatherData1$Sea_Level_PressureIn)
weatherData1$VisibilityMPH <- as.numeric(weatherData1$VisibilityMPH)
weatherData1$WindDirDegrees <- as.numeric(weatherData1$WindDirDegrees)
weatherData1$Humidity <- as.numeric(weatherData1$Humidity)
weatherData1$Wind_SpeedMPH[weatherData1$Wind_SpeedMPH == "Calm"] <- 0
weatherData1$Wind_SpeedMPH <- as.numeric(weatherData1$Wind_SpeedMPH)
exists("weatherData1")
ls()
weatherData1$TemperatureF
#removing dates with nas
is.na(weatherData1$date)
weatherData1 <- subset(weatherData1,(!is.na(weatherData1$date)))





#removing outliers
remove_out <- function(param,index,min_v,max_v){
  val = NULL
  val = param[index]
  if(val < min_v | val > max_v | is.na(val)){
    if(index-1 >= 1){
      val = param[index-1]
    } else if (index-1 <= 0){
      val = param[index+1]
    } 
    return(val)
  } else{
    print("Nothing changed")
    return(val)  #Normal Value return
  }
}

## Removing outliers/missing values using the above function from all the features
## Temperature
index <- which(weatherData1$TemperatureF < -60 | weatherData1$TemperatureF > 120 | is.na(weatherData1$Dew_PointF))
for (i in index){
  weatherData1$TemperatureF[i] = remove_out(weatherData1$TemperatureF,i,-60,120)
}

## Dew Point
index <- which(weatherData1$Dew_PointF < -60 | weatherData1$Dew_PointF > 120 | is.na(weatherData1$Dew_PointF))
for (i in index){
  weatherData1$Dew_PointF[i] = remove_out(weatherData1$Dew_PointF,i,-60,120)
}

## Humidity
index <- which(weatherData1$Humidity < 0 | weatherData1$Humidity > 100 | is.na(weatherData1$Humidity))
for (i in index){
  weatherData1$Humidity[i] = remove_out(weatherData1$Humidity,i,0,100)
}

## Wind_SpeedMPH
index <- which(weatherData1$Wind_SpeedMPH < 0 | weatherData1$Wind_SpeedMPH > 50 | is.na(weatherData1$Wind_SpeedMPH))
for (i in index){
  weatherData1$Wind_SpeedMPH[i] = remove_out(weatherData1$Wind_SpeedMPH,i,0,50)
}

## Sea_Level_Pressure
index <- which(weatherData1$Sea_Level_PressureIn < 28 | weatherData1$Sea_Level_PressureIn > 32 | is.na(weatherData1$Sea_Level_PressureIn))
for (i in index){
  weatherData1$Sea_Level_PressureIn[i] = remove_out(weatherData1$Sea_Level_PressureIn,i,28,32)
}

## VisibilityMPH
index <- which(weatherData1$VisibilityMPH < 0 | weatherData1$VisibilityMPH > 20 | is.na(weatherData1$VisibilityMPH))
for (i in index){
  weatherData1$VisibilityMPH[i] = remove_out(weatherData1$VisibilityMPH,i,0,20)
}

## WindDirDegree
index <- which(weatherData1$WindDirDegrees < 0 | weatherData1$WindDirDegrees > 360 | is.na(weatherData1$WindDirDegrees))
for (i in index){
  weatherData1$WindDirDegrees[i] = remove_out(weatherData1$WindDirDegrees,i,0,360)
}

# replacement
install.packages("zoo")
library(zoo)
#is.na(weatherData1$PrecipitationIn) <- weatherData1$PrecipitationIn == 0
#weatherData1$PrecipitationIn        <- na.locf(weatherData1$PrecipitationIn,na.rm=FALSE)
 
weatherData1 <- within(weatherData1, rm(Gust_SpeedMPH,Events))
write.csv(weatherData1, file = "G://ADS_Project//new_york_taxi_analysis_neu_info7390//weatherData2015.csv", row.names = FALSE)



