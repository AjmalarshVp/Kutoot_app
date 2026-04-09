# Kutoot

Flutter rewards & nearby-stores app built for the Kutoot interview assignment.

## Features

- Home screen with promo banner, category tiles, nearby stores carousel and weekly rewards.
- Stores tab with location-based 2-column grid, category filter chips and pagination.
- Store details screen with image gallery, ratings, address, offers, services, mini map preview and "Navigate Now" deep-link to Google Maps.
- Pull-to-refresh, shimmer placeholders, retry on failure, location permission handling.
- 5-tab bottom navigation with the Stores tab centered under the QR FAB.

## Architecture

Module-based clean architecture with BLoC.

```
lib/
├── main.dart, app.dart, injection_container.dart
├── config/{theme, constants}
├── core/{errors, network, services, utils}
├── widgets/                                    # shared widgets
└── modules/<module>/
    ├── data/{datasources, models, repositories}
    ├── domain/{entities, repositories}
    └── presentation/{bloc, screens, widgets}
```

Modules: `home`, `stores`, `store_details`, `rewards`, `plans`, `account`, `main`.

## Tech

- `flutter_bloc` + `equatable` for state management
- `dartz` `Either<Failure, T>` for repository return types
- `get_it` for dependency injection
- `geolocator` + `url_launcher` for GPS and Google Maps deep links
- `cached_network_image`, `shimmer`, `carousel_slider` for UI
- Mock API client (`core/network/mock_api_client.dart`) simulates latency and failure rate

## Run

```
flutter pub get
flutter run
```

Tests:

```
flutter test
```
