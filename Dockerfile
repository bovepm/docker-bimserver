FROM tomcat:8.5-jre8

ARG BIMSERVER_VERSION=1.5.109
ENV BIMSERVER_VERSION ${BIMSERVER_VERSION}

ENV TOMCAT_HOME /usr/local/tomcat
#ENV BIMSERVER_APP $TOMCAT_HOME/webapps/bimserver
ENV BIMSERVER_APP $TOMCAT_HOME/webapps/ROOT

# Delete the example Tomcat app to speed up deployment.
RUN rm -rf $TOMCAT_HOME/webapps/examples \
    && mv $TOMCAT_HOME/webapps/ROOT $TOMCAT_HOME/webapps/default

ADD https://github.com/opensourceBIM/BIMserver/releases/download/v${BIMSERVER_VERSION}/bimserverwar-${BIMSERVER_VERSION}.war ${BIMSERVER_APP}.war
RUN unzip $BIMSERVER_APP.war -d $BIMSERVER_APP

ENV CATALINA_HOME=/usr/local/tomcat
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

# Add roles and increase file size for webapps to 500Mb
ADD ./web.xml /usr/local/tomcat/webapps/manager/WEB-INF/web.xml
ADD ./server.xml /usr/local/tomcat/conf/server.xml
ADD ./run.sh /run.sh

VOLUME /var/bimserver

EXPOSE 8080

CMD /run.sh
