import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/store_details.dart';

abstract class StoreDetailsRepository {
  Future<Either<Failure, StoreDetails>> getStoreDetails({
    required String storeId,
    required double userLatitude,
    required double userLongitude,
  });
}
