import luigi
from Classes.GetData import GetData
import pandas as pd
from Classes.Utils import create_directory
import os, re
import numpy as np



def cleanData(taxiData):
    
    print("Removing Vendor ID")
    taxiData = taxiData.drop('VendorID', axis=1)
    #Passenger Count: Remove rows where  is negative/zero
                    #If not remove, replace by 2( Avg passenger count)
                    #Remove count >7 or <=0
    print("DONE")
    print("Split Dates")

    #split#Pickup
    taxiData['Pickup_Date'] = (taxiData.tpep_pickup_datetime.str.partition(' ')[0])
    taxiData['Pickup_Time'] = (taxiData.tpep_pickup_datetime.str.partition(' ')[2])
    #split dropoff
    taxiData['Dropoff_Date'] = (taxiData.tpep_dropoff_datetime.str.partition(' ')[0])
    taxiData['Dropoff_Time'] = (taxiData.tpep_dropoff_datetime.str.partition(' ')[2])
    print("DONE")

    print("Convert to Date Time")
    #Pickup date & Time - Convert 
    taxiData['tpep_pickup_datetime'] = pd.to_datetime(taxiData['tpep_pickup_datetime'])
    taxiData['Pickup_Date'] = pd.to_datetime(taxiData['Pickup_Date'])
    #Pickup date & Time - Convert 
    taxiData['tpep_dropoff_datetime'] = pd.to_datetime(taxiData['tpep_dropoff_datetime'])
    taxiData['Dropoff_Date'] = pd.to_datetime(taxiData['Dropoff_Date'])
    print("DONE")

    print("Assign week_number")
    #Assign week number -  Monday=0, Sunday=6
    taxiData['Day_of_week'] = taxiData['tpep_pickup_datetime'].dt.dayofweek
    print("DONE")

    #->Workday/Not FLag
    print("Assigning Workday flag")
    taxiData["Workday_flag"]=1
    taxiData.loc[((taxiData['Pickup_Date']=='2016-01-01')|
                  (taxiData['Pickup_Date']=='2016-01-18')|
                  (taxiData['Pickup_Date']=='2016-02-12')|
                  (taxiData['Pickup_Date']=='2016-02-15')|
                  (taxiData['Pickup_Date']=='2016-05-30')|
                  (taxiData['Pickup_Date']=='2016-07-04')|
                  (taxiData['Pickup_Date']=='2016-09-15')|
                  (taxiData['Pickup_Date']=='2016-10-10')|
                  (taxiData['Pickup_Date']=='2016-11-08')|
                  (taxiData['Pickup_Date']=='2016-11-11')|
                  (taxiData['Pickup_Date']=='2016-11-24')|
                  (taxiData['Pickup_Date']=='2016-12-25')|
                  (taxiData['Day_of_week']==5)|
                  (taxiData['Day_of_week']==6)),['Workday_flag']]=0

    print("DONE")



    print("Assign weekend flag")
    #weekend/Not flag   
    taxiData["Weekend_flag"]=0
    taxiData.loc[((taxiData['Day_of_week']==5)|
                  (taxiData['Day_of_week']==6)),['Weekend_flag']]=1
    print("DONE")

    print("Cleaning passenger_count")
    #Cleaning passenger_count
    taxiData = taxiData[taxiData.passenger_count.notnull()] #removes rows with null coount
    taxiData = taxiData[(taxiData.passenger_count != 0)]#removes zero and above 8 passenger count
    taxiData = taxiData[(taxiData.passenger_count < 8)]
    ("DONE")

    #calculating Trip-Time & removing rows with elapsed trip time as zero

    print("calculating Trip-Time & Cleaning based on time")
    taxiData["Triptime"] = taxiData["tpep_dropoff_datetime"]-taxiData["tpep_pickup_datetime"]
    taxiData = taxiData[(taxiData.Triptime !=  "00:00:00")]
    print("DONE")

    #199,725

    print("Cleaning based on trip distance and fare amount")
    #Trip distance: Remove all trips that have distance zero and price above $5 (679 rows off 200,000)
    taxiData = taxiData[(taxiData.trip_distance > 0)]
    ##198416

    #remove negative prices trips (206)
    taxiData = taxiData[(taxiData.fare_amount > 0)]
    print("DONE") #198210

    print("Negative extra charges")
    #remove negative extra chahrges - 91 rows
    taxiData = taxiData[(taxiData.extra >= 0)]
    print("DONE")

    print("Removing unnecessary columns")
    columnsTODelete =  ['extra', 'mta_tax','tip_amount',"tolls_amount","improvement_surcharge","total_amount", "payment_type", "store_and_fwd_flag"]
    taxiData.drop(columnsTODelete, axis=1, inplace=True)
    print("DONE")
    
#     Rounding coordinates to 4 decimal points
#     taxiData.round({'dropoff_longitude': 4, 'dropoff_latitude': 4, 'pickup_longitude' : 4,'pickup_latitude' : 4})
    taxiData['dropoff_longitude'] = taxiData['dropoff_longitude'].round(4) 
    taxiData['dropoff_latitude'] = taxiData['dropoff_latitude'].round(4)
    taxiData['pickup_longitude'] = taxiData['pickup_longitude'].round(4)
    taxiData['pickup_latitude'] = taxiData['pickup_latitude'].round(4)
    
    
    #     Rounding coordinates to 2 decimal points in new column
    taxiData['pickup_latitude_2decimal'] = taxiData['pickup_latitude']
    taxiData['dropoff_latitude_2decimal'] = taxiData['dropoff_latitude']
    taxiData['pickup_longitude_2decimal'] = taxiData['pickup_longitude']
    taxiData['dropoff_longitude_2decimal'] = taxiData['dropoff_longitude']
#     taxiData.round({'dropoff_longitude_2decimal': 2, 'dropoff_latitude_2decimal': 2, 'pickup_longitude_2decimal' : 2,'pickup_latitude_2decimal' : 2})
    taxiData['pickup_latitude_2decimal'] = taxiData['pickup_latitude_2decimal'].round(2) 
    taxiData['dropoff_latitude_2decimal'] = taxiData['dropoff_latitude_2decimal'].round(2)
    taxiData['pickup_longitude_2decimal'] = taxiData['pickup_longitude_2decimal'].round(2)
    taxiData['dropoff_longitude_2decimal'] = taxiData['dropoff_longitude_2decimal'].round(2)
    #     Removing Outliers

#     coordinates = 40.941211, -74.207382 : coordinated = 40.456034, -73.757629
#     keeping where lat is less than max and greater than min
    print("removing records out of nyc boundary")
    taxiData = taxiData[(taxiData['pickup_latitude'] < 40.9412)]
    taxiData = taxiData[(taxiData['pickup_latitude'] > 40.4560)]
    taxiData = taxiData[(taxiData['pickup_longitude'] < -73.7576)]
    taxiData = taxiData[(taxiData['pickup_longitude'] > -74.2073)]
    taxiData = taxiData[(taxiData['dropoff_latitude'] < 40.9412)]
    taxiData = taxiData[(taxiData['dropoff_latitude'] > 40.4560)]
    taxiData = taxiData[(taxiData['dropoff_longitude'] < -73.7576)]
    taxiData = taxiData[(taxiData['dropoff_longitude'] > -74.2073)]
    print("removed records out of nyc boundary")
    
# Keeping where trip distance is less than 10 miles
    taxiData = taxiData[(taxiData.trip_distance < 10)]
#     fare amount >0 and < 50
    taxiData = taxiData[(taxiData.fare_amount > 0)]
    taxiData = taxiData[(taxiData.fare_amount < 50)]
    
#  Triptime > 1 minute and < 3 hour
    taxiData = taxiData[(taxiData.Triptime >  "00:01:00")]
    taxiData = taxiData[(taxiData.Triptime <  "03:00:01")]

# Ratecode id 1 to 6
    taxiData = taxiData[(taxiData.RatecodeID >= 1)]
    taxiData = taxiData[(taxiData.RatecodeID <= 6)]
    
#     Converting Triptime to seconds
    taxiData['Triptime'] = (pd.to_timedelta(taxiData['Triptime'],unit='d')).astype('timedelta64[s]')
    
#    Adding Hour of the day
    taxiData['Hour_of_day'] = taxiData['tpep_pickup_datetime'].dt.hour
    
    return taxiData
    

class CleanData(luigi.Task):
    def requires(self):
        return [GetData()]
 
    def output(self):
        return { 'output1' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-01.csv"), \
        'output2' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-02.csv"),\
        'output3' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-03.csv"),\
        'output4' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-04.csv"),\
        'output5' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-05.csv"),\
        'output6' : luigi.LocalTarget("Data/Cleaned/combinedData_yellow_tripdata_2016-06.csv")}
                
    def run(self):
        create_directory("Data")
        create_directory("Data/Cleaned")

        downloads_dir = "Data/Downloads/"
        cleaned_dir = "Data/Cleaned/"
        # encoding = "ISO-8859-1",

        weatherData = pd.read_csv("cleaned_weatherdata_withflagfinal.csv")

        weatherData['date'] = pd.to_datetime(weatherData['date'])

        for i in range (1,7):
            fullData = None
            combinedData = None
            combinedDataForDrivers = None
            if(i<10):
                fn = "0" + str(i)
            else:
                fn = str(i)
                
            for taxiData in pd.read_csv(downloads_dir + "yellow_tripdata_2016-" + fn + ".csv", sep=",", chunksize = 200000, iterator = True):
                
                print("Shape = " + str(taxiData.shape))
                taxiData = cleanData(taxiData)
                #     Join weather Data
                print("Shape of fullData = " + str(taxiData.shape) )
                print("Shape of weatherData = " + str(weatherData.shape) )


                taxiData['Pickup_Date'] = pd.to_datetime(taxiData['Pickup_Date'])
                print("datatypes in taxiData= " + str(taxiData['Pickup_Date'].dtype) + " & " + str(taxiData['Hour_of_day'].dtype))
                print("datatypes in weatherData= " + str(weatherData['date'].dtype) + " & " + str(weatherData['hour'].dtype))
                combinedData = pd.merge(taxiData, weatherData,  how='inner', left_on=['Pickup_Date','Hour_of_day'], right_on = ['date','hour'])
        #         combinedData.to_csv("Data/combinedData_yellow_tripdata_2016-" + fn + ".csv", sep=',', index = False)
        #         print("Shape of combinedData = " + str(combinedData.shape) )
            
                
                if not (os.path.isfile(cleaned_dir + "combinedData_yellow_tripdata_2016-" + fn + ".csv")):
                    combinedData.to_csv(cleaned_dir + "combinedData_yellow_tripdata_2016-" + fn + ".csv", sep=',', index = False)
                else:
                    with open(cleaned_dir + "combinedData_yellow_tripdata_2016-" + fn + ".csv", 'a') as f:
                        combinedData.to_csv(f, sep = ',', index = False, header = False)
