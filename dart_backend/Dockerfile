FROM dart:stable-sdk

WORKDIR /app

COPY ./pubspec.yaml ./pubspec.yaml
COPY ./pubspec.lock ./pubspec.lock
COPY ./.env.docker ./.env
COPY ./bin ./bin

RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/server.sh

EXPOSE 4200

ENTRYPOINT ["bin/server.sh"]
