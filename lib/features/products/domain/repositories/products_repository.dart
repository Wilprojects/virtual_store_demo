import 'package:virtual_store_demo/features/products/domain/models/category_model.dart';
import 'package:virtual_store_demo/features/products/domain/models/product_model.dart';

abstract class ProductsRepository {
  Future<List<CategoryModel>> getCategories();

  Future<List<ProductModel>> getProducts();
}