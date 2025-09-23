class Product {
  int? id;
  String productName;
  double price;
  String category;
  bool isSelected;

  Product({
    this.id,
    required this.productName,
    required this.price,
    required this.category,
    this.isSelected = false,
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
