import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/up_down_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: size.height * 0.06,
        backgroundColor: AppColors.red,
        title: Image.asset(
          "assets/images/logo.png",
          height: size.height * 0.05,
        ),
        actions: [
          Text(
            "Welcome Aya",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute<void>(
              //     builder: (context) => const CartPage(),
              //   ),
              // );
            },
            icon: Image.asset(
              "assets/images/social/Cart.png",
              color: AppColors.white,
              height: 16,
              // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
            ),

            // Icon(Icons.article, color: AppColors.white),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute<void>(
              //     builder: (context) => const ShopPage(),
              //   ),
              // );
            },
            icon: SvgPicture.asset(
              "assets/images/social/reciept.svg",
              color: AppColors.white,
              height: 16,
              width: 12,
              // colorFilter:ColorFilter.mode(AppColors.white, BlendMode.clear) ,
            ),
            // Icon(Icons.shopping_basket, color: AppColors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SizedBox(height: 48),
            HeaderWithLine(title: "Our Menu"),
            //Todo: Menu.card
            SizedBox(
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
                    width: size.width * 0.4,
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
                                items: (menuItems[index]["images"] as List?)?.isNotEmpty == true
                                    ? (menuItems[index]["images"] as List).map((image) {
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

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.35,
      child: Column(
        // alignment: AlignmentDirectional.bottomEnd,
        // clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.05),
            decoration: BoxDecoration(
              color: AppColors.red,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "sugar, spice and\neverything nice",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/cake1.png",
                            height: size.height * 0.085,
                          ).upDown(
                            offset: 10,
                            duration: const Duration(seconds: 2),
                            // phase: 0.3,
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/images/cina3.png",
                            height: size.height * 0.085,
                          ).upDown(
                            offset: 12,
                            duration: const Duration(seconds: 2),
                            // phase: 0.6,
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/doug8.png",
                        height: size.height * 0.085,
                      ).upDown(
                        offset: 14,
                        duration: const Duration(seconds: 2),
                        // phase: 0.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: -68,
          //   left: 0,
          //   right: 0,
          //   child:
          // )
          Image.asset(
            "assets/images/waves.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

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
          spacing: 12,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.03,
            ),
            Text(
              "Contact Us",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
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
            Text(
              "Follow Us",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
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
          style: TextStyle(
            color: AppColors.darkRed,
            fontSize: 42,
            fontWeight: FontWeight.w100,
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
