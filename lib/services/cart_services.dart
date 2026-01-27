import 'package:carwan_dough/models/cart_model.dart';

abstract class CartServices {
  Future<List<CartModel>> fetchCart();
  Future<void> addCart(CartModel cartItem);
  Future<void> addCartQuantity(CartModel cartItem);
}

class CartServicesImpl implements CartServices {
  @override
  Future<List<CartModel>> fetchCart() {
    throw UnimplementedError();
  }

  @override
  Future<void> addCart(CartModel cartItem) {
    throw UnimplementedError();
  }

  @override
  Future<void> addCartQuantity(CartModel cartItem) {
    throw UnimplementedError();
  }
}
