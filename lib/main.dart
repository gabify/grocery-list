import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist/AddChecklist.dart';
import 'package:grocery_list/Checklist/ChecklistScreen.dart';
import 'package:grocery_list/Home.dart';
import 'package:grocery_list/Product/AddProduct.dart';
import 'package:grocery_list/Services/ChecklistProvider.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  /* runApp(
    ChangeNotifierProvider(
      create: (context) => Grocerylistprovider(),
      child: MaterialApp(
        routes: {
          '/': (context) => Dashboard(),
          '/addChecklist': (context) => AddCheckList(),
        },
      ),
    ),
  ); */

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ProductProvider())),
        ChangeNotifierProvider(create: ((context) => ChecklistProvider())),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => Home(),
          '/addProduct': (context) => AddProduct(),
          '/addChecklist': (context) => AddChecklist(),
        },
      ),
    ),
  );
}
