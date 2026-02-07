// ignore_for_file: depend_on_referenced_packages

import 'package:carwan_dough/services/home_services.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwan_dough/models/menu_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeServices) : super(HomeInitial());
  final HomeServices homeServices;

  void safeEmit(HomeState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> fetchMenu() async {
    // Use safeEmit instead of emit
    safeEmit(FetchingMenuLoading());
    try {
      final menu = await homeServices.fetchMenu();
      safeEmit(MenuFetched(menu));
    } catch (error) {
      debugPrint("Error: $error");
      safeEmit(FetchingMenuFailure(parseError(error)));
    }
  }
}
