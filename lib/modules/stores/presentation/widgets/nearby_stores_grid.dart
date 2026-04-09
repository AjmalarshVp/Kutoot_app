import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/services/maps_launcher_service.dart';
import '../../../../core/utils/size_util.dart';
import '../../../../injection_container.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/shimmer_box.dart';
import '../../../store_details/presentation/screens/store_details_screen.dart';
import '../bloc/nearby_stores_bloc.dart';
import 'store_card.dart';

class NearbyStoresGrid extends StatelessWidget {
  const NearbyStoresGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyStoresBloc, NearbyStoresState>(
      builder: (context, state) {
        if (state.status == NearbyStoresStatus.initial ||
            (state.status == NearbyStoresStatus.loading &&
                state.stores.isEmpty)) {
          return const _GridShimmer();
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

        if (state.status == NearbyStoresStatus.failure &&
            state.stores.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorView(
              message: state.errorMessage ?? AppStrings.genericError,
              onRetry: () => context
                  .read<NearbyStoresBloc>()
                  .add(const NearbyStoresLoadRequested()),
            ),
          );
        }

        if (state.stores.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(24.w),
            child: const Center(
              child: Text(
                'No stores match your filters',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          );
        }

        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.h,
                crossAxisSpacing: 14.w,
                childAspectRatio: 0.69,
              ),
              itemCount: state.stores.length,
              itemBuilder: (_, index) {
                final store = state.stores[index];
                return StoreCard(
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
            if (state.hasMore) ...[
              SizedBox(height: 12.h),
              TextButton(
                onPressed: state.isLoadingMore
                    ? null
                    : () => context
                        .read<NearbyStoresBloc>()
                        .add(const NearbyStoresLoadMoreRequested()),
                child: state.isLoadingMore
                    ? SizedBox(
                        width: 18.w,
                        height: 18.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : Text(
                        'Load more',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _GridShimmer extends StatelessWidget {
  const _GridShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14.h,
        crossAxisSpacing: 14.w,
        childAspectRatio: 0.66,
      ),
      itemCount: 4,
      itemBuilder: (_, __) => ShimmerBox(radius: 16.r),
    );
  }
}
