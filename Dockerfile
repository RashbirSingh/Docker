#This is a phusion/baseimage:0.11 Image
FROM phusion/baseimage:0.11
MAINTAINER rashbits@gmail.com

# Installing dependencies and java version 8
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    apt-get update && \
    apt install openjdk-8-jdk -y && \
    apt install openjdk-8-jre -y && \
    apt install maven -y && \
    apt-get install wget -y && \
    apt-get clean

# Running echo command cat >> /etc/environment <<EOL
CMD ["echo",  "cat >> /etc/environment <<EOL"]

# Making directory /var/datanext
RUN mkdir /var/DataFlowService

# Copying file from target folder to above created folder
COPY ./DataFlowService /var/DataFlowService

#Downloading flink
WORKDIR /var
RUN wget http://apachemirror.wuchna.com/flink/flink-1.8.1/flink-1.8.1-bin-scala_2.11.tgz && \
    tar xzf flink-*.tgz

#Using Maven to build jar
WORKDIR /var/DataFlowService
RUN mvn clean install
RUN mvn package

# running .jar file
CMD /var/flink*/bin/flink run -j /var/DataFlowService/target/engine-bundled.jar
#CMD java -jar /var/DataFlowService/target/engine-bundled.jar
#CMD ls target
