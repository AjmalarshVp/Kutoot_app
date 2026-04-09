import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/maps_launcher_service.dart';
import '../../../../core/utils/size_util.dart';
import '../../../../injection_container.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/shimmer_box.dart';
import '../../domain/repositories/store_details_repository.dart';
import '../bloc/store_details_bloc.dart';

class StoreDetailsScreen extends StatelessWidget {
  final String storeId;
  const StoreDetailsScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoreDetailsBloc(
        repository: sl<StoreDetailsRepository>(),
        locationService: sl<LocationService>(),
      )..add(StoreDetailsLoadRequested(storeId)),
      child: _StoreDetailsView(storeId: storeId),
    );
  }
}

class _StoreDetailsView extends StatelessWidget {
  final String storeId;
  const _StoreDetailsView({required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
        builder: (context, state) {
          if (state.status == StoreDetailsStatus.loading ||
              state.status == StoreDetailsStatus.initial) {
            return const _DetailsShimmer();
          }

          if (state.status == StoreDetailsStatus.failure ||
              state.details == null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.white,
                iconTheme: const IconThemeData(color: AppColors.textPrimary),
              ),
              body: ErrorView(
                message: state.errorMessage ?? AppStrings.genericError,
                onRetry: () => context
                    .read<StoreDetailsBloc>()
                    .add(StoreDetailsLoadRequested(storeId)),
              ),
            );
          }

          final d = state.details!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 240.h,
                pinned: true,
                backgroundColor: AppColors.white,
                iconTheme: const IconThemeData(color: AppColors.white),
                flexibleSpace: FlexibleSpaceBar(
                  background: _GalleryHeader(images: d.gallery),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              d.name,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star,
                                    size: 14.r, color: AppColors.white),
                                SizedBox(width: 4.w),
                                Text(
                                  '${d.rating} (${d.ratingCount})',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16.r, color: AppColors.primary),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              d.address,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.near_me,
                              size: 14.r, color: AppColors.textSecondary),
                          SizedBox(width: 4.w),
                          Text(
                            '${d.distanceKm.toStringAsFixed(1)} km from you',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Icon(Icons.access_time,
                              size: 14.r, color: AppColors.textSecondary),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              d.openingHours,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      const _SectionTitle('Offers'),
                      SizedBox(height: 6.h),
                      ...d.offers.map(_BulletLine.new),
                      SizedBox(height: 18.h),
                      const _SectionTitle('Services'),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: d.services
                            .map((s) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.chipBg,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 18.h),
                      const _SectionTitle('Contact'),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.phone,
                              size: 16.r, color: AppColors.primary),
                          SizedBox(width: 6.w),
                          Text(
                            d.contactNumber,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      const _SectionTitle('Location'),
                      SizedBox(height: 8.h),
                      _MiniMapPreview(
                        latitude: d.latitude,
                        longitude: d.longitude,
                        name: d.name,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.navigation, size: 18.r),
                          label: const Text(AppStrings.navigateNow),
                          onPressed: () async {
                            final maps = sl<MapsLauncherService>();
                            await maps.launchDirections(
                              originLat: state.userLatitude ?? 0,
                              originLng: state.userLongitude ?? 0,
                              destinationLat: d.latitude,
                              destinationLng: d.longitude,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GalleryHeader extends StatefulWidget {
  final List<String> images;
  const _GalleryHeader({required this.images});

  @override
  State<_GalleryHeader> createState() => _GalleryHeaderState();
}

class _GalleryHeaderState extends State<_GalleryHeader> {
  final _controller = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) => CachedNetworkImage(
            imageUrl: widget.images[i],
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: AppColors.chipBg),
            errorWidget: (_, __, ___) => Container(color: AppColors.chipBg),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.transparent, Colors.black26],
              stops: [0, 0.4, 1],
            ),
          ),
        ),
        Positioned(
          bottom: 12.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.images.length, (i) {
              final selected = i == _index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: selected ? 16.w : 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: selected ? AppColors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String label;
  const _SectionTitle(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;
  const _BulletLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Icon(Icons.circle, size: 6.r, color: AppColors.primary),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMapPreview extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String name;

  const _MiniMapPreview({
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final maps = sl<MapsLauncherService>();
        await maps.launchDirections(
          originLat: latitude,
          originLng: longitude,
          destinationLat: latitude,
          destinationLng: longitude,
        );
      },
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
          color: const Color(0xFFE9F2EC),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _MapGridPainter()),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,
                      size: 36.r, color: AppColors.primary),
                  SizedBox(height: 4.h),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: Chip(
                label: Text(
                  'Tap to open',
                  style: TextStyle(fontSize: 10.sp, color: AppColors.white),
                ),
                backgroundColor: AppColors.primary,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 0.5;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DetailsShimmer extends StatelessWidget {
  const _DetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(height: 200.h, radius: 16.r),
          SizedBox(height: 16.h),
          ShimmerBox(height: 22.h, width: 220.w),
          SizedBox(height: 8.h),
          ShimmerBox(height: 14.h, width: 280.w),
          SizedBox(height: 24.h),
          ShimmerBox(height: 14.h),
          SizedBox(height: 8.h),
          ShimmerBox(height: 14.h),
          SizedBox(height: 8.h),
          ShimmerBox(height: 14.h, width: 200.w),
        ],
      ),
    );
  }
}
