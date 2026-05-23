FROM openjdk:27-ea-jdk

WORKDIR /demo_1

COPY target/*.jar demo_1.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","demo_1.jar"]