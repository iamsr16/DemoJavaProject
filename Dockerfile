FROM tomcat:8.5.63-jdk15-openjdk-slim-buster
RUN useradd -ms /bin/bash tomcat && \
    id -u tomcat | xargs -I{} chown -R {}:{} /usr/local/tomcat
USER tomcat
COPY target/*.war webapps/app.war
CMD ["catalina.sh", "run"]
