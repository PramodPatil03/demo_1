FROM eclipse-temurin:17-jre-alpine

WORKDIR /demo_1

COPY target/*.jar demo_1.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","demo_1.jar"]
