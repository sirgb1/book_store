import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage({required this.book});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.coverImageUrl, height: 200),
            SizedBox(height: 16),
            Text(book.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('by ${book.author}', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 16),
            Text(book.description),
            SizedBox(height: 16),
            Text('\$${book.price.toString()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                cartProvider.addBook(book);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to cart!')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
