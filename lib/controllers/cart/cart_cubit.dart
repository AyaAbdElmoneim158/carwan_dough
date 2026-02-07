import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/services/cart_services.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartServices) : super(CartInitial());
  final CartServices cartServices;

  List<CartItemModel> cartItems = [];
  final Map<String, String> _loadingStates = {}; // productId -> operation type

  // Add this getter for convenience
  Map<String, String> get loadingStates => Map.unmodifiable(_loadingStates);

  Future<void> fetchCartItems() async {
    if (state is CartFetchLoading) return;
    emit(CartFetchLoading());
    try {
      final items = await cartServices.fetchCartItems();
      cartItems = items;
      emit(CartFetched(items));
    } catch (error) {
      emit(CartFetchedError(parseError(error)));
    }
  }

  Stream<List<CartItemModel>> fetchCartItemsAsStream() => cartServices.fetchCartItemsAsStream();

  //* removeCart || incrementQuantity || decrementQuantity
  Future<void> removeCart(String cartItemId) async {
    final item = cartItems.firstWhere((item) => item.id == cartItemId);
    emit(CartRemoveLoading(cartItemId));

    try {
      await cartServices.removeCart(cartItemId);
      cartItems.removeWhere((item) => item.id == cartItemId);
      _loadingStates[item.productId] = 'delete';
      emit(CartFetched([...cartItems]));
      await fetchCartItems();
      emit(CartRemoved(cartItemId));
    } catch (error) {
      emit(CartRemovedFailure(parseError(error), cartItemId));
    } finally {
      _loadingStates.remove(cartItemId);
    }
  }

  Future<void> addCart(String cartItemId) async {
    final item = cartItems.firstWhere((item) => item.id == cartItemId);
    emit(CartRemoveLoading(cartItemId));

    try {
      await cartServices.removeCart(cartItemId);
      cartItems.removeWhere((item) => item.id == cartItemId);
      _loadingStates[item.productId] = 'delete';
      emit(CartFetched([...cartItems]));
      await fetchCartItems();
      emit(CartRemoved(cartItemId));
    } catch (error) {
      emit(CartRemovedFailure(parseError(error), cartItemId));
    } finally {
      _loadingStates.remove(cartItemId);
    }
  }

  Future<void> incrementQuantity(String productId, [CartItemModel? cartItem]) async {
    final existingItem = getCartItemByProductId(productId);

    if (existingItem != null) {
      _loadingStates[productId] = 'increment';
      final newQuantity = existingItem.quantity + 1;
      await updateQuantity(productId, newQuantity);
    } else if (cartItem != null) {
      await addToCart(cartItem);
    }
    _loadingStates.remove(productId);
  }

  Future<void> decrementQuantity(String productId) async {
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) return;

    if (existingItem.quantity > 1) {
      _loadingStates[productId] = 'decrement';
      final newQuantity = existingItem.quantity - 1;
      await updateQuantity(productId, newQuantity);
    }
  }

/*
// Update the incrementQuantity method:
Future<void> incrementQuantity(String productId) async {
  final existingItem = getCartItemByProductId(productId);
  if (existingItem == null) return;

  _loadingStates[productId] = 'increment';
  emit(UpdatingQuantityLoading(productId));
  
  try {
    final newQuantity = existingItem.quantity + 1;
    await cartServices.updateCartItem(
      cartItemId: existingItem.id,
      cartItem: existingItem.copyWith(quantity: newQuantity),
    );
    
    // Update local state
    cartItems = cartItems.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
    
    emit(UpdatedQuantity(productId, cartItems));
  } catch (error) {
    emit(UpdatingQuantityFailure(parseError(error), productId));
  } finally {
    _loadingStates.remove(productId);
  }
}

// Update the decrementQuantity method:
Future<void> decrementQuantity(String productId) async {
  final existingItem = getCartItemByProductId(productId);
  if (existingItem == null) return;

  if (existingItem.quantity > 1) {
    _loadingStates[productId] = 'decrement';
    emit(UpdatingQuantityLoading(productId));
    
    try {
      final newQuantity = existingItem.quantity - 1;
      await cartServices.updateCartItem(
        cartItemId: existingItem.id,
        cartItem: existingItem.copyWith(quantity: newQuantity),
      );
      
      // Update local state
      cartItems = cartItems.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();
      
      emit(UpdatedQuantity(productId, cartItems));
    } catch (error) {
      emit(UpdatingQuantityFailure(parseError(error), productId));
    } finally {
      _loadingStates.remove(productId);
    }
  }
}
 */
  CartItemModel? getCartItemByProductId(String productId) {
    try {
      CartItemModel cartItemModel = cartItems.firstWhere((item) {
        debugPrint(" ${item.productId} == $productId ...${item.productId == productId}");

        return item.productId == productId;
      });

      debugPrint("cartItemModel exist: ${cartItemModel.name}");
      return cartItemModel;
    } catch (_) {
      debugPrint("cartItemModel not-exist");

      return null;
    }
  }

  /*Future<void> updateQuantity(String productId, int newQuantity, [CartItemModel? cartItem]) async {
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) {
      // cartServices.setCart(cartItem!);
      return; // loadingStates[productId] = true;
    }

    emit(UpdatingQuantityLoading(productId));

    try {
      final updatedItem = existingItem.copyWith(quantity: newQuantity);
      await cartServices.updateCartItem(
        cartItemId: existingItem.id,
        cartItem: updatedItem,
      );

      // localQuantities[productId] = newQuantity;
      await fetchCartItems();
      final updatedItems = cartItems.map((item) {
        if (item.id == productId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();

      // emit(CartQuantityUpdated(updatedItems));
      emit(UpdatedQuantity(productId, updatedItems));
    } catch (error) {
      emit(UpdatingQuantityFailure(parseError(error), productId));
    } finally {
      loadingStates.remove(productId);
    }
  }*/
  Future<void> updateQuantity(String productId, int newQuantity) async {
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) return;

    // Optimistic UI update
    final updatedItems = cartItems.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();

    cartItems = updatedItems;
    // Emit a state that widgets can listen to
    emit(UpdatedQuantity(productId, updatedItems));

    try {
      await cartServices.updateCartItem(
        cartItemId: existingItem.id,
        cartItem: existingItem.copyWith(quantity: newQuantity),
      );
      // Refresh after successful update
      await fetchCartItems();
    } catch (error) {
      // Rollback on failure
      final rollbackItems = cartItems.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: existingItem.quantity);
        }
        return item;
      }).toList();

      cartItems = rollbackItems;
      emit(UpdatingQuantityFailure(parseError(error), productId));
      // Emit again with rollback data
      emit(UpdatedQuantity(productId, rollbackItems));
    }
  }

  Future<void> addToCart(CartItemModel cartItem) async {
    final existingItem = getCartItemByProductId(cartItem.productId);

    _loadingStates[cartItem.productId] = 'add';
    emit(CartAddLoading(cartItem.productId));

    try {
      if (existingItem == null) {
        // 🔥 ADD NEW ITEM
        await cartServices.setCart(
          cartItem.copyWith(quantity: 1),
        );
      } else {
        // 🔥 INCREMENT EXISTING ITEM
        await cartServices.updateCartItem(
          cartItemId: existingItem.id,
          cartItem: existingItem.copyWith(
            quantity: existingItem.quantity + 1,
          ),
        );
      }

      await fetchCartItems();
      emit(CartAdd(cartItem.productId));
    } catch (error) {
      emit(CartAddFailure(parseError(error), cartItem.productId));
    } finally {
      _loadingStates.remove(cartItem.productId);
    }
  }

  Future<void> clearCart() async {
    await cartServices.clearCart();
    emit(CartFetched([]));
    await fetchCartItems();
  }
}
