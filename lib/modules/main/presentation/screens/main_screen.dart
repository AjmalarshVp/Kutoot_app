import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/services/maps_launcher_service.dart';
import '../../../../injection_container.dart';
import '../../../account/presentation/screens/account_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../plans/presentation/screens/plans_screen.dart';
import '../../../rewards/presentation/screens/rewards_screen.dart';
import '../../../stores/presentation/bloc/nearby_stores_bloc.dart';
import '../../../stores/presentation/screens/stores_screen.dart';
import '../cubit/nav_cubit.dart';
import '../widgets/kutoot_bottom_nav.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavTab>(
      builder: (context, tab) {
        return Scaffold(
          backgroundColor: AppColors.scaffold,
          body: IndexedStack(
            index: tab.index,
            children: const [
              HomeScreen(),
              RewardsScreen(),
              StoresScreen(),
              PlansScreen(),
              AccountScreen(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primary,
            onPressed: () async {
              final stores = context.read<NearbyStoresBloc>().state;
              final maps = sl<MapsLauncherService>();
              await maps.launchDirections(
                originLat: stores.userLatitude ?? 19.0760,
                originLng: stores.userLongitude ?? 72.8777,
                destinationLat: stores.userLatitude ?? 19.0760,
                destinationLng: stores.userLongitude ?? 72.8777,
              );
            },
            child: const Icon(Icons.qr_code_scanner, color: AppColors.white),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: KutootBottomNav(
            current: tab,
            onTap: (t) => context.read<NavCubit>().select(t),
          ),
        );
      },
    );
  }
}
