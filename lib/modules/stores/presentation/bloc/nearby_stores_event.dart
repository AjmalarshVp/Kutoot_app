part of 'nearby_stores_bloc.dart';

abstract class NearbyStoresEvent extends Equatable {
  const NearbyStoresEvent();

  @override
  List<Object?> get props => [];
}

class NearbyStoresLoadRequested extends NearbyStoresEvent {
  const NearbyStoresLoadRequested();
}

class NearbyStoresRefreshRequested extends NearbyStoresEvent {
  const NearbyStoresRefreshRequested();
}

class NearbyStoresCategoryChanged extends NearbyStoresEvent {
  final String categoryId;
  const NearbyStoresCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class NearbyStoresLoadMoreRequested extends NearbyStoresEvent {
  const NearbyStoresLoadMoreRequested();
}
