import 'package:flutter/material.dart';
import 'package:virtual_store_demo/features/products/domain/models/product_model.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProductDetailScreen extends StatelessWidget{
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          product.name,
          style: AppTextStyles.buttonTextStyle.copyWith(
            color: AppColors.secondaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 310,
              width: double.infinity,
              child: product.imageUrl.isNotEmpty ?
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace){
                    return _ImageError();
                  },
                )
              : _ImageError(),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: AppTextStyles.descriptionTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Text(
                                'S/ ${product.price.toStringAsFixed(2)}',
                                style: AppTextStyles.buttonTextStyle.copyWith(
                                  fontSize: 15,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 88,
                          height: 38,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} agregado al carrito'
                                  ),
                                  duration: const Duration(seconds: 1),
                                )
                              );
                            },
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      product.description,
                      style: AppTextStyles.descriptionTextStyle.copyWith(
                        color: AppColors.secondaryColor,
                        height: 1.25,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Reseñas',
                      style: AppTextStyles.descriptionTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.neutralColor.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              color: AppColors.secondaryColor,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'user_name',
                                  style: AppTextStyles.descriptionTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                Text(
                                  '(4.5)',
                                  style: AppTextStyles.descriptionTextStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem...',
                                  style: AppTextStyles.descriptionTextStyle.copyWith(
                                    color: AppColors.secondaryColor,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutralColor.withValues(alpha: 0.25),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: AppColors.secondaryColor,
        ),
      )
    );
  }
}