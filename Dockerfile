FROM openjdk:11.0.8-jre-slim
VOLUME /tmp
ADD millionaire-show.jar millionaire-show.jar
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=prod", "/millionaire-show.jar"]
