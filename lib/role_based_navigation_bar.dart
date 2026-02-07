import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/controllers/cart/cart_cubit.dart';
import 'package:carwan_dough/controllers/home/home_cubit.dart';
import 'package:carwan_dough/controllers/order/order_cubit.dart';
import 'package:carwan_dough/services/cart_services.dart';
import 'package:carwan_dough/services/home_services.dart';
import 'package:carwan_dough/services/order_services.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/pages/cart_page.dart';
import 'package:carwan_dough/views/pages/home_page.dart';
import 'package:carwan_dough/views/pages/order_page.dart';
import 'package:carwan_dough/views/pages/statistics_page.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class RoleBasedNavigationBar extends StatefulWidget {
  final Role role;

  const RoleBasedNavigationBar({
    super.key,
    required this.role,
  });

  @override
  State<RoleBasedNavigationBar> createState() => _RoleBasedNavigationBarState();
}

class _RoleBasedNavigationBarState extends State<RoleBasedNavigationBar> {
  int _currentIndex = 0;

  late final List<Widget> _pages;
  late final List<CrystalNavigationBarItem> _items;

  @override
  void initState() {
    super.initState();
    _setupNavigation();
  }

  void _setupNavigation() {
    final uid = context.read<AuthCubit>().user.uid;

    switch (widget.role) {
      case Role.client:
        _pages = [
          BlocProvider(create: (_) => HomeCubit(HomeServicesImpl()), child: const HomePage()),
          BlocProvider(create: (_) => CartCubit(CartServicesImpl(uid))..fetchCartItems(), child: const CartPage()),
          BlocProvider(create: (_) => OrderCubit(OrderServicesImpl(uid)), child: const OrderPage()),
        ];

        _items = [
          CrystalNavigationBarItem(icon: IconlyLight.home, unselectedIcon: IconlyBold.home),
          CrystalNavigationBarItem(icon: IconlyLight.buy, unselectedIcon: IconlyBold.buy),
          CrystalNavigationBarItem(icon: IconlyLight.document, unselectedIcon: IconlyBold.document),
        ];
        break;

      case Role.admin:
        _pages = [
          BlocProvider(
            create: (_) => OrderCubit(OrderServicesImpl(uid))..fetchOrders(),
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderFetchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderFetched) {
                  return StatisticsPage(orders: state.orders);
                } else if (state is OrderFetchedError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          BlocProvider(create: (_) => HomeCubit(HomeServicesImpl()), child: const HomePage()),
          BlocProvider(create: (_) => OrderCubit(OrderServicesImpl(uid)), child: const OrderPage()),
          // BlocProvider(create: (_) => OrderCubit(OrderServicesImpl(uid))..fetchOrders(), child: const StatisticsPage(orders: ),),
        ];

        _items = [
          CrystalNavigationBarItem(icon: IconlyLight.home, unselectedIcon: IconlyBold.home),
          CrystalNavigationBarItem(icon: IconlyLight.document, unselectedIcon: IconlyBold.document),
          CrystalNavigationBarItem(icon: IconlyLight.graph, unselectedIcon: IconlyBold.graph),
          // activity | trendingUp | chart
        ];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CrystalNavigationBar(
        height: AppConstant.heightNav,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: AppColors.red,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        indicatorColor: AppColors.white,
        outlineBorderColor: AppColors.white,
        borderWidth: 2,
        items: _items,
      ),
    );
  }
}
