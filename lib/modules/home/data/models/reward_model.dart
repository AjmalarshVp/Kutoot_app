import '../../domain/entities/reward.dart';

class RewardModel extends Reward {
  const RewardModel({
    required super.id,
    required super.title,
    required super.totalValueLabel,
    required super.imageUrl,
    required super.progress,
    required super.tag,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      totalValueLabel: json['total_value_label'] as String,
      imageUrl: json['image_url'] as String,
      progress: (json['progress'] as num).toDouble(),
      tag: (json['tag'] as String) == 'primary'
          ? RewardTag.primary
          : RewardTag.eligible,
    );
  }
}
