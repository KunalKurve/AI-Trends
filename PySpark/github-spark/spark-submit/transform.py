class Transform:

    # TODO 3 - Add a constructor here
    def __init__(self, spark):
        self.spark = spark

    def transform_data(self, df):
        print("Transforming")
        # drop all the rows having null values
        df1 = df.na.drop()
        return df1