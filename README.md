# diagnostics_cupertino

A Flutter web application for monitoring and displaying Azure Portal Extension diagnostics across different environments.

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.9.0 or later)
- Dart SDK (included with Flutter)

## Setup

1. Clone the repository:

```bash
git clone https://github.com/joechung2008/diagnostics-cupertino.git
cd diagnostics-cupertino
```

2. Install dependencies:

```bash
flutter pub get
```

## Running the Web App

### Development Server

To run the app in development mode with hot reload:

```bash
# Run in Chrome browser (recommended for development)
flutter run -d chrome

# Run in other browsers
flutter run -d firefox
flutter run -d safari
flutter run -d edge

# Run as a web server (accessible from any browser)
flutter run -d web-server
```

When running as a web server, the app will be available at:

- **Local**: http://localhost:8080
- **Network**: http://[your-ip]:8080 (accessible from other devices on the same network)

### Production Build and Serve

To build and serve the production version:

```bash
# Build for production
flutter build web

# Serve the built files using Flutter's built-in server
flutter run -d web-server --release
```

### Development vs Production

- **Development** (`flutter run -d chrome`): Includes hot reload, debugging tools, and development optimizations
- **Production** (`flutter build web`): Optimized for performance, smaller bundle size, no debugging tools

## Formatting

Format the code using Dart's built-in formatter:

```bash
dart format .
```

## Linting

Run the linter to check for code issues:

```bash
flutter analyze
```

## Testing

Run the test suite:

```bash
flutter test
```

For test coverage:

```bash
flutter test --coverage
```
