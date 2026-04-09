part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Category> categories;
  final List<AdBanner> banners;
  final List<Reward> rewards;
  final String selectedCategoryId;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.banners = const [],
    this.rewards = const [],
    this.selectedCategoryId = 'all',
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Category>? categories,
    List<AdBanner>? banners,
    List<Reward>? rewards,
    String? selectedCategoryId,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      banners: banners ?? this.banners,
      rewards: rewards ?? this.rewards,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        banners,
        rewards,
        selectedCategoryId,
        errorMessage,
      ];
}
