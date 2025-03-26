FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/myapp.jar /app/myapp.jar

ENTRYPOINT ["java", "-jar", "/app/myapp.jar"]
