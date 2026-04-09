# Kutoot

Flutter app for the Kutoot interview assignment — a rewards and nearby-stores discovery app.

## Screens

## Architecture

Module-based clean architecture with `flutter_bloc`. Each feature lives under `lib/modules/<name>` and is split into `data`, `domain` and `presentation` layers — repositories return `Either<Failure, T>` from dartz so the BLoCs can fold success/failure cleanly. Dependency injection is wired through `get_it`. Modules: `home`, `stores`, `store_details`, `rewards`, `plans`, `account`, `main` (the bottom-nav shell). Shared widgets (`ErrorView`, `ShimmerBox`, `SectionHeader`) live in `lib/widgets/`, theme + constants in `lib/config/`, infrastructure (errors, mock api, location/maps services, `SizeUtil` for responsive sizing) in `lib/core/`.

The backend is mocked — `core/network/mock_api_client.dart` simulates network latency and an optional failure rate so the app runs offline with realistic loading, error and retry states.

## Tech

- `flutter_bloc` + `equatable` for state management
- `dartz` for `Either<Failure, T>` repository return types
- `get_it` for DI
- `geolocator` for GPS + `url_launcher` for Google Maps deep links
- `cached_network_image`, `shimmer`, `carousel_slider` for the UI

## Run

```bash
flutter pub get
flutter run
```

Tests: `flutter test`
