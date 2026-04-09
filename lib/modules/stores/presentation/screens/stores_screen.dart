import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/widgets/category_chips_row.dart';
import '../../../home/presentation/widgets/kutoot_app_bar.dart';
import '../../../home/presentation/widgets/kutoot_search_bar.dart';
import '../bloc/nearby_stores_bloc.dart';
import '../widgets/nearby_stores_grid.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const KutootAppBar(),
      body: BlocBuilder<NearbyStoresBloc, NearbyStoresState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              context
                  .read<NearbyStoresBloc>()
                  .add(const NearbyStoresRefreshRequested());
              await context
                  .read<NearbyStoresBloc>()
                  .stream
                  .firstWhere((s) => s.status != NearbyStoresStatus.loading);
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
                SizedBox(height: 14.h),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) {
                    if (homeState.categories.isEmpty) {
                      return SizedBox(height: 38.h);
                    }
                    return CategoryChipsRow(
                      categories: homeState.categories,
                      selectedCategoryId: state.categoryId,
                      onSelected: (id) => context
                          .read<NearbyStoresBloc>()
                          .add(NearbyStoresCategoryChanged(id)),
                    );
                  },
                ),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.nearbyStores,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${state.stores.length.toString().padLeft(2, '0')} STORES FOUND',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                const NearbyStoresGrid(),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
