// import 'dart:math';

// import 'package:carwan_dough/utils/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class SignupPage extends StatelessWidget {
//   const SignupPage({super.key});

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
//                   Color(0xFFD81B32),
//                   Color(0xFFEB2222),
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
//           Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 420,
//               ),
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: size.width * 0.05,
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
//                         "Signup",
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                               color: AppColors.darkRed,
//                               fontFamily: "Montserrat",
//                             ),
//                       ),
//                       SizedBox(
//                         height: 42,
//                         child: TextFormField(
//                           decoration: InputDecoration(labelText: "Name"),
//                         ),
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
//                           decoration: InputDecoration(labelText: "email"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 42,
//                         child: TextFormField(
//                           decoration: InputDecoration(labelText: "Password"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 42,
//                         child: TextFormField(
//                           decoration: InputDecoration(labelText: "Enter password again"),
//                         ),
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.darkRed,
//                             foregroundColor: AppColors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text("Create account"),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           "Or Login",
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
