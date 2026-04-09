import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String iconKey;
  final int colorValue;

  const Category({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.colorValue,
  });

  @override
  List<Object?> get props => [id, name];
}
