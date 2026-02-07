// ignore_for_file: depend_on_referenced_packages

import 'package:carwan_dough/models/order_model.dart';
import 'package:carwan_dough/services/order_services.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderServices) : super(OrderInitial());
  final OrderServices orderServices;

  /// Fetch orders (one-time)
  Future<void> fetchOrders() async {
    emit(OrderFetchLoading());
    try {
      final orders = await orderServices.fetchOrders().first;
      emit(OrderFetched(orders));
    } catch (error) {
      emit(OrderFetchedError(parseError(error)));
    }
  }

  /// Fetch orders as stream (for realtime UI)
  Stream<List<OrderModel>> fetchOrdersAsStream() {
    return orderServices.fetchOrders();
  }

  /// Add new order
  Future<void> addOrder(OrderModel order) async {
    emit(OrderAddLoading());
    try {
      await orderServices.addOrder(order);
      emit(OrderAdded());
    } catch (error) {
      emit(OrderAddFailure(parseError(error)));
    }
  }

  Future<void> cancelOrder(OrderModel order) async {
    emit(OrderCancelLoading());
    try {
      await orderServices.cancelOrder(order);
      emit(OrderCanceled());
    } catch (error) {
      emit(OrderCancelFailure(parseError(error)));
    }
  }
}
