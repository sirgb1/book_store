class Book {
  final String title;
  final String author;
  final String genre;
  final double price;
  final String coverImageUrl;
  final String description;
  final bool inStock;

  Book({
    required this.title,
    required this.author,
    required this.genre,
    required this.price,
    required this.coverImageUrl,
    required this.description,
    required this.inStock
  });
}