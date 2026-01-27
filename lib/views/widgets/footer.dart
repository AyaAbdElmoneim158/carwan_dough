import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, this.hasBottomSize = true});
  final bool hasBottomSize;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.red,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // spacing: 12,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.03,
            ),
            SizedBox(height: 16),

            Text(
              "Contact Us",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),

            Text(
              "Phone: 01556364646 ",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
              ),
            ),
            Text(
              "Location: On the clouds ☁️🖤",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Follow Us",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),

            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/social/whatsapp.svg",
                  color: AppColors.white,
                  height: 16,
                  // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
                ),
                SvgPicture.asset(
                  "assets/images/social/facebook_.svg",
                  color: AppColors.white,

                  height: 16,
                  // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
                ),
                SvgPicture.asset(
                  "assets/images/social/instagram.svg",
                  color: AppColors.white,
                  height: 16,

                  // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
                ),
                SvgPicture.asset(
                  "assets/images/social/tiktok.svg",
                  color: AppColors.white,
                  height: 16,
                  // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
                ),
              ],
            ),
            hasBottomSize ? SizedBox(height: 72) : SizedBox(height: 12),

            // https://wa.me/+201556364646
            // https://www.instagram.com/carwandough/
            // https://www.facebook.com/profile.php?id=61568194640512
            // https://www.tiktok.com/@carwan_dough
          ],
        ),
      ),
    );
  }
}
