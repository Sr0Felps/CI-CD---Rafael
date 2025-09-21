#--- Estágio 1: Build ---
FROM maven:3.8.6-openjdk-17 as builder
WORKDIR /app
COPY . .
RUN mvn -B package -DskipTests

#--- Estágio 2: Runtime ---
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]