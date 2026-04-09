part of 'store_details_bloc.dart';

enum StoreDetailsStatus { initial, loading, success, failure }

class StoreDetailsState extends Equatable {
  final StoreDetailsStatus status;
  final StoreDetails? details;
  final double? userLatitude;
  final double? userLongitude;
  final String? errorMessage;

  const StoreDetailsState({
    this.status = StoreDetailsStatus.initial,
    this.details,
    this.userLatitude,
    this.userLongitude,
    this.errorMessage,
  });

  StoreDetailsState copyWith({
    StoreDetailsStatus? status,
    StoreDetails? details,
    double? userLatitude,
    double? userLongitude,
    String? errorMessage,
  }) {
    return StoreDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, details, userLatitude, userLongitude, errorMessage];
}
