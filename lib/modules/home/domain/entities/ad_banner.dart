import 'package:equatable/equatable.dart';

class AdBanner extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? ctaLabel;

  const AdBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.ctaLabel,
  });

  @override
  List<Object?> get props => [id, title];
}
