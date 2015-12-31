from sergeyzh/centos6-java:jdk7
MAINTAINER wenhao lin

# build  mysql server
RUN cd  /tmp   &&\
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm  &&\
    yum install -y mysql55w mysql55w-server

RUN rm -rf /etc/my.cnf
ADD ./my.cnf  /etc/my.cnf
ADD ./mysql-init.sh  /usr/bin/mysql-init.sh
RUN chmod +x /usr/bin/mysql-init.sh
RUN /usr/bin/mysql-init.sh

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


# the web apps is located at /opt/tomcat/apache-tomcat-7.0.55/webapps

# server.sh
ADD ./server.sh  /server.sh
RUN chmod 777    /server.sh

EXPOSE 3306 8080
CMD ["/server.sh"]
