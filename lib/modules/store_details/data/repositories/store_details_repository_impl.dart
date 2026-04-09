import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/entities/store_details.dart';
import '../../domain/repositories/store_details_repository.dart';
import '../datasources/store_details_remote_datasource.dart';

class StoreDetailsRepositoryImpl implements StoreDetailsRepository {
  final StoreDetailsRemoteDataSource remote;

  StoreDetailsRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails({
    required String storeId,
    required double userLatitude,
    required double userLongitude,
  }) async {
    try {
      final model = await remote.fetchStoreDetails(storeId);
      final distance = GeolocatorLocationService.distanceKm(
        fromLat: userLatitude,
        fromLng: userLongitude,
        toLat: model.latitude,
        toLng: model.longitude,
      );
      return Right(StoreDetails(
        id: model.id,
        name: model.name,
        address: model.address,
        distanceKm: distance,
        gallery: model.gallery,
        contactNumber: model.contactNumber,
        openingHours: model.openingHours,
        offers: model.offers,
        services: model.services,
        rating: model.rating,
        ratingCount: model.ratingCount,
        latitude: model.latitude,
        longitude: model.longitude,
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
