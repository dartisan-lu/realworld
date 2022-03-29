FROM cirrusci/flutter:stable  AS stage-build

WORKDIR /app

COPY ./pubspec.yaml ./pubspec.yaml
COPY ./pubspec.lock ./pubspec.lock
COPY ./lib ./lib
COPY ./lib/config/system_values.docker ./lib/config/system_values.dart
COPY ./web ./web

RUN flutter pub get
RUN flutter build web

# run nginx
FROM nginx:1.21.6-alpine
COPY --from=stage-build /app/build/web /usr/share/nginx/html
