# Use Maven to build the project
FROM maven:3.8.4-openjdk-17 AS BUILD
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use OpenJDK image to run the Spring Boot application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=BUILD /build/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
