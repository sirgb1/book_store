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
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(color: Colors.white), // AppBar text color
        ),
        backgroundColor: const Color(0xFF6D4C41), // Cozy dark brown color
      ),
      body: Container(
        color: const Color(0xFFFFF3E0), // Warm, soft beige background
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    book.coverImageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title with conditional color
              Text(
                book.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Warm black for readability
                ),
              ),
              Text(
                book.author,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.brown,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                book.genre,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8D6E63), // Warm brown shade
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5, // Increase line height for better readability
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${book.price.toString()} ₽',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4E342E), // Rich dark brown
                ),
              ),

              // If the book is not in stock, display a message
              if (!book.inStock)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Нет в наличии',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const Spacer(),

              // "Добавить в корзину" button
              ElevatedButton(
                onPressed: () {
                  if (book.inStock) {
                    // Add to cart if the book is in stock
                    cartProvider.addBook(book);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Добавлено к корзину!'),
                        backgroundColor: Color(0xFF6D4C41), // Dark brown background
                      ),
                    );
                  } else {
                    // Show a popup if the book is not in stock
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFFFFF8E1), // Light beige background
                        title: const Text(
                          'Недоступно',
                          style: TextStyle(color: Color(0xFF4E342E)), // Dark brown title color
                        ),
                        content: const Text(
                          'Книга не в наличии и не может быть добавлена в корзину.',
                          style: TextStyle(color: Colors.black87),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'ОК',
                              style: TextStyle(color: Color(0xFF6D4C41)), // Dark brown button text
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8D6E63), // Warm brown button color
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Добавить в корзину',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
