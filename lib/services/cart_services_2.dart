import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';

abstract class CartServices2 {
  Future<List<CartItemModel>> fetchCartItems([String? itemId]);
  Stream<List<CartItemModel>> fetchCartItemsAsStream();
  Future<void> setCart(CartItemModel cartItem);
  Future<void> removeCart(String cartItemId);
  Future<void> clearCart();
  Future<void> updateCartItemQuantity({required String cartItemId, required int newQuantity});
  Future<void> deleteCartItem(String cartItemId);
  Future<void> updateCartItem({
    required String cartItemId,
    required CartItemModel cartItem,
  });
}

class CartServices2Impl implements CartServices2 {
  final String? uid;
  CartServices2Impl(this.uid);
  final FirestoreHelper firestoreHelper = FirestoreHelper.instance;

  @override
  Future<void> setCart(CartItemModel cartItem) async {
    await firestoreHelper.setData(
      path: ApiPath.cartWithId(uid!, cartItem.id),
      data: cartItem.toMap(),
    );
  }

  @override
  Future<void> clearCart() async {
    await firestoreHelper.clearCollection(path: ApiPath.cart(uid!));
  }

  @override
  Future<List<CartItemModel>> fetchCartItems([String? productId]) async {
    if (productId != null) {
      // Fetch by specific productId
      return await firestoreHelper.getCollection(
        path: ApiPath.cart(uid!),
        builder: (data, documentId) => CartItemModel.fromMap(data),
        queryBuilder: (query) => query.where('productId', isEqualTo: productId),
      );
    } else {
      // Fetch all cart items
      return await firestoreHelper.getCollection(
        path: ApiPath.cart(uid!),
        builder: (data, documentId) => CartItemModel.fromMap(data),
      );
    }
  }

  @override
  Future<void> removeCart(String cartItemId) async {
    await firestoreHelper.deleteData(
      path: ApiPath.cartWithId(uid!, cartItemId),
    );
  }

  @override
  Future<void> updateCartItemQuantity({required String cartItemId, required int newQuantity}) async {
    await firestoreHelper.setDataWithMerge(
      path: ApiPath.cartWithId(uid!, cartItemId),
      data: {'quantity': newQuantity},
    );
  }

  @override
  Stream<List<CartItemModel>> fetchCartItemsAsStream() {
    return firestoreHelper.collectionsStream(
      path: ApiPath.cart(uid!),
      builder: (data, documentId) => CartItemModel.fromMap(data!),
    );
  }

  @override
  Future<void> deleteCartItem(String cartItemId) async {
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
}
