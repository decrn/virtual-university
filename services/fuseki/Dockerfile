FROM jetty:9.4.35
WORKDIR /var/lib/jetty
COPY ./mount/fuseki.war ./webapps/fuseki.war
USER root
RUN mkdir /etc/fuseki
COPY ./mount/fuseki/configuration/virtual-university.ttl /etc/fuseki/configuration/virtual-university.ttl
COPY ./mount/fuseki/config.ttl /etc/fuseki/config.ttl
COPY ./mount/fuseki/shiro.ini /etc/fuseki/shiro.ini
ENTRYPOINT java -jar "$JETTY_HOME/start.jar"