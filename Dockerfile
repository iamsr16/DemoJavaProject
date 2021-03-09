FROM tomcat:8.5.63-jdk15-openjdk-slim-buster
COPY target/example-app-1.0.war webapps/app.war
CMD ["catalina.sh", "run"]