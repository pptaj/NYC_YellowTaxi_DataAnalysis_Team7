import luigi
from bs4 import BeautifulSoup
import urllib.request
import urllib.response
import mechanicalsoup
import pandas as pd
import requests
import luigi
from bs4 import BeautifulSoup
import urllib.request
import urllib.response
import mechanicalsoup
import pandas as pd
from Classes.Utils import create_directory
# import getpass
import re, os, zipfile, io
from Classes.Utils import get_logger

class GetData(luigi.Task):
    def requires(self):
        return []
 
    def output(self):
        return { 'output1' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-01.csv"),\
        'output2' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-02.csv"),\
        'output3' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-03.csv"),\
        'output4' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-04.csv"),\
        'output5' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-05.csv"),\
        'output6' : luigi.LocalTarget("Data/Downloads/yellow_tripdata_2016-06.csv") }
 
    def run(self):
        create_directory("Data")
        create_directory("Data/Downloads")

        downloads_dir = "Data/Downloads/"

        for i in range(1,7):
            fn = "0" + str(i)
            filename = "yellow_tripdata_2016-" + str(fn) + ".csv"
            url = "https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2016-" + str(fn) + ".csv"
            # print(url)

            if not (os.path.isfile(downloads_dir+filename)):
                req = urllib.request.Request(url)
                req.add_header('User-agent' , 'Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091102 Firefox/3.5.5')
                r = urllib.request.urlopen(req)



                csv = r.read()
                # Save the string to a file
                csvstr = str(csv).strip("b'")
                lines = csvstr.split("\\n")
                newfile = open(downloads_dir+filename, 'w')
                for line in lines:
                	newfile.write(line + "\n")

                newfile.close()