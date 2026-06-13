import 'package:flutter/material.dart';
import 'package:virtual_store_demo/features/cart/domain/models/cart_item_model.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel cartItem;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  const CartItemCard({
    super.key,
    required this.cartItem,
    this.onDecrease,
    this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: product.imageUrl.isNotEmpty
              ? Image.network(
            product.imageUrl,
            width: 58,
            height: 58,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const _ImageError();
            },
          )
              : const _ImageError(),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: AppTextStyles.descriptionTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Text(
                'S/ ${product.price.toStringAsFixed(2)}',
                style: AppTextStyles.descriptionTextStyle,
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  _QuantityButton(
                    text: '-',
                    onTap: onDecrease,
                  ),
                  Container(
                    height: 24,
                    width: 34,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      cartItem.quantity.toString(),
                      style: AppTextStyles.descriptionTextStyle,
                    ),
                  ),
                  _QuantityButton(
                    text: '+',
                    onTap: onIncrease,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Text(
          'S/ ${cartItem.getSubtotal().toStringAsFixed(2)}',
          style: AppTextStyles.descriptionTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _QuantityButton({
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 30,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.descriptionTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      color: AppColors.neutralColor.withValues(alpha: 0.25),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 28,
      ),
    );
  }
}