import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/services/maps_launcher_service.dart';
import '../../../../core/utils/size_util.dart';
import '../../../../injection_container.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/section_header.dart';
import '../../../../widgets/shimmer_box.dart';
import '../../../store_details/presentation/screens/store_details_screen.dart';
import '../../../stores/presentation/bloc/nearby_stores_bloc.dart';
import '../../../stores/presentation/widgets/store_horizontal_card.dart';
import '../bloc/home_bloc.dart';
import '../widgets/category_icon_tiles_row.dart';
import '../widgets/hero_promo_banner.dart';
import '../widgets/kutoot_app_bar.dart';
import '../widgets/kutoot_search_bar.dart';
import '../widgets/reward_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const KutootAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.failure) {
            return ErrorView(
              message: state.errorMessage ?? AppStrings.genericError,
              onRetry: () =>
                  context.read<HomeBloc>().add(const HomeLoadRequested()),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              context.read<HomeBloc>().add(const HomeLoadRequested());
              context
                  .read<NearbyStoresBloc>()
                  .add(const NearbyStoresRefreshRequested());
              await context
                  .read<HomeBloc>()
                  .stream
                  .firstWhere((s) => s.status != HomeStatus.loading);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const KutootSearchBar(
                    hint: AppStrings.searchHomeHint,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: state.banners.isEmpty
                      ? ShimmerBox(height: 170.h, radius: 18.r)
                      : HeroPromoBanner(banner: state.banners.first),
                ),
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'DISCOVER CATEGORIES',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                if (state.categories.isEmpty)
                  const _CategoryTilesShimmer()
                else
                  CategoryIconTilesRow(
                    categories: state.categories,
                    selectedCategoryId: state.selectedCategoryId,
                    onSelected: (id) {
                      context.read<HomeBloc>().add(HomeCategorySelected(id));
                      context
                          .read<NearbyStoresBloc>()
                          .add(NearbyStoresCategoryChanged(id));
                    },
                  ),
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SectionHeader(
                    title: AppStrings.nearbyStores,
                    trailingLabel: AppStrings.seeAll,
                    onTrailingTap: () {},
                  ),
                ),
                SizedBox(height: 12.h),
                const _NearbyStoresHorizontalRow(),
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SectionHeader(
                    title: AppStrings.weeklyRewards,
                    trailingLabel: AppStrings.viewAll,
                    onTrailingTap: () {},
                  ),
                ),
                SizedBox(height: 12.h),
                if (state.rewards.isEmpty)
                  const _RewardsShimmer()
                else
                  SizedBox(
                    height: 370.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      itemCount: state.rewards.length,
                      itemBuilder: (_, i) =>
                          RewardCard(reward: state.rewards[i]),
                    ),
                  ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NearbyStoresHorizontalRow extends StatelessWidget {
  const _NearbyStoresHorizontalRow();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyStoresBloc, NearbyStoresState>(
      builder: (context, state) {
        if (state.status == NearbyStoresStatus.initial ||
            (state.status == NearbyStoresStatus.loading &&
                state.stores.isEmpty)) {
          return const _StoresHorizontalShimmer();
        }

        if (state.status == NearbyStoresStatus.permissionDenied) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorView(
              icon: Icons.location_disabled,
              message: AppStrings.locationDenied,
              onRetry: () => context
                  .read<NearbyStoresBloc>()
                  .add(const NearbyStoresLoadRequested()),
            ),
          );
        }

        if (state.status == NearbyStoresStatus.locationDisabled) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorView(
              icon: Icons.location_off,
              message: AppStrings.locationDisabled,
              onRetry: () => context
                  .read<NearbyStoresBloc>()
                  .add(const NearbyStoresLoadRequested()),
            ),
          );
        }

        if (state.stores.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Text(
              'No stores found nearby',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        return SizedBox(
          height: 270.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: state.stores.length,
            itemBuilder: (_, index) {
              final store = state.stores[index];
              return StoreHorizontalCard(
                store: store,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StoreDetailsScreen(storeId: store.id),
                    ),
                  );
                },
                onPayBill: () {},
                onNavigate: () async {
                  final maps = sl<MapsLauncherService>();
                  await maps.launchDirections(
                    originLat: state.userLatitude ?? 0,
                    originLng: state.userLongitude ?? 0,
                    destinationLat: store.latitude,
                    destinationLng: store.longitude,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _CategoryTilesShimmer extends StatelessWidget {
  const _CategoryTilesShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(right: 14.w),
          child: Column(
            children: [
              ShimmerBox(width: 60.w, height: 60.h, radius: 16.r),
              SizedBox(height: 8.h),
              ShimmerBox(width: 50.w, height: 10.h, radius: 4.r),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoresHorizontalShimmer extends StatelessWidget {
  const _StoresHorizontalShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: ShimmerBox(width: 170.w, radius: 16.r),
        ),
      ),
    );
  }
}

class _RewardsShimmer extends StatelessWidget {
  const _RewardsShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 3,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.only(right: 14.w),
          child: ShimmerBox(width: 240.w, radius: 18.r),
        ),
      ),
    );
  }
}
