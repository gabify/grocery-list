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

  //change item status
  void changeStatus(int index) {
    _items[index].isBought = !_items[index].isBought;
    notifyListeners();
  }

  //Update when item is bought
  Future<void> updateItemStatus() async {
    final boughtItems = _items
        .where((item) => item.isBought)
        .map((item) => item.toMap())
        .toList();

    await Databasehelper().updateIsBought(boughtItems);
  }

  List<Item> get items => List.unmodifiable(_items);
}
