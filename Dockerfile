FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/MathLinux-0.0.1-SNAPSHOT.jar /app/MathLinux-0.0.1-SNAPSHOT.jar

EXPOSE 8081

RUN ls -lh /app

ENTRYPOINT ["java", "-jar", "/app/MathLinux-0.0.1-SNAPSHOT.jar"]
