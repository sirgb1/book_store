import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartProvider with ChangeNotifier {
  List<Book> _cart = [];

  List<Book> get cart => _cart;

  double get totalPrice => _cart.fold(0, (sum, book) => sum + book.price);

  void addBook(Book book) {
    _cart.add(book);
    notifyListeners();
  }

  void removeBook(Book book) {
    _cart.remove(book);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
