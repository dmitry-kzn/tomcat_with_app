FROM ubuntu:20.04
#install working environment
RUN apt update
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install git -y
RUN apt install tomcat9 -y
#Apache  should listen port 8080
EXPOSE 8080
#prepare code for package by Maven 
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
RUN cd boxfuse-sample-java-war-hello/
#package code by Maven
RUN mvn package
#copy war artifact to the Tomcat directory for run
RUN cd target/
RUN cp hello-1.0.war /var/lib/tomcat9/webapps/
CMD bash /bin/bash