import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
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
            children: [
              Center(
                child: Text('Product'),
              ),
            ],
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
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child:
                                            controller.imageContainers[index],
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
                                      validate: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter product name';
                                        }
                                        return null;
                                      },
                                    ),
                                    _buildTextField(
                                      label: 'Description',
                                      name: 'description',
                                      validate: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Please enter description';
                                        }
                                        return null;
                                      },
                                    ),
                                    _buildTextField(
                                      label: 'Price',
                                      name: 'price',
                                      validate: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
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
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              border:
                                                  _buildOutlineInputBorder(),
                                              focusedBorder:
                                                  _buildOutlineInputBorder(),
                                              disabledBorder:
                                                  _buildOutlineInputBorder(),
                                              enabledBorder:
                                                  _buildOutlineInputBorder(),
                                              errorBorder:
                                                  _buildOutlineInputBorder(),
                                              focusedErrorBorder:
                                                  _buildOutlineInputBorder(),
                                            ),
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: AppColors.kF83758,
                                            ),
                                            value:
                                                controller.selectedValue.value,
                                            onChanged: (newValue) {
                                              controller.selectedValue.value =
                                                  newValue!;
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
                        onPressed: () {
                          if (controller.formKey.currentState?.validate() ??
                              false) {
                            if (controller.selectedImages.isEmpty) {
                              Get.snackbar(
                                'Failure',
                                'Please upload a image',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.kFF4B26,
                                colorText: AppColors.kFFFFFF,
                              );
                            } else {
                              Get.snackbar(
                                'Success',
                                'message',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }
                        },
                        text: 'Add Product',
                        hasBottomMargin: false,
                      ),
                    );
                  },
                ),
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
