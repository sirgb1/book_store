import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (ctx, index) {
                final book = cartProvider.cart[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text('${book.price.toString()} ₽'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cartProvider.removeBook(book);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Text('Сумма: ${cartProvider.totalPrice.toString()} ₽'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Clear the cart and show a pop-up window
              cartProvider.clearCart();

              // Show success dialog
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Успех'),
                  content: const Text('Покупка прошла успешно!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('ОК'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Оформить покупку'),
          ),
        ],
      ),
    );
  }
}
