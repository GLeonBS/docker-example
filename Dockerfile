FROM maven:3.9.9-amazoncorretto-17-alpine as build

COPY src /app/src
COPY pom.xml /app

WORKDIR /app
RUN mvn clean install

FROM openjdk:17-slim

COPY --from=build /app/target/docker-example-0.0.1-SNAPSHOT.jar /app/app.jar

WORKDIR /app

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]