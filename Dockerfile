#This is a ubumtu 18:04 Image
FROM ubuntu:18.04
MAINTAINER rashbits@gmail.com

# Installing dependencies and java version 8
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    apt-get update && \
    apt install openjdk-8-jdk -y && \
    apt install openjdk-8-jre -y && \
    apt-get clean

# Running echo command cat >> /etc/environment <<EOL
CMD ["echo",  "cat >> /etc/environment <<EOL"]

# Making directory /var/datanext
RUN mkdir /var/DataFlowService

# Copying file from target folder to above created folder
COPY ./DataFlowService /var/DataFlowService

#Using Maven to build jar
WORKDIR /var/DataFlowService
CMD mvn package

# running .jar file
CMD java -jar /var/DataFlowService/target/original-engine-bundled.jar