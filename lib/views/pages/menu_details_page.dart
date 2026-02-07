import 'dart:async';

import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/controllers/cart/cart_cubit.dart';
import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/models/menu_item_model.dart';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/widgets/app_app_bar.dart';
import 'package:carwan_dough/views/widgets/footer.dart';
import 'package:carwan_dough/views/widgets/header_with_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuDetailsPage extends StatelessWidget {
  const MenuDetailsPage({super.key, required this.menu});
  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // int quantity = 1;
    bool isAdmin = context.read<AuthCubit>().user.role == Role.admin;

    return Scaffold(
      appBar: AppAppBar(hasLeading: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/waves.png",
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: HeaderWithLine(title: menu.name),
            ),
            if (isAdmin)
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      //  ! Scenario.... popup dialog with form .... name + price + image from drive + menu (change)
                    },
                    child: const Text('Add New Item'),
                  ),
                ),
              ),
            SizedBox(height: 24),
            if (menu.menuItems.isEmpty)
              Text("menu is empty...!")
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  children: menu.menuItems
                      .map(
                        (item) => MenuItem(
                          item: item,
                          isAdmin: isAdmin,
                        ),
                      )
                      .toList(),
                ),
              ),
            SizedBox(height: 16),
            Footer(hasBottomSize: false),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.item, required this.isAdmin});
  final MenuItemModel item;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // bool showSnackbar = true;
    // final cartCubit = BlocProvider.of<CartCubit>(context);
    // final item_ = CartItemModel(
    //   id: generateId(),
    //   productId: item.id,
    //   name: item.name,
    //   price: item.price,
    //   quantity: 0,
    // );
    // Call this once to check if item already in cart
    // context.read<CartCubit>().checkIsItemInCart(item.id);
    final cartCubit = context.watch<CartCubit>();

    final cartItem = cartCubit.getCartItemByProductId(item.id);

    return SizedBox(
      width: size.width * 0.45,
      child: Card(
        color: AppColors.darkRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
                height: size.height * 0.2,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 4),
            // Name
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w100,
              ),
            ),
            // Price row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Price: ",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${item.price}E£",
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            isAdmin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Edit.btn
                      Container(
                        // key: ValueKey('decrement_btn_${item.id}_$quantity'), // Include quantity in key
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            color: AppColors.darkRed,
                          ),
                        ),
                      ),
                      //Delete.btn
                      Container(
                        // key: ValueKey('decrement_btn_${item.id}_$quantity'), // Include quantity in key
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: AppColors.darkRed,
                          ),
                        ),
                      ),
                    ],
                  )
                : QuantityControlsAtItemDetails(
                    cartCubit: cartCubit,
                    item: item,
                  ),
            /* Center(
                child:
                    //  cartItem == null?
                    _AddToCartButton(
              item: item,
              cartCubit: cartCubit,
            )
            
                // : QuantityControlsAtItemDetails0(
                //     cartCubit: cartCubit,
                //     item: cartItem,
                //   ),
                ),
                */
            /* // Order Button
            BlocConsumer<CartCubit, CartState>(
              // listenWhen: (previous, current) => current is CartSet || current is CartSetFailure,
              listener: (context, state) {
                if (!showSnackbar) return;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // if (state is CartSet) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text("Added Success....!")),
                //   );
                // } else if (state is CartSetFailure) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.error)),
                //   );
                // }
              },
              builder: (context, state) {
                // final isChecking = state is CheckIsItemInCartLoading && state.productId == item.id;
                // final isAdding = state is CartSetLoading && state.productId == item.id;
                // final isLoading = isChecking || isAdding;

                // final isItemInCart = context.read<CartCubit>().isProdInCart(item.id);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed:
                          // (isLoading || isItemInCart)? null:
                          () {
                        showSnackbar = true;

                        // context.read<CartCubit>().toggleCart(
                        //       CartItemModel(
                        //         id: generateId(),
                        //         productId: item.id,
                        //         name: item.name,
                        //         price: item.price,
                        //         quantity: 1,
                        //         image: item.image,
                        //       ),
                        //     );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.darkRed,
                      ),
                      child:
                          // isLoading? const CupertinoActivityIndicator():
                          AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) => ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                        child: Text(
                          // isItemInCart ? "Added ✓" :
                          "Order new",
                          // key: ValueKey(isItemInCart),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),*/
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({
    required this.item,
    required this.cartCubit,
  });

  final MenuItemModel item;
  final CartCubit cartCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cartCubit,
      buildWhen: (previous, current) => (current is CartAddLoading && current.id == item.id) || current is CartAdd || current is CartAddFailure,
      builder: (context, state) {
        final isLoading = (state is CartAddLoading && state.id == item.id) && cartCubit.loadingStates[item.id] == 'add';

        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: ValueKey('add_btn_${item.id}'),
              onPressed: isLoading
                  ? null
                  : () {
                      cartCubit.addToCart(
                        CartItemModel(
                          id: generateId(),
                          productId: item.id,
                          name: item.name,
                          price: item.price,
                          quantity: 1,
                          image: item.image,
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.darkRed,
              ),
              child: isLoading
                  ? const CupertinoActivityIndicator(color: AppColors.darkRed)
                  : const Text(
                      "Add to Cart",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class QuantityControlsAtItemDetails0 extends StatefulWidget {
  const QuantityControlsAtItemDetails0({
    super.key,
    required this.cartCubit,
    required this.item,
  });

  final CartCubit cartCubit;
  final MenuItemModel item;

  @override
  State<QuantityControlsAtItemDetails0> createState() => _QuantityControlsAtItemDetails0State();
}

class _QuantityControlsAtItemDetails0State extends State<QuantityControlsAtItemDetails0> {
  late int quantity; // = 0;
  // init -> to change quantity
  @override
  void initState() {
    super.initState();
    intiQuantity();
  }

  void intiQuantity() {
    final cartItemModel = widget.cartCubit.getCartItemByProductId(widget.item.id);
    quantity = cartItemModel?.quantity ?? 0;

    widget.cartCubit.stream.listen((state) {
      final updatedItem = widget.cartCubit.getCartItemByProductId(widget.item.id);
      if (updatedItem != null && updatedItem.quantity != quantity) {
        setState(() {
          quantity = updatedItem.quantity;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = widget.cartCubit;
    final item = widget.item;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // key: ValueKey('quantity_controls_${item.id}_${item.quantity}'), // 🔥 Key لأزرار الكمية
      children: [
        //* Decrement Button
        // BlocBuilder(
        //   bloc: cartCubit,
        //   buildWhen: (previous, current) =>
        //       (current is UpdatingQuantityLoading && current.productId == item.productId) || current is UpdatingQuantityFailure || current is CartRemoved || current is UpdatedQuantity && current.productId == item.productId,
        //   builder: (context, state) {

        // return
        Container(
          key: ValueKey('decrement_btn_${widget.item.id}'),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.darkRed,
            borderRadius: BorderRadius.circular(4),
          ),
          child: GestureDetector(
            onTap: () {}, //=> (item.quantity == 1) ? cartCubit.removeCart(item.id) : cartCubit.decrementQuantity(item.productId), // isLoading ? null :
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ), // );
        // },
        // ),
        const SizedBox(width: 8),

        //* Quantity Display
        Container(
          key: ValueKey('quantity_display_${widget.item.id}'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.darkRed),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            quantity.toString(), // item.quantity.toString(),
            style: const TextStyle(
              color: AppColors.darkRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),

        //* Increment Button
        BlocBuilder(
          bloc: cartCubit,
          buildWhen: (previous, current) => (current is UpdatingQuantityLoading && current.productId == item.id) || current is UpdatingQuantityFailure || current is UpdatedQuantity && current.productId == item.id,
          builder: (context, state) {
            // cartCubit.loadingStates.containsKey(productId)
            // bool isLoading = (state is UpdatingQuantityLoading && state.productId == item.productId) && cartCubit.loadingStates[state.productId] == "increment";
            return Container(
              key: ValueKey('increment_btn_${widget.item.id}'),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.darkRed,
                borderRadius: BorderRadius.circular(4),
              ),
              child: GestureDetector(
                onTap: () {
                  final cartItem = CartItemModel(
                    id: generateId(),
                    productId: item.id,
                    name: item.name,
                    price: item.price,
                    quantity: quantity,
                  );
                  if (quantity == 0) {
                    cartCubit.addToCart(cartItem);
                  } else {
                    cartCubit.incrementQuantity(item.id, cartItem);
                  }
                  // setState(() => quantity++);
                }, //  isLoading ? null :
                child: const Icon(Icons.add, color: Colors.white),
                //  isLoading ? const CupertinoActivityIndicator(color: Colors.white) :
              ),
            );
          },
        ),
      ],
    );
  }
}

class QuantityControlsAtItemDetails extends StatefulWidget {
  const QuantityControlsAtItemDetails({
    super.key,
    required this.cartCubit,
    required this.item,
  });

  final CartCubit cartCubit;
  final MenuItemModel item;

  @override
  State<QuantityControlsAtItemDetails> createState() => _QuantityControlsAtItemDetailsState();
}

class _QuantityControlsAtItemDetailsState extends State<QuantityControlsAtItemDetails> {
  late int quantity;
  StreamSubscription? _cartSubscription;

  @override
  void initState() {
    super.initState();
    _initQuantity();
    _setupCartListener();
  }

  void _initQuantity() {
    final cartItemModel = widget.cartCubit.getCartItemByProductId(widget.item.id);
    quantity = cartItemModel?.quantity ?? 0;
  }

  void _setupCartListener() {
    _cartSubscription = widget.cartCubit.stream.listen((state) {
      if (state is UpdatedQuantity || state is CartAdd || state is CartRemoved) {
        _updateQuantityFromCart();
      } else if (state is CartFetched) {
        _updateQuantityFromCart();
      }
    });
  }

  void _updateQuantityFromCart() {
    final cartItemModel = widget.cartCubit.getCartItemByProductId(widget.item.id);
    final newQuantity = cartItemModel?.quantity ?? 0;

    if (newQuantity != quantity) {
      setState(() {
        quantity = newQuantity;
      });
    }
  }

  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = widget.cartCubit;
    final item = widget.item;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      key: ValueKey('quantity_controls_${item.id}_$quantity'), // Add key with quantity
      children: [
        //* Decrement Button
        Container(
          key: ValueKey('decrement_btn_${item.id}_$quantity'), // Include quantity in key
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: quantity > 0 ? AppColors.darkRed : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: GestureDetector(
            onTap: quantity > 0
                ? () {
                    final cartItem = cartCubit.getCartItemByProductId(item.id);
                    if (cartItem != null) {
                      if (cartItem.quantity == 1) {
                        cartCubit.removeCart(cartItem.id);
                      } else {
                        cartCubit.decrementQuantity(item.id);
                      }
                    }
                  }
                : null,
            child: Icon(
              Icons.remove,
              color: quantity > 0 ? Colors.white : Colors.grey[500],
            ),
          ),
        ),
        const SizedBox(width: 8),

        //* Quantity Display
        Container(
          key: ValueKey('quantity_display_${item.id}_$quantity'), // Include quantity in key
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.darkRed),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(
              color: AppColors.darkRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),

        //* Increment Button
        Container(
          key: ValueKey('increment_btn_${item.id}_$quantity'), // Include quantity in key
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.darkRed,
            borderRadius: BorderRadius.circular(4),
          ),
          child: GestureDetector(
            onTap: () {
              final cartItem = cartCubit.getCartItemByProductId(item.id);
              if (cartItem != null) {
                cartCubit.incrementQuantity(item.id, cartItem);
              } else {
                final newCartItem = CartItemModel(
                  id: generateId(),
                  productId: item.id,
                  name: item.name,
                  price: item.price,
                  quantity: 1,
                );
                cartCubit.addToCart(newCartItem);
              }
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
