#!/bin/sh

#     *********************************
#     This script pushes the data into Kafka
#     *********************************

#     Read the data file in a loop, pausing .1 sec between each loop.
#     Push the data into Kafka using a convenience script in $KAFKA_HOME/bin
while read -r line ; do echo "$line"; sleep .1; done < "./voters-5K.json" | kafka-console-producer.sh --broker-list 127.0.0.1:9092 --topic voters
