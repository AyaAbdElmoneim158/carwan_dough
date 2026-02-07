import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/services/cart_services_2.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'cart_state_2.dart';

// ... بداية الملف كما هي ...

class CartCubit2 extends Cubit<CartState2> {
  CartCubit2(this.cartServices) : super(CartInitial());

  final CartServices2 cartServices;

  /// 🔥 Local cache
  List<CartItemModel> cartItems = [];

  /// 🔥 Local quantities for each product
  final Map<String, int> _localQuantities = {};

  /// 🔥 Loading states for each product
  final Map<String, bool> _loadingStates = {};

  /// 🔥 Last updated product ID (لتتبع آخر منتج تم تحديثه)
  String? _lastUpdatedProductId;

  /// =========================
  /// Getters
  /// =========================

  String? get lastUpdatedProductId => _lastUpdatedProductId;

  bool isProdInCart(String productId) {
    return cartItems.any((item) => item.productId == productId);
  }

  CartItemModel? getCartItemByProductId(String productId) {
    try {
      return cartItems.firstWhere(
        (item) => item.productId == productId,
      );
    } catch (_) {
      return null;
    }
  }

  int getLocalQuantity(String productId) {
    return _localQuantities[productId] ?? 1;
  }

  void setLocalQuantity(String productId, int quantity) {
    _localQuantities[productId] = quantity;
    _lastUpdatedProductId = productId; // 🔥 تحديث آخر منتج تم تعديله
    emit(CartItemQuantityUpdated(productId, quantity));
  }

  bool isLoading(String productId) {
    return _loadingStates[productId] ?? false;
  }

  Stream<List<CartItemModel>> fetchCartItemsAsStream() {
    return cartServices.fetchCartItemsAsStream();
  }

  /// =========================
  /// Fetch Cart
  /// =========================
  Future<bool> isItemInCart(String productId) async {
    final items = await cartServices.fetchCartItems(productId);
    return items.any((e) => e.productId == productId);
  }

  Future<void> checkIsItemInCart(String productId) async {
    emit(CheckIsItemInCartLoading(productId));

    try {
      final result = await isItemInCart(productId);
      emit(
        CheckIsItemInCartSuccess(
          productId: productId,
          isInCart: result,
        ),
      );
    } catch (e) {
      emit(CheckIsItemInCartFailure(e.toString()));
    }
  }

  Future<void> fetchCartItems() async {
    if (state is CartFetchLoading) return;
    emit(CartFetchLoading());
    try {
      final items = await cartServices.fetchCartItems();
      cartItems = items;

      for (var item in items) {
        _localQuantities[item.productId] = item.quantity;
      }

      emit(CartFetched(items));
    } catch (error) {
      emit(CartFetchedError(parseError(error)));
    }
  }

  /// =========================
  /// Add / Update Cart
  /// =========================

  Future<void> setCart(CartItemModel cartItem) async {
    _lastUpdatedProductId = cartItem.productId; // 🔥 تحديث آخر منتج
    emit(CartSetLoading(cartItem.productId));
    _loadingStates[cartItem.productId] = true;

    try {
      final existingItem = getCartItemByProductId(cartItem.productId);
      if (existingItem != null) {
        // Update quantity
        final updatedItem = existingItem.copyWith(
          quantity: cartItem.quantity,
        );
        await cartServices.updateCartItem(
          cartItemId: existingItem.id,
          cartItem: updatedItem,
        );
      } else {
        // Add new
        await cartServices.setCart(cartItem);
      }

      _localQuantities[cartItem.productId] = cartItem.quantity;

      await fetchCartItems();
      emit(CartSet(cartItem.productId));
    } catch (error) {
      emit(
        CartSetFailure(
          parseError(error),
          cartItem.productId,
        ),
      );
    } finally {
      _loadingStates.remove(cartItem.productId);
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    _lastUpdatedProductId = productId; // 🔥 تحديث آخر منتج
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) return;

    _loadingStates[productId] = true;
    emit(CartItemQuantityUpdateLoading(productId));

    try {
      final updatedItem = existingItem.copyWith(quantity: newQuantity);
      await cartServices.updateCartItem(
        cartItemId: existingItem.id,
        cartItem: updatedItem,
      );

      _localQuantities[productId] = newQuantity;
      await fetchCartItems();
    } catch (error) {
      emit(CartSetFailure(parseError(error), productId));
    } finally {
      _loadingStates.remove(productId);
    }
  }

  Future<void> incrementQuantity(String productId) async {
    _lastUpdatedProductId = productId; // 🔥 تحديث آخر منتج
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) return;

    final newQuantity = existingItem.quantity + 1;
    await updateQuantity(productId, newQuantity);
  }

  Future<void> decrementQuantity(String productId) async {
    _lastUpdatedProductId = productId; // 🔥 تحديث آخر منتج
    final existingItem = getCartItemByProductId(productId);
    if (existingItem == null) return;

    if (existingItem.quantity > 1) {
      final newQuantity = existingItem.quantity - 1;
      await updateQuantity(productId, newQuantity);
    }
  }

  /// =========================
  /// Remove from Cart
  /// =========================

  Future<void> removeCart(String cartItemId) async {
    // 🔥 حفظ productId قبل الحذف
    final item = cartItems.firstWhere((item) => item.id == cartItemId);
    _lastUpdatedProductId = item.productId; // 🔥 تحديث آخر منتج

    emit(CartRemoveLoading(cartItemId));
    _loadingStates[cartItemId] = true;

    try {
      await cartServices.removeCart(cartItemId);

      cartItems.removeWhere((item) => item.id == cartItemId);
      _localQuantities.remove(item.productId);

      emit(CartFetched([...cartItems]));
      await fetchCartItems();

      emit(CartRemoved(cartItemId));
    } catch (error) {
      emit(
        CartRemovedFailure(parseError(error), cartItemId),
      );
    } finally {
      _loadingStates.remove(cartItemId);
    }
  }

  /// =========================
  /// Other methods (تبقى كما هي)
  /// =========================

  // ... باقي الكود كما هو ...
}
