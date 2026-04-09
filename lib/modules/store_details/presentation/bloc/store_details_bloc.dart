import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/location_service.dart';
import '../../domain/entities/store_details.dart';
import '../../domain/repositories/store_details_repository.dart';

part 'store_details_event.dart';
part 'store_details_state.dart';

class StoreDetailsBloc extends Bloc<StoreDetailsEvent, StoreDetailsState> {
  final StoreDetailsRepository repository;
  final LocationService locationService;

  StoreDetailsBloc({
    required this.repository,
    required this.locationService,
  }) : super(const StoreDetailsState()) {
    on<StoreDetailsLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    StoreDetailsLoadRequested event,
    Emitter<StoreDetailsState> emit,
  ) async {
    emit(state.copyWith(status: StoreDetailsStatus.loading));
    try {
      final loc = await locationService.getCurrentLocation();
      final result = await repository.getStoreDetails(
        storeId: event.storeId,
        userLatitude: loc.latitude,
        userLongitude: loc.longitude,
      );
      result.fold(
        (failure) => emit(state.copyWith(
          status: StoreDetailsStatus.failure,
          errorMessage: failure.message,
        )),
        (details) => emit(state.copyWith(
          status: StoreDetailsStatus.success,
          details: details,
          userLatitude: loc.latitude,
          userLongitude: loc.longitude,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        status: StoreDetailsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
