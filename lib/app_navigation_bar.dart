import 'package:carwan_dough/controllers/home/home_cubit.dart';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/services/home_services.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/pages/home_page.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { home, cart, order }

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  var _selectedTab = _SelectedTab.home;
  List<Widget> pages = [
    BlocProvider(
      create: (context) => HomeCubit()..fetchMenu(),
      child: HomePage(),
    ),
    Container(),
    Container(),
  ];

  void _handleIndexChanged(int i) {
    setState(() => _selectedTab = _SelectedTab.values[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      body: pages[_selectedTab.index],
      bottomNavigationBar: CrystalNavigationBar(
        margin: EdgeInsets.all(0),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        unselectedItemColor: AppColors.white,
        selectedItemColor: AppColors.white,
        backgroundColor: AppColors.red,
        indicatorColor: AppColors.white,

        borderWidth: 2,
        outlineBorderColor: AppColors.white,
        // .withValues(alpha: 0.5),
        // height: 10,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     spreadRadius: 4,
        //     offset: Offset(0, 10),
        //   ),
        // ],
        onTap: _handleIndexChanged,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyLight.home,
            unselectedIcon: IconlyBold.home,
          ),
          CrystalNavigationBarItem(
            icon: IconlyLight.buy,
            unselectedIcon: IconlyBold.buy,
          ),
          CrystalNavigationBarItem(
            icon: IconlyLight.document,
            unselectedIcon: IconlyBold.document,
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     HomeServicesImpl().addMenu(MenuModel.menu[3]);
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
