import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Checklist.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Item.dart';

class ChecklistProvider extends ChangeNotifier {
  List<Checklist> _checklists = [];

  //Load data
  Future<void> loadChecklists() async {
    final data = await Databasehelper().getChecklists();
    _checklists = data.map((c) => Checklist.fromMap(c)).toList();

    notifyListeners();
  }

  //Add data
  Future<int?> addChecklist(List<Item> items, Checklist newChecklist) async {
    int? id = await Databasehelper().insertGroceryList(newChecklist, items);
    loadChecklists();
    notifyListeners();

    return id;
  }

  //Getters
  List<Checklist> get checklists => List.unmodifiable(_checklists);
}
