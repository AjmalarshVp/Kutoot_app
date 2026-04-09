import '../../domain/entities/store.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.rating,
    required super.latitude,
    required super.longitude,
    required super.distanceKm,
    required super.offerLabel,
    required super.categoryId,
    required super.address,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      offerLabel: json['offer_label'] as String,
      categoryId: json['category_id'] as String,
      address: json['address'] as String,
    );
  }
}
