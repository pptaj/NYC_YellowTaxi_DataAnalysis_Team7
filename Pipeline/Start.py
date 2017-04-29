import luigi
from Classes.CleanDriverData import CleanDriverData
import pandas as pd
from Classes.Utils import create_directory
from Classes.Utils import get_logger
import numpy as np
import time
import urllib.response
import urllib.request
from bs4 import BeautifulSoup
import os
import re
from urllib.request import urlopen
import csv
import string
from string import punctuation
import zipfile
import os
import sys
import logging
import boto
import boto.s3
from boto.s3.key import Key


def check_if_file_exists(aws_access_key,aws_secret_key,fileName,filePath):
    

    bucket_name = aws_access_key.lower()   
    conn = boto.connect_s3(aws_access_key,aws_secret_key)
    #print(bucket_name)
    filePresetflag = False
    bucket = conn.lookup(bucket_name)
    #print(bucket)
    if not (bucket == None):

        for key in bucket.list(delimiter='/'):
            # print("S3 == " + key.name)
            for f in bucket.list(key.name):
                # print("2 == " + f.name)
                if(f.name == filePath):
                    # print (f.name + " = " + fileName + " !!! Already exists !!!")
                    filePresetflag = True
                    
                        

    if (filePresetflag == True):
        return True
    else:
        return False
            
            
def amazon_upload(aws_access_key,aws_secret_key,file):    
    bucket_name = aws_access_key.lower()   
    conn = boto.connect_s3(aws_access_key,aws_secret_key)

    bucket = conn.lookup(bucket_name)
    if bucket is None:
        bucket = conn.create_bucket(bucket_name, location=boto.s3.connection.Location.DEFAULT)

    #testfile = "LendingClubLoan.csv"
    def percent_cb(complete, total):
        sys.stdout.write('.')
        sys.stdout.flush()

    k = Key(bucket)
    k.key = file
    k.set_contents_from_filename(file,cb=percent_cb, num_cb=10)
    
    buckets = conn.get_all_buckets()#Get the bucket list
    for i in buckets:
        print(i.name)


def upload_To_Amazon(filepath, i, aws_access_key, aws_secret_key, fileName):
	r = check_if_file_exists(aws_access_key,aws_secret_key,fileName, filepath)
	if (r==False):
		amazon_upload(aws_access_key,aws_secret_key,filepath)
        # r = check_if_file_exists(aws_access_key,aws_secret_key,fileName2, filePath2)
        # if (r==False):
        #     amazon_upload(aws_access_key,aws_secret_key,filePath2)
	r = check_if_file_exists(aws_access_key,aws_secret_key,fileName, filepath)
	if(r==True):
		create_directory("Data")
		open("Data/uploaded_" + str(i) + ".csv", 'a').close()


class Start(luigi.Task):

 
    def requires(self):
        return [CleanDriverData()]
 
    def output(self):
        return { 'output1' : luigi.LocalTarget("Data/uploaded_1.csv"),\
        'output2' : luigi.LocalTarget("Data/uploaded_2.csv"),\
        'output3' : luigi.LocalTarget("Data/uploaded_3.csv"),\
        'output4' : luigi.LocalTarget("Data/uploaded_4.csv"),\
        'output5' : luigi.LocalTarget("Data/uploaded_5.csv"),\
        'output6' : luigi.LocalTarget("Data/uploaded_6.csv"),\
        'output7' : luigi.LocalTarget("Data/uploaded_7.csv")}
 
    def run(self):
        #READ AMAZON KEYS FROM USER
        aws_access_read = input("Enter your aws access key: ")
        aws_secret_read = input("Enter your aws secret key: ")

        aws_access_key = aws_access_read.strip()
        aws_secret_key = aws_secret_read.strip()
        #print("check")


        
        # fileName2 = "cleaned_reject_loandata.csv"
        clean_dir = "Data/Cleaned/"
        # filePath2 = clean_dir + fileName2

        for i in range (1,8):
        	fn = "0" + str(i)
        	if(i<7):
        		fileName = "combinedData_yellow_tripdata_2016-"+  fn + ".csv"
        	else:
        		fileName = "pickupDataForClassification.csv"
        	filepath = clean_dir + fileName
        	upload_To_Amazon(filepath, i, aws_access_key, aws_secret_key, fileName)

        
if __name__ == '__main__':
    try:
        os.remove("Data/uploaded_1.csv")
        os.remove("Data/uploaded_2.csv")
        os.remove("Data/uploaded_3.csv")
        os.remove("Data/uploaded_4.csv")
        os.remove("Data/uploaded_5.csv")
        os.remove("Data/uploaded_6.csv")
        os.remove("Data/uploaded_7.csv")
    except:
        pass
    luigi.run()