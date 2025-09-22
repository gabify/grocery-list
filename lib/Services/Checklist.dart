class Checklist {
  int? id;
  double budget;
  int totalItems;
  int boughtItems;
  bool isDone;
  String created_at;

  Checklist({
    this.id,
    required this.budget,
    required this.totalItems,
    required this.boughtItems,
    required this.isDone,
    required this.created_at,
  });

  factory Checklist.fromMap(Map<String, dynamic> checklist) {
    return Checklist(
      id: checklist['id'],
      budget: checklist['budget'],
      totalItems: checklist['total_items'],
      boughtItems: checklist['bought_items'],
      isDone: checklist['isDone'],
      created_at: checklist['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'budget': budget,
      'total_items': totalItems,
      'bought_items': boughtItems,
      'isDone': isDone,
      'created_at': created_at,
    };
  }
}
