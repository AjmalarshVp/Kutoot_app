import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class MapsLauncherService {
  Future<bool> launchDirections({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  });
}

class GoogleMapsLauncherService implements MapsLauncherService {
  @override
  Future<bool> launchDirections({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
      '&origin=$originLat,$originLng'
      '&destination=$destinationLat,$destinationLng'
      '&travelmode=driving',
    );

    try {
      return await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('launchUrl(google) failed: $e');
    }

    final geoUri = Uri.parse(
      'geo:$destinationLat,$destinationLng?q=$destinationLat,$destinationLng',
    );
    try {
      return await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('launchUrl(geo) failed: $e');
      return false;
    }
  }
}
