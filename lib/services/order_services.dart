import 'package:carwan_dough/models/order_model.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';

abstract class OrderServices {
  Stream<List<OrderModel>> fetchOrders();
  Future<void> addOrder(OrderModel order);
  Future<void> cancelOrder(OrderModel order);
}

class OrderServicesImpl implements OrderServices {
  final String? uid;
  OrderServicesImpl(this.uid);

  final FirestoreHelper firestoreHelper = FirestoreHelper.instance;

  @override
  Stream<List<OrderModel>> fetchOrders() {
    return firestoreHelper.collectionsStream(
      path: "Orders/", // ApiPath.cart(uid!),
      builder: (data, documentId) => OrderModel.fromMap(data!),
    );
  }

  @override
  Future<void> addOrder(OrderModel order) async {
    await firestoreHelper.setData(
      path: "Orders/${order.id}", //  ApiPath.cartWithId(uid!, cartItem.id),
      data: order.toMap(),
    );
  }

  @override
  Future<void> cancelOrder(OrderModel order) async {
    await firestoreHelper.setDataWithMerge(
      path: "Orders/${order.id}", //  ApiPath.cartWithId(uid!, cartItem.id),
      data: order.copyWith(status: "canceled").toMap(),
    );
  }
}
