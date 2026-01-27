import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/up_down_animation.dart';
import 'package:flutter/material.dart';

class BannerWithWaves extends StatelessWidget {
  const BannerWithWaves({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Column(
        children: [
          Container(
            height: size.height * 0.31,
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              color: AppColors.red,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "sugar, spice and\neverything nice",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/cake1.png",
                            height: size.height * 0.065,
                          ).upDown(
                            offset: 10,
                            duration: const Duration(seconds: 1),
                            // phase: 0.3,
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/cina3.png",
                            height: size.height * 0.04,
                          ).upDown(
                            offset: 12,
                            duration: const Duration(seconds: 2),
                            // phase: 0.6,
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/doug8.png",
                        height: size.height * 0.065,
                      ).upDown(
                        offset: 14,
                        duration: const Duration(seconds: 3),
                        // phase: 0.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              "assets/images/waves.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
