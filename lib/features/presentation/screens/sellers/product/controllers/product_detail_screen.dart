import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import '../controllers/product_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends GetView<ProductController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(
      viewportFraction: 1.0,
      keepPage: true,
    );
    final product = Get.arguments;

    // Schedule the container initialization after the current build
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (product.productImages.isNotEmpty) {
          controller.initializeImageContainers(product.productImages);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products Details',
          style: TextStyle(
            color: AppColors.kFFFFFF,
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.kF83758,
        centerTitle: true,
      ),
      backgroundColor: AppColors.kF5F5F5,
      body: Obx(
        () => SafeArea(
          child: controller.isLoading()
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kF83758,
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: product.productImages.length,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: product.productImages[index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      12.verticalSpace,
                      Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: product.productImages.length,
                          effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            type: WormType.thinUnderground,
                            activeDotColor: AppColors.kF83758,
                            dotColor: AppColors.kDEDBDB,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        product.productName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        '₹${product.price}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      8.verticalSpace,
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: product.description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const TextSpan(
                              text: '...',
                              style: TextStyle(
                                color: Color(0xFF828282),
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const TextSpan(
                              text: 'More',
                              style: TextStyle(
                                color: Color(0xFFF97189),
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: MainButton(
              margin: const EdgeInsets.only(left: 35),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(
                      child: Text(
                        'Delete Confirmation',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    content: const Text(
                      'Are you sure tha you want \nto delete the product?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: MainButton(
                              onPressed: () {
                                controller.deleteProduct(product.productId);
                              },
                              text: 'Yes',
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                            child: MainButton(
                              onPressed: () {
                                Get.back();
                              },
                              text: 'No',
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              buttonColor: AppColors.kFFFFFF,
              fontColor: AppColors.k000000,
              text: 'Delete',
              borderRadius: BorderRadius.circular(12),
              hasBottomMargin: false,
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: MainButton(
              onPressed: () {
                buildShowModalBottomSheet(context, product);
              },
              text: 'Update',
              borderRadius: BorderRadius.circular(12),
              hasBottomMargin: false,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context, product) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.kF5F5F5),
          child: Obx(
            () {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageContainers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => controller.pickImage(index),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: controller.imageContainers[index],
                                ),
                              );
                            },
                          ),
                        ),
                        30.verticalSpace,
                        FormBuilder(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              _buildTextField(
                                label: 'Product Name',
                                name: 'productName',
                                initialValue: product.productName,
                                validate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter product name';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: 'Description',
                                name: 'description',
                                initialValue: product.description,
                                validate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter description';
                                  }
                                  return null;
                                },
                              ),
                              _buildTextField(
                                label: 'Price',
                                name: 'price',
                                initialValue: product.price,
                                validate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter price';
                                  }
                                  return null;
                                },
                              ),
                              10.verticalSpace,
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: _buildOutlineInputBorder(),
                                        focusedBorder:
                                            _buildOutlineInputBorder(),
                                        disabledBorder:
                                            _buildOutlineInputBorder(),
                                        enabledBorder:
                                            _buildOutlineInputBorder(),
                                        errorBorder: _buildOutlineInputBorder(),
                                        focusedErrorBorder:
                                            _buildOutlineInputBorder(),
                                      ),
                                      isExpanded: true,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.kF83758,
                                      ),
                                      value: controller.selectedCategory.value,
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          controller.selectedCategory.value =
                                              newValue;
                                          controller.update();
                                        }
                                      },
                                      items: controller.items
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: MainButton(
                  margin: const EdgeInsets.only(left: 35),
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      if (controller.selectedImages.isEmpty) {
                        Get.snackbar(
                          'Failure',
                          'Please upload a image',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.kFF4B26,
                          colorText: AppColors.kFFFFFF,
                        );
                      } else {
                        await controller.updateProduct(product.productId);
                        Get.close(1);
                      }
                    }
                  },
                  text: 'Update Product',
                  hasBottomMargin: false,
                  isLoading: controller.isLoading.value,
                ),
              );
            },
          ),
        );
      },
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.kC7C7C7,
      ),
    );
  }

  Column _buildTextField({
    required String label,
    required String name,
    required String initialValue,
    required String? Function(dynamic)? validate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        5.verticalSpace,
        AppTextFormField(
          name: name,
          hintText: label,
          initialValue: initialValue,
          hintStyle: const TextStyle(
            color: AppColors.kC7C7C7,
          ),
          validate: validate,
        ),
        10.verticalSpace,
      ],
    );
  }
}
