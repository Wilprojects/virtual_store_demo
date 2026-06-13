import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:virtual_store_demo/features/cart/domain/models/cart_item_model.dart';
import 'package:virtual_store_demo/features/products/domain/models/product_model.dart';

final cartProvider = StateProvider<List<CartItemModel>>((ref) => []);

void addProductToCart(WidgetRef ref, ProductModel product){
  final currentCart = ref.read(cartProvider);
  final productIndex = currentCart.indexWhere(
    (cartItem) => cartItem.product.id == product.id
  );

  if(productIndex >= 0){
    final updateCart = [...currentCart];
    final currentItem = updateCart[productIndex];

    updateCart[productIndex] = currentItem.copyWith(
      quantity: currentItem.quantity + 1
    );

    ref.read(cartProvider.notifier).state = updateCart;

  } else {
    ref.read(cartProvider.notifier).state = [
      ...currentCart, CartItemModel(product: product, quantity: 1)
    ];
  }
}

void increaseProductQuantity(WidgetRef ref, ProductModel product){
  final currentCart = ref.read(cartProvider);

  final updateCart = currentCart.map((cartItem){
    if(cartItem.product.id == product.id){
      return cartItem.copyWith(
        quantity: cartItem.quantity + 1
      );
    }
    return cartItem;
  }).toList();

  ref.read(cartProvider.notifier).state = updateCart;
}

void decreaseProductQuantity(WidgetRef ref, ProductModel product){
  final currentCart = ref.read(cartProvider);

  final updateCart = currentCart.map((cartItem){
    if(cartItem.product.id == product.id){
      return cartItem.copyWith(
        quantity: cartItem.quantity - 1
      );
    }

    return cartItem;
  }).where((cartItem) => cartItem.quantity > 0).toList();

  ref.read(cartProvider.notifier).state = updateCart;
}

double getCartTotal(List<CartItemModel> cartItems ){
  return cartItems.fold<double>(
    0,
    (total, cartItem) => total + cartItem.getSubtotal(),
  );

}