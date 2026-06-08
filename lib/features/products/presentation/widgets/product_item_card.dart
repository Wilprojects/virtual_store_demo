import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store_demo/features/products/domain/models/product_model.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProductItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  const ProductItemCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: product.imageUrl.isNotEmpty? Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace){
                        return _ImageError();
                      }
                  ) : _ImageError(),
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: AppTextStyles.descriptionTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8
              ),
              child: Text(
                'S/ ${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.descriptionTextStyle.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            )
          ],
        ),
      )
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
          size: 40,
        ),
      ),
    );
  }
}