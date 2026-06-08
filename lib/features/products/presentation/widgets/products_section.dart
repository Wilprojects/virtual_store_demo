import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_store_demo/common/widgets/screens/loading_screen.dart';
import 'package:virtual_store_demo/common/widgets/text_fields/primary_text_field.dart';
import 'package:virtual_store_demo/features/products/presentation/providers/products_providers.dart';
import 'package:virtual_store_demo/features/products/presentation/widgets/category_item_tab.dart';
import 'package:virtual_store_demo/features/products/presentation/widgets/product_item_card.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProductsSection extends ConsumerWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final searchProductController = TextEditingController();
    final categoriesAsyncValue = ref.watch(categoriesProvider);
    final productsAsyncValue = ref.watch(productsProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PrimaryTextField(
            suffixIcon: Icons.search,
            hintText: 'Buscar productos',
            labelText: 'Buscar productos',
            controller: searchProductController,
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categorías',
              style: AppTextStyles.buttonTextStyle,
            ),
          ),

          categoriesAsyncValue.when(
            data: (categoriesList){
              return SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index){
                    final category = categoriesList[index];
                    return CategoryItemTab(category: category);
                  },
                ),
              );
            },
            error: (error, stackTrace){
              return const Text('Error al cargar las categorías');
            },
            loading: (){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              'Todos los Productos',
              style: AppTextStyles.descriptionTextStyle.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: productsAsyncValue.when(
              data: (productsList){
                if(productsList.isEmpty){
                  return const Center(
                    child: Text('No hay productos disponibles'),
                  );
                }

                return GridView.builder(
                  itemCount: productsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.75
                  ),
                  itemBuilder: (context, index){
                    final product = productsList[index];

                    return ProductItemCard(
                      product: product,
                      onTap: (){
                        //Navegar al detalle del producto
                      }
                    );
                  },
                );
              },
              error: (error, stackTrace){
                return const Center(
                  child: Text('Error al cargar los productos'),
                );
              },
              loading: (){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          )
        ],
      ),
    );

    /*
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
        loading: () => const LoadingScreen()
    );
    */
  }
}