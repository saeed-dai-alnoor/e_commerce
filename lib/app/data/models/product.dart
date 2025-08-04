class Product {
  final String name;
  final String title;
  final String image;
  final String price;
  final String category; // ✅ التصنيف

  Product({
    required this.name,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
  });
  // إذا تستخدم fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      title: json['title'],
      category: json['category'],
      image: json['image'],
      price: json['price']?.toDouble() ?? 0.0,
    );
  }
}
