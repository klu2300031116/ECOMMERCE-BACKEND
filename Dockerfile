# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Deploy on Tomcat
FROM tomcat:9.0-jdk17-temurin
WORKDIR /usr/local/tomcat/webapps/
RUN rm -rf *
COPY --from=build /app/target/*.war ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
