class Ingest:

    def __init__(self, spark):
        # A class level variable
        self.spark = spark

    def ingest_data(self):
        print("Ingesting from csv")
        #customer_df = self.spark.read.csv("file:///home/khedkaramit20178016/hdp/pigandhive/devph/labs/pyspark/spark-submit/retailstore.csv", header = True)
        customer_df = self.spark.read.csv("retailstore.csv", header = True)
        return customer_df

