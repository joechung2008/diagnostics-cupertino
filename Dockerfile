FROM debian:trixie-slim AS build
RUN apt-get update && apt-get install -y --no-install-recommends git curl unzip xz-utils zip bash ca-certificates && rm -rf /var/lib/apt/lists/*
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$PATH"
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 $FLUTTER_HOME
RUN flutter --version
WORKDIR /app
COPY pubspec.* ./
RUN flutter pub get
COPY . .
RUN flutter pub get --offline
RUN flutter build web --release
FROM nginx:1.29.1-alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
