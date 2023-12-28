import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import '../controllers/product_controller.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [Center(child: Text('Product'))],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: AppColors.kF5F5F5),
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
                        10.verticalSpace,
                        AppTextFormField(name: 'product')
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: AppColors.kF83758,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
