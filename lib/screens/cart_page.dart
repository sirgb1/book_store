import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (ctx, index) {
                final book = cartProvider.cart[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text('\$${book.price.toString()}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cartProvider.removeBook(book);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text('Total: \$${cartProvider.totalPrice.toString()}'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {}, // Placeholder for checkout
            child: Text('Proceed to Checkout'),
          ),
        ],
      ),
    );
  }
}
