import 'package:virtual_store_demo/features/products/domain/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  double getSubtotal() {
    return product.price * quantity;
  }

  CartItemModel copyWith({ProductModel? product, int? quantity,}){
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}