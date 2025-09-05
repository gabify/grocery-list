class Groceryitem {
  int? id;
  int? groceryList_id;
  String name;
  double estimatedPrice;
  double? actualPrice;
  int quantity;
  String? created_at;

  Groceryitem({
    this.id,
    this.groceryList_id,
    this.actualPrice,
    this.created_at,
    required this.name,
    required this.estimatedPrice,
    required this.quantity,
  });

  set setGroceryListId(int id) => groceryList_id = id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groceryList_id': groceryList_id,
      'itemName': name,
      'quantity': quantity,
      'estimatedPrice': estimatedPrice,
      'actualPrice': actualPrice,
      'created_at': created_at,
    };
  }

  factory Groceryitem.fromMap(Map<String, dynamic> item) {
    return Groceryitem(
      id: item['id'],
      name: item['itemName'],
      estimatedPrice: item['estimatedPrice'],
      quantity: item['quantity'],
    );
  }
}
