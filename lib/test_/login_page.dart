// import 'dart:math';

// import 'package:carwan_dough/utils/theme/app_colors.dart';
// import 'package:carwan_dough/home_page.dart';
// import 'package:carwan_dough/signup_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
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
//                   // Color(0xFFE27777),
//                   Color(0xFFD81B32), Color(0xFFEB2222),

//                   // Color(0xFFF04E4E),
//                   // Color(0xFFE27777),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               "assets/images/logo.png",
//               height: size.height * 0.08,
//             ),
//           ),
//           // Text(
//           //   "sugar, spice and everything nice",
//           //   style: TextStyle(color: AppColors.white, fontSize: 24),
//           // ),
//           Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 420, // 👈 limits width on tablets/web
//               ),
//               child: Container(
//                 // width: size.width * 0.8,
//                 // height: size.height * 0.4,
//                 margin: EdgeInsets.symmetric(
//                   horizontal: size.width * 0.05,
//                   //   vertical: size.height * 0.3,
//                 ),
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
//                         "Login",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                               color: AppColors.darkRed,
//                               fontFamily: "Montserrat",
//                             ),
//                       ),
//                       SizedBox(
//                         height: 42,
//                         child: TextFormField(
//                           decoration: InputDecoration(labelText: "Phone"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 42,
//                         child: TextFormField(
//                           decoration: InputDecoration(labelText: "Password"),
//                         ),
//                       ),
//                       // ConstrainedBox(constraints: BoxConstraints())
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               CupertinoPageRoute<void>(
//                                 builder: (context) => const HomePage(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.darkRed,
//                             foregroundColor: AppColors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text("Login"),
//                         ),
//                       ),
//                       Text(
//                         "Forget password?",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                               color: AppColors.red,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: "Montserrat",
//                             ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             CupertinoPageRoute<void>(
//                               builder: (context) => const SignupPage(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           "Or Signup",
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                                 color: AppColors.red,
//                                 fontWeight: FontWeight.w500,
//                                 fontFamily: "Montserrat",
//                               ),
//                         ),
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
