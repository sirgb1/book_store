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
  int _currentIndex = 0; // Track the current index for the BottomNavigationBar

  // Pages to switch between
  final List<Widget> _pages = [
    BookListPage(), // Home Page content
    CartPage(),
    ProfilePage(), // Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('КНИГОГРАД'),
      ),
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update index when tapped
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

// Modified BookListPage to include the search bar and search functionality
class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Filter books based on the search query
    final filteredBooks = dummyBooks
        .where((book) => book.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Поиск книг по названию...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
              childAspectRatio: 0.65, // Aspect ratio for the grid items
            ),
            itemCount: filteredBooks.length,
            itemBuilder: (ctx, index) {
              final book = filteredBooks[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BookDetailsPage(book: book),
                    ),
                  );
                },
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          book.coverImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          book.author,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${book.price.toString()} ₽',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
