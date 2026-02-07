import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderWithLine extends StatelessWidget {
  const HeaderWithLine({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.darkRed,
                fontWeight: FontWeight.w500,
              ),
        ),
        Container(
          width: size.width / 1.5,
          height: size.height * 0.005,
          margin: EdgeInsets.only(top: 10, bottom: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.red,
                AppColors.white,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
