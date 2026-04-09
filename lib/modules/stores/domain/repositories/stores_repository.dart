import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/store.dart';

abstract class StoresRepository {
  Future<Either<Failure, List<Store>>> getNearbyStores({
    required double latitude,
    required double longitude,
    String categoryId = 'all',
    int page = 1,
    int pageSize = 10,
  });
}
