docker network create -d bridge --attachable --subnet=10.242.70.0/25 --gateway=10.242.70.1 kafka-net


docker run --name=srv-kafka1 --hostname="srv-kafka1" --restart=unless-stopped \
    --network="kafka-net" --ip="10.242.70.101" -p 0.0.0.0:9901:22 \
    --add-host=srv-kafka1:10.242.70.101 --add-host=srv-zookeeper1:10.242.70.101 \
    --add-host=srv-kafka2:10.242.70.102 --add-host=srv-zookeeper2:10.242.70.102 \
    -d ubuntu/developers


docker run --name=srv-kafka2 --hostname="srv-kafka2" --restart=unless-stopped \
    --network="kafka-net" --ip="10.242.70.102" -p 0.0.0.0:9902:22 \
    --add-host=srv-kafka1:10.242.70.101 --add-host=srv-zookeeper1:10.242.70.101 \
    --add-host=srv-kafka2:10.242.70.102 --add-host=srv-zookeeper2:10.242.70.102 \
    -d ubuntu/developers


docker run --name=kafka-producer --hostname="kafka-producer" --restart=unless-stopped \
    --add-host=srv-kafka1:10.242.70.101 --add-host=srv-zookeeper1:10.242.70.101 \
    --add-host=srv-kafka2:10.242.70.102 --add-host=srv-zookeeper2:10.242.70.102 \
    --network="kafka-net" --ip="10.242.70.30" -p 0.0.0.0:9930:22 \
    -d ubuntu/developers


docker run --name=kafka-consumer --hostname="kafka-consumer" --restart=unless-stopped \
    --add-host=srv-kafka1:10.242.70.101 --add-host=srv-zookeeper1:10.242.70.101 \
    --add-host=srv-kafka2:10.242.70.102 --add-host=srv-zookeeper2:10.242.70.102 \
    --network="kafka-net" --ip="10.242.70.50" -p 0.0.0.0:9950:22 \
    -d ubuntu/developers
