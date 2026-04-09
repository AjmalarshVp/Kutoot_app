part of 'nearby_stores_bloc.dart';

enum NearbyStoresStatus {
  initial,
  loading,
  success,
  failure,
  permissionDenied,
  locationDisabled,
}

class NearbyStoresState extends Equatable {
  final NearbyStoresStatus status;
  final List<Store> stores;
  final String categoryId;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final double? userLatitude;
  final double? userLongitude;
  final String? userCity;
  final String? errorMessage;

  const NearbyStoresState({
    this.status = NearbyStoresStatus.initial,
    this.stores = const [],
    this.categoryId = 'all',
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.userLatitude,
    this.userLongitude,
    this.userCity,
    this.errorMessage,
  });

  NearbyStoresState copyWith({
    NearbyStoresStatus? status,
    List<Store>? stores,
    String? categoryId,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    double? userLatitude,
    double? userLongitude,
    String? userCity,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NearbyStoresState(
      status: status ?? this.status,
      stores: stores ?? this.stores,
      categoryId: categoryId ?? this.categoryId,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      userCity: userCity ?? this.userCity,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        stores,
        categoryId,
        page,
        hasMore,
        isLoadingMore,
        userLatitude,
        userLongitude,
        userCity,
        errorMessage,
      ];
}
