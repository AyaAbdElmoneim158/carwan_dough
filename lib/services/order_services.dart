import 'package:carwan_dough/models/order_model.dart';

abstract class OrderServices {
  Stream<List<OrderModel>> fetchOrders();
}

class OrderServicesImpl implements OrderServices {
  @override
  Stream<List<OrderModel>> fetchOrders() {
    //Todo: Stream not future for realTime
    throw UnimplementedError();
  }
}
