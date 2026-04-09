import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_theme.dart';
import 'core/services/location_service.dart';
import 'core/utils/size_util.dart';
import 'injection_container.dart';
import 'modules/home/domain/repositories/home_repository.dart';
import 'modules/home/presentation/bloc/home_bloc.dart';
import 'modules/main/presentation/cubit/nav_cubit.dart';
import 'modules/main/presentation/screens/main_screen.dart';
import 'modules/stores/domain/repositories/stores_repository.dart';
import 'modules/stores/presentation/bloc/nearby_stores_bloc.dart';

class KutootApp extends StatelessWidget {
  const KutootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavCubit()),
        BlocProvider(
          create: (_) => HomeBloc(repository: sl<HomeRepository>())
            ..add(const HomeLoadRequested()),
        ),
        BlocProvider(
          create: (_) => NearbyStoresBloc(
            repository: sl<StoresRepository>(),
            locationService: sl<LocationService>(),
          )..add(const NearbyStoresLoadRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'Kutoot',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        builder: (context, child) {
          SizeUtil.init(context);
          return child ?? const SizedBox.shrink();
        },
        home: const MainScreen(),
      ),
    );
  }
}
