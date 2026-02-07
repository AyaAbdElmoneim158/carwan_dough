import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';

abstract class CartServices {
  Future<List<CartItemModel>> fetchCartItems([String? itemId]);
  Stream<List<CartItemModel>> fetchCartItemsAsStream();
  Future<void> clearCart();

  Future<void> removeCart(String cartItemId);
  Future<void> updateCartItem({
    required String cartItemId,
    required CartItemModel cartItem,
  });
  Future<void> setCart(CartItemModel cartItem);
}

class CartServicesImpl implements CartServices {
  final String? uid;
  CartServicesImpl(this.uid);
  final FirestoreHelper firestoreHelper = FirestoreHelper.instance;

  @override
  Future<List<CartItemModel>> fetchCartItems([String? productId]) async {
    if (productId != null) {
      return await firestoreHelper.getCollection(
        path: ApiPath.cart(uid!),
        builder: (data, documentId) => CartItemModel.fromMap(data),
        queryBuilder: (query) => query.where('productId', isEqualTo: productId),
      );
    } // Fetch by specific productId
    else {
      return await firestoreHelper.getCollection(
        path: ApiPath.cart(uid!),
        builder: (data, documentId) => CartItemModel.fromMap(data),
      );
    } // Fetch all cart items
  }

  @override
  Stream<List<CartItemModel>> fetchCartItemsAsStream() {
    return firestoreHelper.collectionsStream(
      path: ApiPath.cart(uid!),
      builder: (data, documentId) => CartItemModel.fromMap(data!),
    );
  }

  @override
  Future<void> clearCart() async {
    await firestoreHelper.clearCollection(path: ApiPath.cart(uid!));
  }

  @override
  Future<void> removeCart(String cartItemId) async {
    await firestoreHelper.deleteData(
      path: ApiPath.cartWithId(uid!, cartItemId),
    );
  }

  @override
  Future<void> updateCartItem({
    required String cartItemId,
    required CartItemModel cartItem,
  }) async {
    await firestoreHelper.setData(
      path: ApiPath.cartWithId(uid!, cartItemId),
      data: cartItem.toMap(),
    );
  }

  @override
  Future<void> setCart(CartItemModel cartItem) async {
    await firestoreHelper.setData(
      path: ApiPath.cartWithId(uid!, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
