FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/MathLinux-0.0.1-SNAPSHOT.jar /app/MathLinux-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "/app/MathLinux-0.0.1-SNAPSHOT.jar"]
