import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_store_demo/common/widgets/screens/loading_screen.dart';
import 'package:virtual_store_demo/common/widgets/text_fields/primary_text_field.dart';
import 'package:virtual_store_demo/features/products/presentation/providers/products_providers.dart';
import 'package:virtual_store_demo/features/products/presentation/widgets/category_item_tab.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProductsSection extends ConsumerWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final searchProductController = TextEditingController();
    final categoriesAsyncValue = ref.watch(categoriesProvider);



    return categoriesAsyncValue.when(
        data: (categoriesList) {

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                PrimaryTextField(
                    suffixIcon: Icons.search,
                    hintText: 'Buscar productos',
                    labelText: 'Buscar productos',
                    controller: searchProductController),
                Text('Categorías', style: AppTextStyles.buttonTextStyle,),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesList.length,
                      itemBuilder: (context, index) {

                        final category = categoriesList[index];

                        return CategoryItemTab(category: category);
                      }),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error al cargar las categorías')),
        loading: () => const LoadingScreen());
  }
}