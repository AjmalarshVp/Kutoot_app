part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

class HomeCategorySelected extends HomeEvent {
  final String categoryId;
  const HomeCategorySelected(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
