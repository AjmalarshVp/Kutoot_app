import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/ad_banner.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/reward.dart';
import '../../domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(const HomeState()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<HomeCategorySelected>(_onCategorySelected);
  }

  Future<void> _onLoadRequested(
    HomeLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final results = await Future.wait([
      repository.getCategories(),
      repository.getAdBanners(),
      repository.getWeeklyRewards(),
    ]);

    final catsResult = results[0];
    final bannersResult = results[1];
    final rewardsResult = results[2];

    String? error;
    List<Category> categories = const [];
    List<AdBanner> banners = const [];
    List<Reward> rewards = const [];

    catsResult.fold(
      (f) => error = f.message,
      (data) => categories = data as List<Category>,
    );
    bannersResult.fold(
      (f) => error ??= f.message,
      (data) => banners = data as List<AdBanner>,
    );
    rewardsResult.fold(
      (f) => error ??= f.message,
      (data) => rewards = data as List<Reward>,
    );

    if (error != null && categories.isEmpty) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: error,
      ));
      return;
    }

    emit(state.copyWith(
      status: HomeStatus.success,
      categories: categories,
      banners: banners,
      rewards: rewards,
    ));
  }

  void _onCategorySelected(
    HomeCategorySelected event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedCategoryId: event.categoryId));
  }
}
