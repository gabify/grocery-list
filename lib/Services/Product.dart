class Product {
  int? id;
  String productName;
  double price;
  String category;

  Product({
    this.id,
    required this.productName,
    required this.price,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> product) {
    return Product(
      id: product['id'],
      productName: product['product_name'],
      price: product['price'],
      category: product['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'product_name': productName, 'price': price, 'category': category};
  }
}
