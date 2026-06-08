import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_store_demo/common/widgets/screens/loading_screen.dart';
import 'package:virtual_store_demo/common/widgets/text_fields/primary_text_field.dart';
import 'package:virtual_store_demo/features/products/presentation/providers/products_providers.dart';
import 'package:virtual_store_demo/features/products/presentation/screens/product_detail_screen.dart';
import 'package:virtual_store_demo/features/products/presentation/widgets/category_item_tab.dart';
import 'package:virtual_store_demo/features/products/presentation/widgets/product_item_card.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class ProductsSection extends ConsumerStatefulWidget {
  const ProductsSection({super.key});

  @override
  ConsumerState<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends ConsumerState<ProductsSection> {
  final searchProductController = TextEditingController();

  String searchText = '';
  String? selectedCategoryId;

  @override
  void dispose() {
    searchProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
            onChanged: (value) {
              setState(() {
                searchText = value.trim().toLowerCase();
              });
            },
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

                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          if(selectedCategoryId == category.id){
                            selectedCategoryId = null;
                          } else {
                            selectedCategoryId = category.id;
                          }
                        });
                      },
                      child: CategoryItemTab(category: category),
                    );
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
                final filteredProducts = productsList.where((product){
                  final matchesSearch = searchText.isEmpty ||
                      product.name.toLowerCase().contains(searchText) ||
                      product.description.toLowerCase().contains(searchText);

                  final matchesCategory = selectedCategoryId == null ||
                      product.categoryId == selectedCategoryId;

                  return matchesSearch && matchesCategory;
                }).toList();

                if(filteredProducts.isEmpty){
                  return const Center(
                    child: Text('No se encontraron productos'),
                  );
                }

                return GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.75
                  ),
                  itemBuilder: (context, index){
                    final product = filteredProducts[index];

                    return ProductItemCard(
                      product: product,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product),
                          )
                        );
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