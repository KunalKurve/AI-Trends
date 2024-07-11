from pyspark.sql import SparkSession

import ingest
import transform
import persist

class Pipeline:

    def run_pipeline(self):

        print("Running Pipeline")
        ingest_process = ingest.Ingest(self.spark)
        df = ingest_process.ingest_data()
        df.show() # Show original DataFrame
        tranform_process = transform.Transform(self.spark)
        transformed_df = tranform_process.transform_data(df)
        transformed_df.show() # Show transformed DataFrame

        persist_process = persist.Persist(self.spark)
        persist_process.persist_data(transformed_df)
        return

    def create_spark_session(self):
        # A class level variable
        self.spark = SparkSession.builder \
            .appName("my first spark app") \
            .enableHiveSupport().getOrCreate()

if __name__ == '__main__':
    pipeline = Pipeline()
    pipeline.create_spark_session()
    pipeline.run_pipeline()

