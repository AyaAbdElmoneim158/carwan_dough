import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/controllers/cart/cart_cubit.dart';
import 'package:carwan_dough/controllers/home/home_cubit.dart';
import 'package:carwan_dough/models/menu_model.dart';
import 'package:carwan_dough/services/cart_services.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/pages/menu_details_page.dart';
import 'package:carwan_dough/views/widgets/app_app_bar.dart';
import 'package:carwan_dough/views/widgets/banner_with_waves.dart';
import 'package:carwan_dough/views/widgets/footer.dart';
import 'package:carwan_dough/views/widgets/header_with_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeCubit>().fetchMenu();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    bool isAdmin = context.read<AuthCubit>().user.role == Role.admin;

    return Scaffold(
      appBar: AppAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWithWaves(),
            HeaderWithLine(title: "Our Menu"),
            BlocBuilder(
              bloc: homeCubit,
              buildWhen: (previous, current) => current is FetchingMenuLoading || current is MenuFetched || current is FetchingMenuFailure,
              builder: (context, state) {
                if (state is FetchingMenuLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(3, (index) => ShimmerMenuItem()),
                    ),
                  );
                } else if (state is FetchingMenuFailure) {
                  return MenuFailure(error: state.error);
                } else if (state is MenuFetched) {
                  final menu = state.menu ?? [];
                  if (menu.isEmpty) {
                    return EmptyMenu();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(
                        menu.length,
                        (index) => MenuItem(item: menu[index]),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            SizedBox(height: 16),
            if (isAdmin)
              Align(
                // alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        /*
                          ! Scenario.... popup dialog with form .... name + btn Add Item > 
                        */
                      },
                      child: const Text('Add New menu'),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 16),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class MenuFailure extends StatelessWidget {
  const MenuFailure({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image.asset(
          'assets/images/oops_2.png',
          fit: BoxFit.cover,
          height: size.height * 0.1,
        ),
        Text(
          "Oops..",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.red),
        ),
        Text(
          error,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

class EmptyMenu extends StatelessWidget {
  const EmptyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image.asset(
          "assets/images/empty_2.png",
          fit: BoxFit.cover,
          height: size.height * 0.1,
        ),
        Text(
          "Menu is Empty!",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: AppColors.grey,
              ),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.item});
  final MenuModel item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<void>(
            //Todo: Warp with cartCubit.... move as routing
            builder: (context) => BlocProvider(
              create: (context) => CartCubit(
                CartServicesImpl(context.read<AuthCubit>().user.uid),
              ),
              child: MenuDetailsPage(menu: item),
            ),

            // MenuDetailsPage(menu: item),
          ),
        );
      },
      child: SizedBox(
        width: size.width * 0.45,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(216, 27, 50, 0.3),
                offset: const Offset(0, 8),
                blurRadius: 12,
              ),
            ],
          ),
          child: Card(
            color: AppColors.darkRed,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 8),
                Text(
                  item.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: size.height * 0.22,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    ),
                    items: item.images.isNotEmpty
                        ? item.images.map<Widget>((image) {
                            return buildImage(image);
                          }).toList()
                        : [
                            buildImage(
                              'https://cdn-icons-png.flaticon.com/512/16750/16750721.png',
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildImage(String image) {
  final isNetwork = image.startsWith('http');

  if (isNetwork) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (_, __) => const Center(child: CupertinoActivityIndicator()),
      errorWidget: (_, __, ___) => const Icon(Icons.broken_image_rounded, size: 32),
    );
  } else {
    return Image.asset(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image_rounded, size: 32),
    );
  }
}

class ShimmerMenuItem extends StatelessWidget {
  const ShimmerMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final baseColor = AppColors.darkRed.withOpacity(0.6);
    final highlightColor = AppColors.darkRed.withOpacity(0.35);
    final shimmerItemColor = theme.cardColor.withOpacity(0.25);

    return SizedBox(
      width: size.width * 0.45,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(216, 27, 50, 0.35),
              offset: Offset(-5, 5),
            ),
            BoxShadow(
              color: Color.fromRGBO(216, 27, 50, 0.25),
              offset: Offset(-10, 10),
            ),
            BoxShadow(
              color: Color.fromRGBO(216, 27, 50, 0.15),
              offset: Offset(-15, 15),
            ),
          ],
        ),
        child: Card(
          color: AppColors.darkRed,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 8),

                /// Title shimmer
                Container(
                  height: 20,
                  width: size.width * 0.26,
                  decoration: BoxDecoration(
                    color: shimmerItemColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const SizedBox(height: 8),

                /// Image shimmer
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Container(
                    height: size.height * 0.22,
                    width: double.infinity,
                    color: shimmerItemColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
