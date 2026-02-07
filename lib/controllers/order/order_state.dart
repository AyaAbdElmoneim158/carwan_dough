part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

/// Fetch orders
class OrderFetchLoading extends OrderState {}

class OrderFetched extends OrderState {
  final List<OrderModel> orders;
  OrderFetched(this.orders);
}

class OrderFetchedError extends OrderState {
  final String message;
  OrderFetchedError(this.message);
}

/// Add order
class OrderAddLoading extends OrderState {}

class OrderAdded extends OrderState {}

class OrderAddFailure extends OrderState {
  final String message;
  OrderAddFailure(this.message);
}

/// Cancel order
class OrderCancelLoading extends OrderState {}

class OrderCanceled extends OrderState {}

class OrderCancelFailure extends OrderState {
  final String message;
  OrderCancelFailure(this.message);
}
