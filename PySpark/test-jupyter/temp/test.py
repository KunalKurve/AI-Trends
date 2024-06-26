#!/usr/bin/python

#Entrypoint 2.x
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Spark SQL basic example").enableHiveSupport().getOrCreate()

# On yarn:
# spark = SparkSession.builder.appName("Spark SQL basic example").enableHiveSupport().master("yarn").getOrCreate()
# specify .master("yarn")

sc = spark.sparkContext

file_path = "file:///home/talentum/test-jupyter/P2/M1/SM7/constitution.txt"
print("Here is the output:") 
# Create a baseRDD from the file path
print(sc.textFile(file_path) \
.flatMap(lambda x: x.split(' '))\
.map(lambda word: (word, 1))\
.reduceByKey(lambda x, y: x + y)\
.map(lambda tup: (tup[1], tup[0]))\
.sortByKey(ascending=False).take(10))
