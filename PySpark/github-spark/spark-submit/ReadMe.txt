Section 15: Creating a PySpark real world coding
framework
81. Separating out Ingestion, Transformation and
Persistence code

2) YARN client mode
spark-submit --master yarn --deploy-mode client --driver-memory 2g --num-executors 2 --executor-memory 1g data_pipeline.py
3) YARN cluster mode
spark-submit --master yarn --deploy-mode cluster --py-files ingest.py,transform.py,persist.py --driver-memory 2g --num-executors 2 --executor-memory 1g data_pipeline.py
