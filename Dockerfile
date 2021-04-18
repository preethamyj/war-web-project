FROM tomcat:latest
COPY ./target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
ENTRYPOINT service tomcat start && bash
