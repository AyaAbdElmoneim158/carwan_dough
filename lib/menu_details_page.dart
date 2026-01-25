import 'package:carwan_dough/app_colors.dart';
import 'package:carwan_dough/cart_page.dart';
import 'package:carwan_dough/constant.dart';
import 'package:carwan_dough/home_page.dart';
import 'package:carwan_dough/shop_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDetailsPage extends StatelessWidget {
  const MenuDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.06,
        backgroundColor: AppColors.red,
        title: Image.asset(
          "assets/images/logo.png",
          height: size.height * 0.05,
        ),
        actions: [
          Text(
            "Welcome Aya",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute<void>(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            icon: Icon(Icons.article, color: AppColors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute<void>(
                  builder: (context) => const ShopPage(),
                ),
              );
            },
            icon: Icon(Icons.shopping_basket, color: AppColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/waves.png",
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: HeaderWithLine(title: "Custom orders"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: testImages
                    .map(
                      (e) => SizedBox(
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
                                  e,

                                  fit: BoxFit.cover,
                                  height: size.height * 0.2,
                                  width: double.infinity,
                                ),
                              ),
                              Text(
                                "Donut",
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
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "80EGP",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
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
            Footer(),
          ],
        ),
      ),
    );
  }
}
