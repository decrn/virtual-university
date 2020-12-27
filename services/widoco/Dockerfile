FROM alpine
RUN mkdir -p /data && \
  apk add openjdk8-jre && \
  wget https://github.com/dgarijo/Widoco/releases/download/v1.4.14/widoco-1.4.14-jar-with-dependencies.jar -O widoco.jar
WORKDIR /data
COPY ./config.properties /config/config.properties
ENTRYPOINT ["java", "-jar", "/widoco.jar", "-confFile", "/config/config.properties", "-ontFile", "/ontology.owl", "-outFolder", "/output", "-rewriteAll", "-uniteSections"]