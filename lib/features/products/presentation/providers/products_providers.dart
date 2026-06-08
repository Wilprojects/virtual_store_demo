import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_store_demo/features/products/data/products_repository_impl.dart';
import 'package:virtual_store_demo/features/products/domain/models/category_model.dart';
import 'package:virtual_store_demo/features/products/domain/repositories/products_repository.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
        (ref) => FirebaseFirestore.instance
);

final productsRepositoryProvider = Provider<ProductsRepository>(
        (ref) => ProductsRepositoryImpl(firestore: ref.read(firebaseFirestoreProvider))
);

final categoriesProvider = FutureProvider<List<CategoryModel>>(
        (ref) => ref.watch(productsRepositoryProvider).getCategories()
);
