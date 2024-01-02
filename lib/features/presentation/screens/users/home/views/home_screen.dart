import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/core/constants/app_images.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      appBar: AppBar(
        backgroundColor: AppColors.kF5F5F5,
        leading: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: AppColors.kDEDBDB,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                AppAssets.menu,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              height: 32,
              width: 40,
            ),
            10.horizontalSpace,
            const Text(
              'Glam Cart',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.k4392F9,
                fontSize: 20,
                fontFamily: 'Libre Caslon Text',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Image.asset(
              AppAssets.profile,
              height: 40,
              width: 40,
            ),
          )
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: controller.isLoading()
              ? const CircularProgressIndicator(
                  color: AppColors.kF83758,
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTextFormField(
                        name: 'search',
                        fillColor: AppColors.kFFFFFF,
                        hintText: 'Search any Product..',
                        hintStyle: TextStyle(
                          color: Color(0xFFBBBBBB),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        preFixIcon: Icon(
                          Icons.search,
                          size: 24,
                          color: AppColors.kBBBBBB,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          size: 24,
                          color: AppColors.kBBBBBB,
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'All Featured',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              MainButton.icon(
                                onPressed: () {},
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    Icons.compare_arrows,
                                    size: 20,
                                    color: AppColors.k000000,
                                  ),
                                ),
                                text: 'Sort',
                                fontSize: 12,
                                minimumSize: const Size(60, 25),
                                hasBottomMargin: false,
                                buttonColor: AppColors.kBBBBBB,
                                fontColor: AppColors.k000000,
                              ),
                              12.horizontalSpace,
                              MainButton.icon(
                                onPressed: () {},
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    Icons.filter_list_alt,
                                    size: 16,
                                    color: AppColors.k000000,
                                  ),
                                ),
                                text: 'Filter',
                                fontSize: 12,
                                minimumSize: const Size(60, 25),
                                hasBottomMargin: false,
                                buttonColor: AppColors.kBBBBBB,
                                fontColor: AppColors.k000000,
                              ),
                            ],
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Container(
                        height: 90,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 55,
                                height: 55,
                                decoration: const ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://media6.ppl-media.com/tr:h-750"
                                      ",w-750,c-at_max,dpr-2/static/img/"
                                      "product/342282/swiss-beauty-love-all"
                                      "-makeup-kit-matte-liquid-lipstick-lift"
                                      "-and-curl-mascara-cheek-a-boo-with-free"
                                      "-pouch_7_display_1672207559_f6411a4c.jpg",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: OvalBorder(),
                                ),
                              ),
                              4.verticalSpace,
                              const Text(
                                'Beauty',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF21003D),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) =>
                              10.horizontalSpace,
                          itemCount: 5,
                        ),
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: PageView.builder(
                            controller: controller.pageController,
                            itemCount: 3,
                            itemBuilder: (context, index) => CachedNetworkImage(
                              imageUrl:
                                  'https://img.freepik.com/free-vector/gradient-sale'
                                  '-background_23-2148934477.jpg?size=626&ext='
                                  'jpg&ga=GA1.1.1546980028.1704153600&semt=ais',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      Center(
                        child: SmoothPageIndicator(
                          controller: controller.pageController,
                          count: 3,
                          effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            type: WormType.thinUnderground,
                            activeDotColor: AppColors.kF83758,
                            dotColor: AppColors.kDEDBDB,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          _buildProductCard(),
                          12.horizontalSpace,
                          _buildProductCard(),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Expanded(
      child: Container(
        width: 170,
        decoration: ShapeDecoration(
          color: AppColors.kFFFFFF,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: 'https://images.unsplash.com/photo-1581338834647'
                    '-b0fb40704e21?q=80&w=1000&auto=format&fit=crop'
                    '&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3'
                    'x8ZmFzaGlvbiUyMG1vZGVsfGVufDB8fDB8fHww',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            5.verticalSpace,
            Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Women Printed Shirt',
                      style: TextStyle(
                        color: AppColors.k000000,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  4.verticalSpace,
                  const Text(
                    'Neque porro quisquam est qui dolorem ipsum quia',
                    style: TextStyle(
                      color: AppColors.k000000,
                      fontSize: 10,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  4.verticalSpace,
                  const Text(
                    '₹1500',
                    style: TextStyle(
                      color: AppColors.k000000,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      const Text(
                        '₹2499',
                        style: TextStyle(
                          color: AppColors.kBBBBBB,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.kBBBBBB,
                        ),
                      ),
                      5.horizontalSpace,
                      const Text(
                        '40%Off',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFE735C),
                          fontSize: 10,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RatingBar(
                        itemSize: 15,
                        itemCount: 5,
                        allowHalfRating: false,
                        unratedColor: AppColors.kBBBBBB,
                        glowColor: AppColors.kF83758,
                        initialRating: 4,
                        ratingWidget: RatingWidget(
                          full: const Icon(
                            Icons.star,
                            color: AppColors.kEDB310,
                          ),
                          half: const Icon(Icons.star),
                          empty: const Icon(Icons.star_outline),
                        ),
                        onRatingUpdate: (value) {},
                      ),
                      5.horizontalSpace,
                      const Text(
                        '56890',
                        style: TextStyle(
                          color: Color(0xFFA4A9B3),
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// const Center(
// child: Text('Home'),
// ),
// MainButton(
// onPressed: () async {
// await controller.logoutUser();
// },
// text: 'Logout',
// ),
// https://img.freepik.com/free-photo/cute-woman-bright-hat-purple-blouse-is-leaning-stand-with-dresses-posing-with-package-isolated-background_197531-17610.jpg
// https://images.unsplash.com/photo-1581338834647-b0fb40704e21?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8ZmFzaGlvbiUyMG1vZGVsfGVufDB8fDB8fHww
