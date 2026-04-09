part of 'store_details_bloc.dart';

abstract class StoreDetailsEvent extends Equatable {
  const StoreDetailsEvent();

  @override
  List<Object?> get props => [];
}

class StoreDetailsLoadRequested extends StoreDetailsEvent {
  final String storeId;
  const StoreDetailsLoadRequested(this.storeId);

  @override
  List<Object?> get props => [storeId];
}
