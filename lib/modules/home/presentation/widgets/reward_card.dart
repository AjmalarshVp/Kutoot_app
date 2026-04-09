import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';
import '../../domain/entities/reward.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    final isPrimary = reward.tag == RewardTag.primary;
    final tagLabel = isPrimary ? 'PRIMARY' : 'ELIGIBLE';
    final tagDot = isPrimary ? AppColors.primary : Colors.black87;

    return Container(
      width: 220.w,
      margin: EdgeInsets.only(right: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: reward.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.chipBg),
              errorWidget: (_, __, ___) => Container(color: AppColors.chipBg),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: tagDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      tagLabel,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14.w,
              right: 14.w,
              bottom: 14.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    reward.totalValueLabel,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _ProgressDashes(progress: reward.progress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressDashes extends StatelessWidget {
  final double progress;
  const _ProgressDashes({required this.progress});

  @override
  Widget build(BuildContext context) {
    const totalSegments = 12;
    final filled = (progress * totalSegments).round();
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(totalSegments, (i) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: i < filled
                        ? AppColors.white
                        : Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '${(progress * 100).round()}%',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
