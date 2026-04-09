import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final double latitude;
  final double longitude;
  final double distanceKm;
  final String offerLabel;
  final String categoryId;
  final String address;

  const Store({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
    required this.offerLabel,
    required this.categoryId,
    required this.address,
  });

  Store copyWith({double? distanceKm}) => Store(
        id: id,
        name: name,
        imageUrl: imageUrl,
        rating: rating,
        latitude: latitude,
        longitude: longitude,
        distanceKm: distanceKm ?? this.distanceKm,
        offerLabel: offerLabel,
        categoryId: categoryId,
        address: address,
      );

  @override
  List<Object?> get props => [id, name, distanceKm];
}
