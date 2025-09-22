class Item {
  int? id;
  int? checklistId;
  int? productId;
  int quantity;
  bool isBought;

  Item({
    this.id,
    this.checklistId,
    required this.productId,
    required this.quantity,
    this.isBought = false,
  });

  set setChecklistId(int id) => checklistId = id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'checkList_id': checklistId,
      'product_id': productId,
      'quantity': quantity,
      'isBought': isBought ? 1 : 0,
    };
  }

  factory Item.fromMap(Map<String, dynamic> item) {
    return Item(
      id: item['id'],
      checklistId: item['checkList_id'],
      productId: item['product_id'],
      quantity: item['quantity'],
      isBought: item['isBought'] == 1 ? true : false,
    );
  }
}
