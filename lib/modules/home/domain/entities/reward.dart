import 'package:equatable/equatable.dart';

enum RewardTag { primary, eligible }

class Reward extends Equatable {
  final String id;
  final String title;
  final String totalValueLabel;
  final String imageUrl;
  final double progress;
  final RewardTag tag;

  const Reward({
    required this.id,
    required this.title,
    required this.totalValueLabel,
    required this.imageUrl,
    required this.progress,
    required this.tag,
  });

  @override
  List<Object?> get props => [id, title];
}
