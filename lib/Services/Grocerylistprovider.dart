import 'package:flutter/material.dart';
import 'package:grocery_list/Groceryitem.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/checklist.dart';

class Grocerylistprovider {
  List<Checklist> _checkLists = [];
  List<Groceryitem> _groceryItems = [];

  Future<void> loadChecklist() async {
    final data = await Databasehelper().getGroceryLists();
    _checkLists = data.map((e) => Checklist.fromMap(e)).toList();
  }

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
}
