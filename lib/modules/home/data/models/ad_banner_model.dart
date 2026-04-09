import '../../domain/entities/ad_banner.dart';

class AdBannerModel extends AdBanner {
  const AdBannerModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.imageUrl,
    super.ctaLabel,
  });

  factory AdBannerModel.fromJson(Map<String, dynamic> json) {
    return AdBannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      imageUrl: json['image_url'] as String,
      ctaLabel: json['cta_label'] as String?,
    );
  }
}
