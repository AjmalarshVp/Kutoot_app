import 'package:flutter/material.dart';

import '../../../../config/constants/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';

class KutootAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  const KutootAppBar({super.key, this.location = 'MUMBAI'});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 64.h,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,
                      size: 16.r, color: AppColors.accent),
                  SizedBox(width: 4.w),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      size: 16.r, color: AppColors.textPrimary),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'KU',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'TO',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'OT',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(AppStrings.upgrade),
            ),
          ],
        ),
      ),
    );
  }
}
