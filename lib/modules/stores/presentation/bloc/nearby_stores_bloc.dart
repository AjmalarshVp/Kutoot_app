import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart' as app_ex;
import '../../../../core/services/location_service.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/stores_repository.dart';

part 'nearby_stores_event.dart';
part 'nearby_stores_state.dart';

class NearbyStoresBloc extends Bloc<NearbyStoresEvent, NearbyStoresState> {
  final StoresRepository repository;
  final LocationService locationService;

  static const _pageSize = 6;

  NearbyStoresBloc({
    required this.repository,
    required this.locationService,
  }) : super(const NearbyStoresState()) {
    on<NearbyStoresLoadRequested>(_onLoadRequested);
    on<NearbyStoresRefreshRequested>(_onRefreshRequested);
    on<NearbyStoresCategoryChanged>(_onCategoryChanged);
    on<NearbyStoresLoadMoreRequested>(_onLoadMoreRequested);
  }

  Future<void> _onLoadRequested(
    NearbyStoresLoadRequested event,
    Emitter<NearbyStoresState> emit,
  ) async {
    await _fetch(emit, page: 1, replace: true);
  }

  Future<void> _onRefreshRequested(
    NearbyStoresRefreshRequested event,
    Emitter<NearbyStoresState> emit,
  ) async {
    await _fetch(emit, page: 1, replace: true);
  }

  Future<void> _onCategoryChanged(
    NearbyStoresCategoryChanged event,
    Emitter<NearbyStoresState> emit,
  ) async {
    emit(state.copyWith(categoryId: event.categoryId));
    await _fetch(emit, page: 1, replace: true);
  }

  Future<void> _onLoadMoreRequested(
    NearbyStoresLoadMoreRequested event,
    Emitter<NearbyStoresState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;
    await _fetch(emit, page: state.page + 1, replace: false);
  }

  Future<void> _fetch(
    Emitter<NearbyStoresState> emit, {
    required int page,
    required bool replace,
  }) async {
    if (replace) {
      emit(state.copyWith(status: NearbyStoresStatus.loading));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    try {
      final loc = await locationService.getCurrentLocation();
      final result = await repository.getNearbyStores(
        latitude: loc.latitude,
        longitude: loc.longitude,
        categoryId: state.categoryId,
        page: page,
        pageSize: _pageSize,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          status: NearbyStoresStatus.failure,
          isLoadingMore: false,
          errorMessage: failure.message,
        )),
        (stores) {
          final merged = replace ? stores : [...state.stores, ...stores];
          emit(state.copyWith(
            status: NearbyStoresStatus.success,
            stores: merged,
            page: page,
            hasMore: stores.length == _pageSize,
            userLatitude: loc.latitude,
            userLongitude: loc.longitude,
            userCity: loc.city,
            isLoadingMore: false,
            clearError: true,
          ));
        },
      );
    } on app_ex.LocationPermissionException catch (e) {
      emit(state.copyWith(
        status: NearbyStoresStatus.permissionDenied,
        isLoadingMore: false,
        errorMessage: e.message,
      ));
    } on app_ex.LocationDisabledException catch (e) {
      emit(state.copyWith(
        status: NearbyStoresStatus.locationDisabled,
        isLoadingMore: false,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NearbyStoresStatus.failure,
        isLoadingMore: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
