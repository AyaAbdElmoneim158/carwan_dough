import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/controllers/order/order_cubit.dart';
import 'package:carwan_dough/models/order_model.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/widgets/app_app_bar.dart';
import 'package:carwan_dough/views/widgets/header_with_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orderCubit = context.read<OrderCubit>();
    bool isAdmin = context.read<AuthCubit>().user.role == Role.admin;

    return Scaffold(
      //Todo: no this
      appBar: const AppAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: AppConstant.heightNav,
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/images/waves.png",
              // width: double.infinity,
              width: size.width,
              fit: BoxFit.contain,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: HeaderWithLine(title: "Orders"),
            ),
            StreamBuilder<List<OrderModel>>(
              stream: orderCubit.fetchOrdersAsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer or loading placeholder
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final orders = snapshot.data ?? [];

                // Separate active & past orders
                // final activeOrders = orders.where((o) => DateTime.parse(o.deliveryDate).isAfter(DateTime.now())).toList();
                // final pastOrders = orders.where((o) => DateTime.parse(o.deliveryDate).isBefore(DateTime.now())).toList();
                // final pastOrders = orders.where((o) => o.status.toLowerCase() == 'canceled' || o.status.toLowerCase() == 'delivered').toList();
                DateTime parseOrderDate(String id) {
                  return DateTime.parse(id); // ISO-8601 ✅
                }

                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);

                final pastOrders = orders.where((o) {
                  final orderDateTime = parseOrderDate(o.id);
                  final orderDate = DateTime(
                    orderDateTime.year,
                    orderDateTime.month,
                    orderDateTime.day,
                  );

                  final isPastDate = orderDate.isBefore(today);
                  final isPastStatus = ['canceled', 'delivered'].contains(o.status.toLowerCase());

                  return isPastDate || isPastStatus;
                }).toList();

                // final activeOrders = orders.where((o) => !['canceled', 'delivered'].contains(o.status.toLowerCase())).toList();
                final activeOrders = orders.where((o) {
                  final orderDateTime = parseOrderDate(o.id);
                  final orderDate = DateTime(
                    orderDateTime.year,
                    orderDateTime.month,
                    orderDateTime.day,
                  );

                  final isTodayOrFuture = orderDate.isAtSameMomentAs(today) || orderDate.isAfter(today);

                  final isActiveStatus = !['canceled', 'delivered'].contains(o.status.toLowerCase());

                  return isTodayOrFuture && isActiveStatus;
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active Orders
                    _buildSection(
                      context,
                      title: "Active Orders",
                      icon: Icons.access_time_filled,
                      orders: activeOrders,
                      emptyText: "You have no active orders.",
                      isAdmin: isAdmin,
                    ),

                    const SizedBox(height: 24),

                    // Past Orders
                    _buildSection(
                      context,
                      title: "Past Orders",
                      icon: Icons.settings_backup_restore_rounded,
                      orders: pastOrders,
                      emptyText: "You have no past orders.",
                      isAdmin: isAdmin,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<OrderModel> orders,
    required String emptyText,
    required bool isAdmin,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.black),
            const SizedBox(width: 4),
            Text(
              title,
              style: theme.textTheme.titleMedium!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (orders.isEmpty)
          Align(
            child: Text(
              emptyText,
              style: theme.textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
              ),
            ),
          )
        else
          Column(
            children: orders
                .map((order) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _buildOrderCard(context, order, isAdmin),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order, bool isAdmin) {
    final theme = Theme.of(context);
    // final isCanceled = order.notes.toLowerCase().contains("canceled"); // Example status
// order.deliveryDate =
    DateTime deliveryDate = DateTime.parse(order.deliveryDate);
    String justDeliveryDate = deliveryDate.toIso8601String().split('T').first;
    DateTime orderId = DateTime.parse(order.id);
    int numericDate = orderId.year * 10000 + orderId.month * 100 + orderId.day;

    return Card(
      color: AppColors.lightWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.red),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order #$numericDate",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: getStatusColor(order.status.trim().toLowerCase()).withOpacity(0.2), // light background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: getStatusColor(order.status.trim().toLowerCase()), // text color
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 4),
            Text(
              "Delivery: $justDeliveryDate",
              style: theme.textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),

            const SizedBox(height: 8),
            // Cart items summary
            ...order.cartItems.map((item) => Text(
                  " • ${item.name} x${item.quantity} - ${item.price * item.quantity} EGP",
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                  ),
                )),
            const SizedBox(height: 4),
            Text(
              "Total: ${order.total} EGP",
              style: theme.textTheme.bodySmall!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            if (order.status == "pending")
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       context.read<OrderCubit>().cancelOrder;
              //     },
              //     child: const Text('Cancel order'),
              //   ),
              // ),
              BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrderCanceled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order canceled successfully!')),
                    );
                  } else if (state is OrderCancelFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to cancel order: ${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is OrderCancelLoading;

                  return Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : isAdmin
                              ? () {}
                              : () async {
                                  // Show confirmation dialog
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Cancel Order'),
                                      content: const Text('Are you sure you want to cancel this order?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(false),
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(ctx).pop(true),
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );

                                  // If user confirmed, cancel the order
                                  if (confirm == true) {
                                    context.read<OrderCubit>().cancelOrder(order);
                                  }
                                },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoading ? Colors.grey : AppColors.red,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(!isAdmin ? 'Cancel order' : "Change States"),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
