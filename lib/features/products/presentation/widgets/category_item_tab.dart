import 'package:flutter/material.dart';
import 'package:virtual_store_demo/features/products/domain/models/category_model.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class CategoryItemTab extends StatelessWidget {
  final CategoryModel category;
  const CategoryItemTab({super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 60,
        width: 164,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 4,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(category.imageUrl, width: 40, height: 40,)),
              Text(category.name, style: AppTextStyles.categoryTextStyle,)
            ],
          ),
        ),
      ),
    );
  }
}