import 'package:virtual_store_demo/features/products/domain/models/category_model.dart';

abstract class ProductsRepository {
  Future<List<CategoryModel>> getCategories();
}