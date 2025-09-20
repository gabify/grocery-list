import 'package:flutter/material.dart';
import 'package:grocery_list/AddCheckList.dart';
import 'package:grocery_list/Dashboard.dart';
import 'package:grocery_list/Services/Grocerylistprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Grocerylistprovider(),
      child: MaterialApp(
        routes: {
          '/': (context) => Dashboard(),
          '/addChecklist': (context) => AddCheckList(),
        },
      ),
    ),
  );
}
