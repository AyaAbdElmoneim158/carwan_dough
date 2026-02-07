import 'dart:math';

import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/controllers/cart/cart_cubit.dart';
import 'package:carwan_dough/controllers/order/order_cubit.dart';
import 'package:carwan_dough/models/cart_model.dart';
import 'package:carwan_dough/models/order_model.dart';
import 'package:carwan_dough/services/order_services.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/theme/app_styles.dart';
import 'package:carwan_dough/views/widgets/app_app_bar.dart';
import 'package:carwan_dough/views/widgets/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Stack(
              children: [
                BackgroundGradient(),
                Center(
                  child: AppCard(
                    scrollable: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Your Cart",
                          textAlign: TextAlign.center,
                          style: AppStyles.fontHeadlineSmallW700DarkRed(context),
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<CartCubit, CartState>(
                          buildWhen: (previous, current) => current is CartFetchLoading || current is CartFetched || current is CartFetchedError || current is UpdatedQuantity,
                          builder: (context, state) {
                            if (state is CartFetchLoading) {
                              return CartFetchLoadingWidget();
                            }

                            if (state is CartFetchedError) {
                              return CartFetchedErrorWidget(error: state.error);
                            }

                            if (state is CartFetched) {
                              final cartItems = state.cartItems;
                              if (cartItems.isEmpty) {
                                return EmptyCartItemsWidget();
                              } else {
                                return CartItemsListView(cartItems: cartItems);
                              }
                            } else if (state is UpdatedQuantity) {
                              final cartItems = state.cartItems;
                              if (cartItems.isEmpty) {
                                return EmptyCartItemsWidget();
                              } else {
                                return CartItemsListView(cartItems: cartItems);
                              }
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: AppConstant.heightNav),
                        //   child: SizedBox(),
                        // ),
                        //!-------------------------------------------------------------------------
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemsListView extends StatefulWidget {
  const CartItemsListView({super.key, required this.cartItems});
  final List<CartItemModel> cartItems;

  @override
  State<CartItemsListView> createState() => _CartItemsListViewState();
}

class _CartItemsListViewState extends State<CartItemsListView> {
  double total = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cartCubit = BlocProvider.of<CartCubit>(context);

    cartCubit.fetchCartItemsAsStream().listen((cartItems) {
      final newTotal = cartItems.fold<double>(
        0,
        (previousValue, item) => previousValue + (item.price * item.quantity),
      );

      if (mounted) {
        setState(() => total = newTotal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = widget.cartItems[index];
            return ListTileCartItem(
              key: ValueKey(item.id), // 🔥 IMPORTANT
              item: item,
            );
          },
        ),
        const SizedBox(height: 16), EstimatedTotalWidget(total: total), SizedBox(height: 12),
        //! Todo: Proceed to Checkout_btn
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              final parentContext = context;
              showModalBottomSheet(
                context: parentContext,
                backgroundColor: AppColors.white,
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<CartCubit>.value(
                        value: parentContext.read<CartCubit>(),
                      ),
                      BlocProvider<OrderCubit>(
                        create: (context) => OrderCubit(
                          OrderServicesImpl(
                            parentContext.read<AuthCubit>().user.uid,
                          ),
                        ),
                      ),
                    ],
                    child: ConfirmationOrderBottomSheet(
                      total: total,
                      cartItems: widget.cartItems,
                    ),
                  );
                },
              );
            },
            child: const Text("Proceed to Checkout"),
          ),
        ),
        // const SizedBox(height: 64),
      ],
    );
  }
}

class ConfirmationOrderBottomSheet extends StatefulWidget {
  const ConfirmationOrderBottomSheet({
    super.key,
    required this.total,
    required this.cartItems,
  });

  final double total;
  final List<CartItemModel> cartItems;

  @override
  State<ConfirmationOrderBottomSheet> createState() => _ConfirmationOrderBottomSheetState();
}

class _ConfirmationOrderBottomSheetState extends State<ConfirmationOrderBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit(OrderCubit orderCubit, CartCubit cartCubit) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final address = _addressController.text.trim();
      final notes = _notesController.text.trim();

      debugPrint("Name: $name");
      debugPrint("Phone: $phone");
      debugPrint("Address: $address");
      debugPrint("Notes: $notes");

      final order = OrderModel(
        id: generateId(),
        status: "pending",
        uid: context.read<AuthCubit>().user.uid,
        name: name,
        phone: phone,
        address: address,
        notes: notes,
        cartItems: widget.cartItems,
        total: widget.total,
        deliveryDate: DateTime.now().toIso8601String(),
      );

      orderCubit.addOrder(order);
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate, // Lock all dates before yesterday
      lastDate: DateTime(2101),
      builder: (context, child) {
        return child!;
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    final cartCubit = context.read<CartCubit>();
    // final DateTime today = DateTime.now();
    // final DateTime yesterday = DateTime(today.year, today.month, today.day - 1);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              Text(
                "Confirmation Order",
                textAlign: TextAlign.center,
                style: AppStyles.fontHeadlineSmallW700DarkRed(context),
              ),

              const SizedBox(height: 16),

              /// Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => value == null || value.isEmpty ? "Name is required" : null,
              ),

              const SizedBox(height: 12),

              /// Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone is required";
                  }
                  if (value.length < 10) {
                    return "Enter valid phone number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              /// Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (value) => value == null || value.isEmpty ? "Address is required" : null,
              ),
              const SizedBox(height: 12),

              /// Notes
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Notes"),
              ),
              const SizedBox(height: 12),

              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Payment Method',
                      style: AppStyles.fontTitleMediumW600darkRed(context).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  RadioListTile(
                    groupValue: 0,
                    value: true,
                    onChanged: (value) {},
                    title: Text(
                      "Pay on Delivery",
                      style: AppStyles.fontTitleSmallW500DarkRed(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Date of recipe'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Submit button
              MultiBlocListener(
                listeners: [
                  BlocListener<OrderCubit, OrderState>(
                    listenWhen: (previous, current) => current is OrderAddFailure || current is OrderAdded,
                    listener: (context, state) {
                      if (state is OrderAddFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Failed to place order: ${state.message}"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        Navigator.pop(context);
                      } else if (state is OrderAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Order placed successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        cartCubit.clearCart();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, orderState) {
                    final bool isOrderLoading = orderState is OrderAddLoading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isOrderLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final name = _nameController.text.trim();
                                  final phone = _phoneController.text.trim();
                                  final address = _addressController.text.trim();
                                  final notes = _notesController.text.trim();

                                  final order = OrderModel(
                                    id: generateId(),
                                    status: "pending",
                                    uid: context.read<AuthCubit>().user.uid,
                                    name: name,
                                    phone: phone,
                                    address: address,
                                    notes: notes,
                                    cartItems: widget.cartItems,
                                    total: widget.total,
                                    deliveryDate: selectedDate.toIso8601String(),
                                  );

                                  context.read<OrderCubit>().addOrder(order);
                                  context.read<CartCubit>().clearCart();
                                }
                              },
                        child: isOrderLoading ? const CupertinoActivityIndicator() : const Text("Order confirmation"),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileCartItem extends StatelessWidget {
  const ListTileCartItem({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Row(
      // key: ValueKey(item.id),
      // key: ValueKey('cart_row_${item.id}_${item.quantity}'), // 🔥 Key للصف
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            children: [
              //* Delete Button
              BlocBuilder(
                bloc: cartCubit,
                buildWhen: (previous, current) => (current is CartRemoveLoading && current.id == item.productId) || current is CartRemovedFailure || current is CartRemoved && current.id == item.id,
                builder: (context, state) {
                  // bool isLoading = state is CartRemoveLoading && state.id == item.productId && cartCubit.loadingStates[state.id] == "delete";
                  return Container(
                    key: ValueKey('delete_btn_${item.id}'),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GestureDetector(
                      onTap: () => cartCubit.removeCart(item.id), // isLoading ? null :
                      child: const Icon(Icons.delete, color: Colors.white), //  isLoading ? const CupertinoActivityIndicator(color: Colors.white) :
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.name,
                  style: AppStyles.fontTitleSmallW500DarkRed(context),
                ),
              ),
            ],
          ),
        ),
        Text("${item.price} E£", style: AppStyles.fontTitleSmallW500DarkRed(context)),
        const SizedBox(width: 8),

        //* Quantity Controls
        QuantityControls(cartCubit: cartCubit, item: item),
      ],
    );
    // },
    // );
  }
}

class QuantityControls extends StatelessWidget {
  const QuantityControls({
    super.key,
    required this.cartCubit,
    required this.item,
  });

  final CartCubit cartCubit;
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // key: ValueKey('quantity_controls_${item.id}_${item.quantity}'), // 🔥 Key لأزرار الكمية
      children: [
        //* Decrement Button
        BlocBuilder(
          bloc: cartCubit,
          buildWhen: (previous, current) =>
              (current is UpdatingQuantityLoading && current.productId == item.productId) || current is UpdatingQuantityFailure || current is CartRemoved || current is UpdatedQuantity && current.productId == item.productId,
          builder: (context, state) {
            // bool isLoading = state is UpdatingQuantityLoading && cartCubit.loadingStates[state.productId] == "decrement";
            return Container(
              key: ValueKey('decrement_btn_${item.id}'),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.darkRed,
                borderRadius: BorderRadius.circular(4),
              ),
              child: GestureDetector(
                onTap: () => (item.quantity == 1) ? cartCubit.removeCart(item.id) : cartCubit.decrementQuantity(item.productId), // isLoading ? null :
                child: const Icon(Icons.remove, color: Colors.white), // isLoading ? const CupertinoActivityIndicator(color: Colors.white) :
              ),
            );
          },
        ),
        const SizedBox(width: 8),

        //* Quantity Display
        Container(
          key: ValueKey('quantity_display_${item.id}_${item.quantity}'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.darkRed),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            item.quantity.toString(),
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
          buildWhen: (previous, current) => (current is UpdatingQuantityLoading && current.productId == item.productId) || current is UpdatingQuantityFailure || current is UpdatedQuantity && current.productId == item.productId,
          builder: (context, state) {
            // cartCubit.loadingStates.containsKey(productId)
            // bool isLoading = (state is UpdatingQuantityLoading && state.productId == item.productId) && cartCubit.loadingStates[state.productId] == "increment";
            return Container(
              key: ValueKey('increment_btn_${item.id}'),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.darkRed,
                borderRadius: BorderRadius.circular(4),
              ),
              child: GestureDetector(
                onTap: () => cartCubit.incrementQuantity(item.productId, item), //  isLoading ? null :
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

//* ===============================================================
class EstimatedTotalWidget extends StatelessWidget {
  const EstimatedTotalWidget({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Estimated total",
          style: AppStyles.fontTitleMediumW600darkRed(context),
        ),
        Text(
          "$total E£",
          style: AppStyles.fontTitleMediumW600darkRed(context),
        ),
      ],
    );
  }
}

class EmptyCartItemsWidget extends StatelessWidget {
  const EmptyCartItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/empty_2.png',
          height: size.height * 0.1,
        ),
        const SizedBox(height: 16),
        Text(
          "Your cart is empty",
          textAlign: TextAlign.center,
          style: AppStyles.fontTitleMediumW600darkRed(context),
        ),
        const SizedBox(height: 8),
        Text(
          "Add some items to get started!",
          textAlign: TextAlign.center,
          style: AppStyles.fontTitleSmallW600White(context).copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class CartFetchLoadingWidget extends StatelessWidget {
  const CartFetchLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return const ShimmerCartItem();
      },
    );
  }
}

class CartFetchedErrorWidget extends StatelessWidget {
  const CartFetchedErrorWidget({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image.network(
          'assets/images/oops_2.png',
          height: size.height * 0.1,
        ),
        const SizedBox(height: 8),
        Text(
          "Oops..",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.red),
        ),
        Text(
          error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            transform: const GradientRotation(75 * pi / 180),
            colors: const [
              Color(0xFFD81B32),
              Color(0xFFEB2222),
            ],
          ),
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Name",
            style: AppStyles.fontTitleSmallW600White(context),
          ),
          Text(
            "Price",
            style: AppStyles.fontTitleSmallW600White(context),
          ),
          Text(
            "Qty",
            style: AppStyles.fontTitleSmallW600White(context),
          ),
        ],
      ),
    );
  }
}

class ShimmerCartItem extends StatelessWidget {
  const ShimmerCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseColor = AppColors.darkRed.withOpacity(0.6);
    final highlightColor = AppColors.darkRed.withOpacity(0.35);
    final itemColor = theme.cardColor.withOpacity(0.25);

    Widget shimmerBox({
      required double width,
      double height = 14,
      double radius = 4,
    }) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    }

    Widget shimmerIcon() {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.darkRed.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: shimmerBox(width: 12, height: 12),
      );
    }

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1600),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          shimmerBox(width: double.infinity),

          // /// Left section (delete + name)
          // Expanded(
          //   child: Row(
          //     children: [
          //       shimmerIcon(),
          //       const SizedBox(width: 4),
          //       shimmerBox(width: 90),
          //     ],
          //   ),
          // ),

          // /// Price
          // shimmerBox(width: 40),

          // /// Quantity controls
          // Row(
          //   children: [
          //     shimmerIcon(),
          //     const SizedBox(width: 6),
          //     shimmerBox(width: 20),
          //     const SizedBox(width: 6),
          //     shimmerIcon(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
