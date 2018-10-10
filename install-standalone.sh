# ----------------------------------------------------------------------------------
# Part I: Installation
# ----------------------------------------------------------------------------------
# => Step 1: Install Java
# ----------------------------------------------------------------------------------

sudo apt-get update
sudo apt-get install default-jre

# ----------------------------------------------------------------------------------
# => Step 2: Download Kafka
# Download kafka from http://kafka.apache.org/downloads.html::
# ----------------------------------------------------------------------------------

cd ~/
wget http://apache.claz.org/kafka/2.0.0/kafka_2.11-2.0.0.tgz

# ----------------------------------------------------------------------------------
# => Step 3: Untar and move binaries to /usr/local/kafka
# ----------------------------------------------------------------------------------

tar xvf kafka_2.11-2.0.0.tgz
sudo mv kafka_2.11-2.0.0 /usr/local/kafka

echo 'export KAFKA_PATH="/usr/local/kafka"' >> ~/.bashrc
echo 'export PATH="$KAFKA_PATH/bin/:$PATH"' >> ~/.bashrc
# ----------------------------------------------------------------------------------
# Part 2: Setup zookeeper
# ----------------------------------------------------------------------------------
# Step 1: Create the data directories for Kafka and Zookeeper 
# ----------------------------------------------------------------------------------

sudo mkdir -p /var/zookeeper/data
sudo chown ${USER}:${USER} -R /var/zookeeper

# See config file for details
cat ./config/standalone/zookeeper.properties

