import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AppAppBar({super.key, this.hasLeading = false});
  final bool hasLeading;

  @override
  State<AppAppBar> createState() => _AppAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(64);
}

class _AppAppBarState extends State<AppAppBar> {
  // String name = "Test"; //Todo
  // void getUserName() async {
  //   name = await AuthServicesImpl().getUserName();
  //   setState(() {});
  //   debugPrint("getUserName: $name");
  // }

  @override
  void initState() {
    super.initState();
    // getUserName();
  }

  @override
  Widget build(BuildContext context) {
    // final authCubit = BlocProvider.of<AuthCubit>(context);
    final name = context.read<AuthCubit>().user.name;

    final size = MediaQuery.of(context).size;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: size.height * 0.06,
      backgroundColor: AppColors.red,
      title: Image.asset(
        "assets/images/logo.png",
        height: size.height * 0.05,
      ),
      leading: !widget.hasLeading
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
              ),
            ),
      actions: !widget.hasLeading
          ? []
          : [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    Text(
                      // "Welcome ${authCubit.getCurrentUser()?.displayName ?? "Aya"}",
                      // "Welcome ${AuthServicesImpl().getUserName()} ",
                      "Welcome $name",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      " 😊",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
    );
  }
}
