FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/MathLinux.jar /app/MathLinux.jar

ENTRYPOINT ["java", "-jar", "/app/MathLinux.jar"]
