import 'package:get_it/get_it.dart';

import 'core/network/mock_api_client.dart';
import 'core/services/location_service.dart';
import 'core/services/maps_launcher_service.dart';
import 'modules/home/data/datasources/home_remote_datasource.dart';
import 'modules/home/data/repositories/home_repository_impl.dart';
import 'modules/home/domain/repositories/home_repository.dart';
import 'modules/store_details/data/datasources/store_details_remote_datasource.dart';
import 'modules/store_details/data/repositories/store_details_repository_impl.dart';
import 'modules/store_details/domain/repositories/store_details_repository.dart';
import 'modules/stores/data/datasources/stores_remote_datasource.dart';
import 'modules/stores/data/repositories/stores_repository_impl.dart';
import 'modules/stores/domain/repositories/stores_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<MockApiClient>(() => MockApiClient());
  sl.registerLazySingleton<LocationService>(
      () => GeolocatorLocationService());
  sl.registerLazySingleton<MapsLauncherService>(
      () => GoogleMapsLauncherService());

  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remote: sl()));

  sl.registerLazySingleton<StoresRemoteDataSource>(
      () => StoresRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<StoresRepository>(
      () => StoresRepositoryImpl(remote: sl()));

  sl.registerLazySingleton<StoreDetailsRemoteDataSource>(
      () => StoreDetailsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<StoreDetailsRepository>(
      () => StoreDetailsRepositoryImpl(remote: sl()));
}
