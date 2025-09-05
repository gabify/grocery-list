class Checklist {
  int? id;
  double budget;
  String created_at;

  Checklist({this.id, required this.budget, required this.created_at});

  factory Checklist.fromMap(Map<String, dynamic> checklist) {
    return Checklist(
      id: checklist['id'],
      budget: checklist['budget'],
      created_at: checklist['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'budget': budget, 'created_at': created_at};
  }
}
