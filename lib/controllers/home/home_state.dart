part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchingMenuLoading extends HomeState {}

final class MenuFetched extends HomeState {
  final List<MenuModel>? menu;
  MenuFetched(this.menu);
}

final class FetchingMenuFailure extends HomeState {
  final String error;
  FetchingMenuFailure(this.error);
}
