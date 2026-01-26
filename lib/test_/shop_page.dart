// import 'package:carwan_dough/utils/theme/app_colors.dart';
// import 'package:carwan_dough/cart_page.dart';
// import 'package:carwan_dough/home_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ShopPage extends StatelessWidget {
//   const ShopPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: size.height * 0.06,
//         backgroundColor: AppColors.red,
//         title: Image.asset(
//           "assets/images/logo.png",
//           height: size.height * 0.05,
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.white,
//           ),
//         ),
//         actions: [
//           Text(
//             "Welcome Aya",
//             style: TextStyle(
//               color: AppColors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 CupertinoPageRoute<void>(
//                   builder: (context) => const CartPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.article, color: AppColors.white),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 CupertinoPageRoute<void>(
//                   builder: (context) => const ShopPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.shopping_basket, color: AppColors.white),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Image.asset(
//             "assets/images/waves.png",
//             width: double.infinity,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: HeaderWithLine(title: "Custom orders"),
//           ),
//           Text(
//             "Active Orders",
//             style: TextStyle(
//               color: AppColors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Text(
//             "You have no active orders.",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AppColors.grey,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Text(
//             "Past Orders",
//             style: TextStyle(
//               color: AppColors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Card(
//             color: AppColors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               spacing: 6,
//               children: [
//                 Text(
//                   "Order #411",
//                   style: TextStyle(
//                     color: AppColors.black,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   "Delivery: 23 jan 2026",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: AppColors.grey,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   "Cinnamon Cup x2 - 120 EGP",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: AppColors.black,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   "Total: 240 EGP",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: AppColors.grey,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Footer(),
//         ],
//       ),
//     );
//   }
// }
