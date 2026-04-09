class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network error']);
}

class LocationPermissionException implements Exception {
  final String message;
  LocationPermissionException([this.message = 'Location permission denied']);
}

class LocationDisabledException implements Exception {
  final String message;
  LocationDisabledException([this.message = 'Location services disabled']);
}
