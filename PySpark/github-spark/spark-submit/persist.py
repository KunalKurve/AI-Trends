class Persist:
    def __init__(self, spark):
        self.spark = spark

    def persist_data(self, df):
        print("Persisiting")
        #df.coalesce(1).write.option("header", "true").csv("file:///home/khedkaramit20178016/hdp/pigandhive/devph/labs/pyspark/spark-submit/transformed_retailstore")
        df.coalesce(1).write.option("header", "true").csv("transformed_retailstore")
