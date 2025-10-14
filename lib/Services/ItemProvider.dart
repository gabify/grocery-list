import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Item.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _items = [];

  //Load data
  Future<void> loadItems(int checklistId) async {
    final data = await Databasehelper().getItems(checklistId);
    _items = data.map((i) => Item.fromMap(i)).toList();

    notifyListeners();
  }

  List<Item> get items => List.unmodifiable(_items);
}
