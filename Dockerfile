from sergeyzh/centos6-java:jdk7
MAINTAINER wenhao lin

# build  mysql server
RUN cd  /tmp   &&\
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm  &&\
    yum install -y mysql55w mysql55w-server

RUN rm -rf /etc/my.cnf
ADD ./mysql/my.cnf  /etc/my.cnf

VOLUME /var/lib/mysql

#build tomcat7
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.55
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz  && \
    mv apache-tomcat* "$CATALINA_HOME"

# add cdnexus schema
ADD ./mysql/cdnexus.schema.sql   /cdnexus.schema.sql

# add api server
ADD ./apiserver/apiserver-1.0-dev-SNAPSHOT.war   ${CATALINA_HOME}/webapps/api.war

# server-init.sh
ADD ./server-init.sh  /server-init.sh
RUN chmod 777    /server-init.sh

EXPOSE 3306 8080
CMD ["/server-init.sh"]
