import 'package:equatable/equatable.dart';

class StoreDetails extends Equatable {
  final String id;
  final String name;
  final String address;
  final double distanceKm;
  final List<String> gallery;
  final String contactNumber;
  final String openingHours;
  final List<String> offers;
  final List<String> services;
  final double rating;
  final int ratingCount;
  final double latitude;
  final double longitude;

  const StoreDetails({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.gallery,
    required this.contactNumber,
    required this.openingHours,
    required this.offers,
    required this.services,
    required this.rating,
    required this.ratingCount,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, distanceKm];
}
