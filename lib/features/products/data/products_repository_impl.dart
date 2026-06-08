import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_store_demo/features/products/domain/models/category_model.dart';
import 'package:virtual_store_demo/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final FirebaseFirestore firestore;

  ProductsRepositoryImpl({required this.firestore});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await firestore.collection('categories').get();

    return snapshot.docs.map((doc){
      return CategoryModel(
        id: doc.id,
        name: doc['name'],
        imageUrl: doc['image_url'],
      );
    }).toList();
  }
}