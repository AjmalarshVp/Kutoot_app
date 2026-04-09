import '../../domain/entities/store_details.dart';

class StoreDetailsModel extends StoreDetails {
  const StoreDetailsModel({
    required super.id,
    required super.name,
    required super.address,
    required super.distanceKm,
    required super.gallery,
    required super.contactNumber,
    required super.openingHours,
    required super.offers,
    required super.services,
    required super.rating,
    required super.ratingCount,
    required super.latitude,
    required super.longitude,
  });

  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    return StoreDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0,
      gallery:
          (json['gallery'] as List<dynamic>).map((e) => e as String).toList(),
      contactNumber: json['contact_number'] as String,
      openingHours: json['opening_hours'] as String,
      offers:
          (json['offers'] as List<dynamic>).map((e) => e as String).toList(),
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      ratingCount: json['rating_count'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
