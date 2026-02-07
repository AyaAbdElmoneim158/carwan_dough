part of 'cart_cubit_2.dart';

@immutable
sealed class CartState2 {}

final class CartInitial extends CartState2 {}

final class CartSetLoading extends CartState2 {
  final String productId;
  CartSetLoading(this.productId);
}

final class CartSet extends CartState2 {
  final String productId;
  CartSet(this.productId);
}

final class CartSetFailure extends CartState2 {
  final String error;
  final String productId;
  CartSetFailure(this.error, this.productId);
}

final class CartFetchLoading extends CartState2 {}

final class CartFetched extends CartState2 {
  final List<CartItemModel> cartItems;
  CartFetched(this.cartItems);
}

final class CartFetchedError extends CartState2 {
  final String error;
  CartFetchedError(this.error);
}

final class CartRemoveLoading extends CartState2 {
  final String id;
  CartRemoveLoading(this.id);
}

final class CartRemoved extends CartState2 {
  final String id;
  CartRemoved(this.id);
}

final class CartRemovedFailure extends CartState2 {
  final String error;
  final String id;
  CartRemovedFailure(this.error, this.id);
}

/// Check per-product cart
final class CheckIsItemInCartLoading extends CartState2 {
  final String productId;
  CheckIsItemInCartLoading(this.productId);
}

final class CheckIsItemInCartSuccess extends CartState2 {
  final String productId;
  final bool isInCart;
  CheckIsItemInCartSuccess({
    required this.productId,
    required this.isInCart,
  });
}

final class CheckIsItemInCartFailure extends CartState2 {
  final String error;
  CheckIsItemInCartFailure(this.error);
}

/// 🔥 New states for quantity management
final class CartItemQuantityUpdated extends CartState2 {
  final String productId;
  final int quantity;
  CartItemQuantityUpdated(this.productId, this.quantity);
}

final class CartItemQuantityUpdateLoading extends CartState2 {
  final String productId;
  CartItemQuantityUpdateLoading(this.productId);
}
