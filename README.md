# Kutoot

Flutter app for the Kutoot interview assignment — rewards + nearby-stores discovery.

Built with clean architecture and `flutter_bloc`. Each feature lives under `lib/modules/<name>` and is split into `data`, `domain` and `presentation` layers; repositories return `Either<Failure, T>` from dartz and DI is wired through `get_it`. Location is read with `geolocator` and the navigate buttons deep-link into Google Maps via `url_launcher`. The backend is mocked (`core/network/mock_api_client.dart`), so the app runs offline with simulated latency, shimmer placeholders and retry on failure.

## Run

```bash
flutter pub get
flutter run
```

Tests: `flutter test`
