// ignore_for_file: depend_on_referenced_packages

import 'package:carwan_dough/services/home_services.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  HomeServices homeServices = HomeServicesImpl();

  Future<void> fetchMenu() async {
    emit(HomeLoading());
    try {
      final menu = await homeServices.fetchMenu();
      emit(HomeLoaded(menu));
    } catch (error) {
      emit(HomeError(parseError(error)));
    }
  }
}
