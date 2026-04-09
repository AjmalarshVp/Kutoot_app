import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/location_service.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/stores_repository.dart';
import '../datasources/stores_remote_datasource.dart';

class StoresRepositoryImpl implements StoresRepository {
  final StoresRemoteDataSource remote;

  StoresRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, List<Store>>> getNearbyStores({
    required double latitude,
    required double longitude,
    String categoryId = 'all',
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final list = await remote.fetchNearbyStores(
        latitude: latitude,
        longitude: longitude,
        categoryId: categoryId,
        page: page,
        pageSize: pageSize,
      );

      final withDistance = list
          .map((s) => s.copyWith(
                distanceKm: GeolocatorLocationService.distanceKm(
                  fromLat: latitude,
                  fromLng: longitude,
                  toLat: s.latitude,
                  toLng: s.longitude,
                ),
              ))
          .toList()
        ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

      return Right(withDistance);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
