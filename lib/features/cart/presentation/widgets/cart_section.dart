import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_store_demo/common/widgets/buttons/primary_button.dart';
import 'package:virtual_store_demo/features/cart/presentation/providers/cart_providers.dart';
import 'package:virtual_store_demo/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:virtual_store_demo/features/home/presentation/providers/home_providers.dart';
import 'package:virtual_store_demo/styles/app_colors.dart';
import 'package:virtual_store_demo/styles/text_styles.dart';

class CartSection extends ConsumerWidget {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = getCartTotal(cartItems);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(homeStateProvider.notifier).state = 'home';
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.secondaryColor,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                'Carrito',
                style: AppTextStyles.buttonTextStyle,
              ),
            ],
          ),

          const SizedBox(height: 24),

          Expanded(
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                'Tu carrito está vacío',
                style: AppTextStyles.descriptionTextStyle,
              ),
            )
                : ListView.separated(
              itemCount: cartItems.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 32,
                  color: AppColors.secondaryColor.withValues(alpha: 0.35),
                );
              },
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];

                return CartItemCard(
                  cartItem: cartItem,
                  onDecrease: () {
                    decreaseProductQuantity(
                      ref,
                      cartItem.product,
                    );
                  },
                  onIncrease: () {
                    increaseProductQuantity(
                      ref,
                      cartItem.product,
                    );
                  },
                );
              },
            ),
          ),

          PrimaryButton(
            text: 'IR A PAGAR S/ ${total.toStringAsFixed(2)}',
            onTap: () {
              if (cartItems.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Agrega productos al carrito'),
                  ),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidad de pago pendiente'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}