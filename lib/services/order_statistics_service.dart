import '../models/order_model.dart';

class OrderStatistics {
  final List<OrderModel> orders;

  OrderStatistics(this.orders);

  /// ✅ Total orders
  int get totalOrders => orders.length;

  /// ✅ Total revenue
  double get totalRevenue => orders.fold(0.0, (sum, order) => sum + order.total);

  /// ✅ Orders by status
  Map<String, int> get ordersByStatus {
    final Map<String, int> map = {};
    for (final order in orders) {
      map[order.status] = (map[order.status] ?? 0) + 1;
    }
    return map;
  }

  /// ✅ Orders per day
  Map<String, int> get ordersPerDay {
    final Map<String, int> map = {};
    for (final order in orders) {
      final date = order.deliveryDate.split(' ').first;
      map[date] = (map[date] ?? 0) + 1;
    }
    return map;
  }
}
