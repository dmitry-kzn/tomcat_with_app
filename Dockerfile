FROM ubuntu:20.04
#install working environment
RUN apt update -y
#RUN apt upgrade -y
###prevent user interaction while Configuring tzdata
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris apt-get -y install tzdata
RUN apt install -y openjdk-11-jdk wget git maven
#Tomcat installation
RUN mkdir /usr/local/tomcat
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.68/* /usr/local/tomcat/
#Apache  should listen port 8080
EXPOSE 8080
#prepare code for package by Maven & run it by Mavem
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd /boxfuse-sample-java-war-hello/ && mvn package
#copy war artifact to the Tomcat directory for run
RUN cd /boxfuse-sample-java-war-hello/target/ && cp hello-1.0.war /usr/local/tomcat/webapps/
#setup main docker process
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

##### Script to execute this Dockerfile on Ubuntu ########
# Create file.sh and put body of the script and make file executable
# nano lesson6.sh  
# chmod +x lesson6.sh

# =========== lesson6.sh ===============
#!/bin/bash
# apt update
# apt install docker.io -y
# git clone https://github.com/dmitry-kzn/devops-school_lesson_6.git
# cd devops-school_lesson_6/
# docker build -t lesson6 .
# docker run -d -p 8080:8080 --name lesson6 lesson6:latest
# curl http://localhost:8080
# curl http://localhost:8080/hello-1.0/