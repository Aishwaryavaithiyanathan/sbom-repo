FROM eclipse-temurin:11-jre

WORKDIR /app

COPY target/ci-sbom-demo-1.0.0.jar app.jar

CMD ["java", "-jar", "app.jar"]

