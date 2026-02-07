import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/up_down_animation.dart';
import 'package:flutter/material.dart';

class BannerWithWaves extends StatelessWidget {
  const BannerWithWaves({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.37, // total banner height
      child: Stack(
        children: [
          /// 🔴 Red Banner
          Container(
            height: size.height * 0.3,
            padding: EdgeInsets.all(size.width * 0.05),
            color: AppColors.red,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "sugar, spice and everything nice",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),

                  /// 🍰 Animated images
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/cake1.png",
                            height: size.height * 0.065,
                          ).upDown(offset: 10, duration: const Duration(seconds: 1)),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/cina3.png",
                            height: size.height * 0.04,
                          ).upDown(offset: 12, duration: const Duration(seconds: 2)),
                        ],
                      ),
                      Image.asset(
                        "assets/images/doug8.png",
                        height: size.height * 0.065,
                      ).upDown(offset: 14, duration: const Duration(seconds: 3)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 🌊 Wave at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/waves.png",
              fit: BoxFit.cover,
              height: size.height * 0.08,
            ),
          ),
        ],
      ),
    );
  }
}
