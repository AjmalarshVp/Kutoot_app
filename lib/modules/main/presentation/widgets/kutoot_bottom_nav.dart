import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';
import '../cubit/nav_cubit.dart';

class KutootBottomNav extends StatelessWidget {
  final NavTab current;
  final ValueChanged<NavTab> onTap;

  const KutootBottomNav({
    super.key,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: 'HOME',
                selected: current == NavTab.home,
                onTap: () => onTap(NavTab.home),
              ),
              _NavItem(
                icon: Icons.local_offer,
                label: 'REWARDS',
                selected: current == NavTab.rewards,
                onTap: () => onTap(NavTab.rewards),
              ),
              _NavItem(
                icon: Icons.storefront,
                label: 'STORES',
                selected: current == NavTab.stores,
                onTap: () => onTap(NavTab.stores),
              ),
              _NavItem(
                icon: Icons.bookmark_border,
                label: 'PLANS',
                selected: current == NavTab.plans,
                onTap: () => onTap(NavTab.plans),
              ),
              _NavItem(
                icon: Icons.person_outline,
                label: 'ACCOUNT',
                selected: current == NavTab.account,
                onTap: () => onTap(NavTab.account),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.orange : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22.r),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
