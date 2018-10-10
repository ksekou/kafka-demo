# Create a new topic
kafka-topics.sh --create --zookeeper srv-zookeeper1:2181,srv-zookeeper2:2181 \
    --topic TEST-TOPIC --replication-factor 2 --partitions 3

kafka-topics.sh --alter --zookeeper srv-zookeeper1:2181,srv-zookeeper2:2181 --topic TEST-TOPIC --partitions 3



kafka-topics.sh --list --zookeeper srv-zookeeper1:2181,srv-zookeeper2:2181
kafka-topics.sh --describe --topic TEST-TOPIC --zookeeper srv-zookeeper1:2181,srv-zookeeper2:2181

kafka-console-producer.sh --broker-list srv-kafka1:9092,srv-kafka2:9092 --topic TEST-TOPIC
kafka-console-consumer.sh --bootstrap-server srv-kafka1:9092,srv-kafka2:9092 --topic TEST-TOPIC --from-beginning


kafka-producer-perf-test.sh --topic TEST-TOPIC \
    --num-records 100000 \
    --record-size 100 \
    --throughput 1000 \
    --producer-props \
    acks=1 bootstrap.servers=srv-kafka1:9092,srv-kafka2:9092