import 'package:geolocator/geolocator.dart';

import '../errors/exceptions.dart' as app_ex;

class UserLocation {
  final double latitude;
  final double longitude;
  final String? city;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    this.city,
  });
}

abstract class LocationService {
  Future<UserLocation> getCurrentLocation();
  Future<bool> hasPermission();
}

class GeolocatorLocationService implements LocationService {
  static const fallback = UserLocation(
    latitude: 19.0760,
    longitude: 72.8777,
    city: 'Mumbai',
  );

  @override
  Future<UserLocation> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw app_ex.LocationDisabledException();
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw app_ex.LocationPermissionException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw app_ex.LocationPermissionException(
          'Location permissions are permanently denied',
        );
      }

      // ignore: deprecated_member_use
      final position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      return UserLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        city: 'Mumbai',
      );
    } on app_ex.LocationPermissionException {
      rethrow;
    } on app_ex.LocationDisabledException {
      rethrow;
    } catch (_) {
      return fallback;
    }
  }

  @override
  Future<bool> hasPermission() async {
    final p = await Geolocator.checkPermission();
    return p == LocationPermission.always ||
        p == LocationPermission.whileInUse;
  }

  static double distanceKm({
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
  }) {
    final meters = Geolocator.distanceBetween(fromLat, fromLng, toLat, toLng);
    return meters / 1000.0;
  }
}
