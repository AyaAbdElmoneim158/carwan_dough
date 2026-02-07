part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// CartFetch -----------------------------------------------------
final class CartFetchLoading extends CartState {}

// final class CartFetched extends CartState {
//   final List<CartItemModel> cartItems;
//   CartFetched(this.cartItems);
// }

final class CartFetchedError extends CartState {
  final String error;
  CartFetchedError(this.error);
}

// CartRemove -----------------------------------------------------
final class CartRemoveLoading extends CartState {
  final String id;
  CartRemoveLoading(this.id);
}

final class CartRemoved extends CartState {
  final String id;
  CartRemoved(this.id);
}

final class CartRemovedFailure extends CartState {
  final String error;
  final String id;
  CartRemovedFailure(this.error, this.id);
}

// CartAd -----------------------------------------------------
final class CartAddLoading extends CartState {
  final String id;
  CartAddLoading(this.id);
}

final class CartAdd extends CartState {
  final String id;
  CartAdd(this.id);
}

final class CartAddFailure extends CartState {
  final String error;
  final String id;
  CartAddFailure(this.error, this.id);
}

// -----------------------------------------------------------
final class UpdatingQuantityLoading extends CartState {
  final String productId;
  UpdatingQuantityLoading(this.productId);
}

final class UpdatingQuantityFailure extends CartState {
  final String productId;
  final String error;
  UpdatingQuantityFailure(this.error, this.productId);
}

// final class UpdatedQuantity extends CartState {
//   final String productId;
//   final List<CartItemModel> cartItems;
//   UpdatedQuantity(this.productId, this.cartItems);
// }

abstract class CartWithItems extends CartState {
  final List<CartItemModel> cartItems;
  CartWithItems(this.cartItems);
}

class CartFetched extends CartWithItems {
  CartFetched(super.cartItems);
}

class UpdatedQuantity extends CartWithItems {
  final String productId;
  UpdatedQuantity(this.productId, List<CartItemModel> cartItems) : super(cartItems);
}
