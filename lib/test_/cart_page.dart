// import 'dart:math';
// https://cdn-icons-png.flaticon.com/512/13543/13543366.png
// https://cdn-icons-png.flaticon.com/512/16854/16854867.png
// import 'package:carwan_dough/utils/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: size.height * 0.08,
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
//       ),
//       body: Stack(
//         alignment: AlignmentDirectional.topStart,
//         children: [
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 transform: const GradientRotation(75 * pi / 180),
//                 colors: const [
//                   Color(0xFFD81B32),
//                   Color(0xFFEB2222),
//                 ],
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Image.asset(
//           //     "assets/images/logo.png",
//           //     height: size.height * 0.08,
//           //   ),
//           // ),
//           Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 420,
//               ),
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                 padding: EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   // boxShadow:
//                 ),
//                 child: Form(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     spacing: 16,
//                     children: [
//                       Text(
//                         "Your Cart",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                               color: AppColors.darkRed,
//                               fontFamily: "Montserrat",
//                             ),
//                       ),
//                       Text(
//                         "You need to buy somethings!",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                               color: AppColors.darkRed,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Montserrat",
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
