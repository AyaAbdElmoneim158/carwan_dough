import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle fontTitleMediumW600darkRed(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkRed,
          fontFamily: "Montserrat",
        );
  }

  static TextStyle fontTitleSmallW600White(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontFamily: "Montserrat",
        );
  }

  static TextStyle fontTitleSmallW500DarkRed(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
          color: AppColors.darkRed,
          fontWeight: FontWeight.w500,
          fontFamily: "Montserrat",
        );
  }

  static TextStyle fontHeadlineSmallW700DarkRed(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.darkRed,
          fontFamily: "Montserrat",
        );
  }

  static TextStyle fontTitleMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade900,
        );
  }

  static TextStyle fontBodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600,
        );
  }

  static TextStyle fontTitleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );
  }
}
