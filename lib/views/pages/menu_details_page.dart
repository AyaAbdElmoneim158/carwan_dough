import 'package:carwan_dough/models/menu_item_model.dart';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/views/widgets/app_app_bar.dart';
import 'package:carwan_dough/views/widgets/footer.dart';
import 'package:carwan_dough/views/widgets/header_with_line.dart';
import 'package:flutter/material.dart';

class MenuDetailsPage extends StatelessWidget {
  const MenuDetailsPage({super.key, required this.menu});
  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            if (menu.menuItems.isEmpty)
              Text("menu is empty...!")
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  children: menu.menuItems
                      .map(
                        (item) => SizedBox(
                          width: size.width * 0.45,
                          // height: size.height * 0.3,
                          child: Card(
                            color: AppColors.darkRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    // "assets/images/banner.webp",
                                    // 'assets/images/products/1-pistachio-royal-sideview.webp',
                                    // testImages[e.toString()],
                                    item.image,
                                    fit: BoxFit.cover,
                                    height: size.height * 0.2,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                Row(
                                  spacing: 8,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Price: ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "${item.price}E£",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.white,
                                        foregroundColor: AppColors.darkRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        "Order new",
                                        style: TextStyle(
                                          color: AppColors.darkRed,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
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
