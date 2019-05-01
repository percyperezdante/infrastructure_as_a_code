#!/bin/bash -x

apt-get update
apt-get install -y vim git wget curl
apt-get install -y inetutils-ping
apt-get install -y openjdk-11-jdk
apt-get install -y net-tools
mkdir /app
bash /tmp/install_swarm.sh > /tmp/shared/log &
sleep 10000

