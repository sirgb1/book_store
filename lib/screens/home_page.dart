import 'package:flutter/material.dart';
import '../data/dummy_books.dart';
import 'book_details_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;  // Track the current index for the BottomNavigationBar

  // Pages to switch between
  final List<Widget> _pages = [
    BookListPage(),  // Home Page content
    CartPage(),
    ProfilePage() // Placeholder for Cart Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookstore')),
      body: _pages[_currentIndex],  // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  // Current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Update index when tapped
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Extracted the book list into a separate widget for better organization
class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyBooks.length,
      itemBuilder: (ctx, index) {
        final book = dummyBooks[index];
        return ListTile(
          leading: Image.network(book.coverImageUrl, width: 50, height: 50),
          title: Text(book.title),
          subtitle: Text(book.author),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(book: book),
              ),
            );
          },
        );
      },
    );
  }
}
