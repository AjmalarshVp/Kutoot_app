import 'package:flutter_bloc/flutter_bloc.dart';

enum NavTab { home, rewards, stores, plans, account }

class NavCubit extends Cubit<NavTab> {
  NavCubit() : super(NavTab.home);

  void select(NavTab tab) => emit(tab);
}
