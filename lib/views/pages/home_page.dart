import 'package:carwan_dough/controllers/home/home_cubit.dart';
import 'package:carwan_dough/models/menu_model.dart';
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerWithWaves(),
            HeaderWithLine(title: "Our Menu"),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CupertinoActivityIndicator()); //Todo: shimmer
                } else if (state is HomeError) {
                  return Column(
                    children: [
                      Image.network('https://cdn-icons-png.flaticon.com/512/4428/4428505.png'),
                      // https://cdn-icons-png.flaticon.com/512/17985/17985555.png
                      Text(
                        "Oops..",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.red),
                      ),
                      Text(
                        state.error,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  );
                } else if (state is HomeLoaded) {
                  final menu = state.menu;
                  if (menu.isEmpty) {
                    return Column(
                      children: [
                        Image.network(
                          // 'https://cdn-icons-png.flaticon.com/512/7486/7486747.png',
                          'https://cdn-icons-png.flaticon.com/512/12782/12782267.png',

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
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(
                        menu.length,
                        (index) {
                          final item = menu[index];
                          return MenuItem(item: item);
                        },
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),

            //Todo: Menu.card
            /* SizedBox(
              height: size.height * 0.45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(width: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: menuItems.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   CupertinoPageRoute<void>(
                    //     builder: (context) => const MenuDetailsPage(),
                    //   ),
                    // );
                  },
                  child: SizedBox(
                    width: size.width * 0.6,
                    // height: size.height * 0.4,
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(216, 27, 50, 0.4),
                          offset: Offset(-5, 5),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(216, 27, 50, 0.3),
                          offset: Offset(-10, 10),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(216, 27, 50, 0.2),
                          offset: Offset(-15, 15),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(216, 27, 50, 0.1),
                          offset: Offset(-20, 20),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(216, 27, 50, 0.05),
                          offset: Offset(-25, 25),
                        ),
                      ]),
                      child: Card(
                        color: AppColors.darkRed,
                        elevation: 0, // important
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: size.height * 0.012),
                            Text(
                              menuItems[index]["name"].toString(),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: size.height * 0.3,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 2),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                                ),
                                items: (item.images?)?.isNotEmpty == true
                                    ? (item.images).map((image) {
                                        return Image.asset(
                                          image,
                                          fit: BoxFit.cover,
                                          // width: double.infinity,
                                          // height: size.height * 0.2,
                                        );
                                      }).toList()
                                    : [
                                        Image.asset(
                                          "assets/images/banner.webp",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
*/
            /*
                        text-align: center;
          width: 100%;
          display: flex;
          flex-direction: column;
          align-items: center;
          border: 3px var(--dark-red) solid;
          border-radius: 10px;
          transition: 0.5s;
          box-shadow: rgba(216, 27, 50, 0.4) -5px 5px, rgba(216, 27, 50, 0.3) -10px 10px, rgba(216, 27, 50, 0.2) -15px 15px, rgba(216, 27, 50, 0.1) -20px 20px, rgba(216, 27, 50, 0.05) -25px 25px;
            }
        }
                 */
            SizedBox(height: 16),
            Footer(),
          ],
        ),
      ),
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
            builder: (context) => MenuDetailsPage(
              menu: item,
            ),
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
                    items: (item.images).isNotEmpty == true
                        ? (item.images)
                            .map(
                              (image) => Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList()
                        : [
                            Image.asset(
                              "assets/images/banner.webp",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
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
