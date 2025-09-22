import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Groceryitem.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Checklist.dart';

class Grocerylistprovider extends ChangeNotifier {
  List<Checklist> _checkLists = [];
  List<Groceryitem> _groceryItems = [];

  Future<void> loadChecklist() async {
    final data = await Databasehelper().getGroceryLists();
    _checkLists = data.map((e) => Checklist.fromMap(e)).toList();

    notifyListeners();
  }

  //Getters
  List<Checklist> get checklists => List.unmodifiable(_checkLists);

  //save checklist
  Future<int> addNewCheckList(
    double budget,
    List<Groceryitem> groceryItems,
  ) async {
    Checklist checklist = Checklist(
      budget: budget,
      created_at: 'September 4, 2025',
    );
    final result = await Databasehelper().saveCheckList(
      checklist.toMap(),
      groceryItems,
    );

    if (result == null) {
      //add error message;
    }

    return result!;
  }

  //Update bought items
  Future<void> updateBoughtItems(List<Groceryitem> groceryItems) async {
    List<Map<String, dynamic>> boughtItems = groceryItems
        .where((i) => i.isBought)
        .map((i) => i.toMap())
        .toList();

    await Databasehelper().updateIfBought(boughtItems);
  }
}
