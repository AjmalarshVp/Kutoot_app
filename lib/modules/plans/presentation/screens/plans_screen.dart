import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../home/presentation/widgets/kutoot_app_bar.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const KutootAppBar(),
      body: const Center(
        child: Text(
          'Plans',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
