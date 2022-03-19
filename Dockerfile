FROM jetty
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/jetty/webapps/dockeransible.war
