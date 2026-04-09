import 'dart:math';

import '../errors/exceptions.dart';

class MockApiClient {
  final Random _rand = Random();

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    required T Function() body,
    Duration latency = const Duration(milliseconds: 500),
    double failureRate = 0.0,
  }) async {
    await Future.delayed(latency);
    if (_rand.nextDouble() < failureRate) {
      throw ServerException('Mock failure for $path');
    }
    return body();
  }
}
