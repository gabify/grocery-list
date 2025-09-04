class Groceryitem {
  int? id;
  String name;
  double estimatedPrice;
  double? actualPrice;
  int quantity;

  Groceryitem({
    this.id,
    this.actualPrice,
    required this.name,
    required this.estimatedPrice,
    required this.quantity,
  });
}
