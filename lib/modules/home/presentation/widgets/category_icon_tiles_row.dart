import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/utils/size_util.dart';
import '../../domain/entities/category.dart';

IconData _iconForKey(String key) {
  switch (key) {
    case 'all':
      return Icons.apps_rounded;
    case 'fashion':
      return Icons.checkroom_rounded;
    case 'electronics':
      return Icons.devices_other_rounded;
    case 'home':
      return Icons.chair_rounded;
    case 'beauty':
      return Icons.brush_rounded;
    case 'grocery':
      return Icons.local_grocery_store_rounded;
    default:
      return Icons.category_rounded;
  }
}

class CategoryIconTilesRow extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onSelected;

  const CategoryIconTilesRow({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 14.w),
        itemBuilder: (_, index) {
          final c = categories[index];
          return _IconTile(
            label: c.name.toUpperCase(),
            icon: _iconForKey(c.iconKey),
            color: Color(c.colorValue),
            selected: c.id == selectedCategoryId,
            onTap: () => onSelected(c.id),
          );
        },
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _IconTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: selected
                  ? Border.all(color: AppColors.textPrimary, width: 2)
                  : null,
            ),
            child: Icon(icon, color: AppColors.white, size: 28.r),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
