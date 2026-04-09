import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';
import '../../domain/entities/store.dart';

class StoreHorizontalCard extends StatelessWidget {
  final Store store;
  final VoidCallback onTap;
  final VoidCallback onNavigate;
  final VoidCallback? onPayBill;

  const StoreHorizontalCard({
    super.key,
    required this.store,
    required this.onTap,
    required this.onNavigate,
    this.onPayBill,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180.w,
        margin: EdgeInsets.only(right: 14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: store.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.chipBg),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.chipBg,
                  child: const Icon(Icons.store, color: AppColors.textHint),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black,
                    ],
                    stops: [0, 0.35, 0.7, 1],
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                left: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    store.offerLabel,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      store.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star, size: 13.r, color: AppColors.accent),
                        SizedBox(width: 3.w),
                        Text(
                          store.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.near_me,
                            size: 11.r, color: Colors.white70),
                        SizedBox(width: 3.w),
                        Text(
                          '${store.distanceKm.toStringAsFixed(1)} km',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onPayBill,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.primary,
                              disabledForegroundColor: AppColors.white,
                              disabledBackgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            child: const Text(AppStrings.payBill),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        GestureDetector(
                          onTap: onNavigate,
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(Icons.near_me,
                                size: 16.r, color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
