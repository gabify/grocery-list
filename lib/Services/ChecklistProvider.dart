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
  Future<String> addChecklist(Checklist newChecklist, List<Item> items) async {
    int? id = await Databasehelper().insertGroceryList(newChecklist, items);
    loadChecklists();
    notifyListeners();

    if (id == null) {
      return 'failed';
    }

    return 'Successs';
  }

  //Getters
  List<Checklist> get checklists => List.unmodifiable(_checklists);
}
