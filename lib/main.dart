import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist/ChecklistScreen.dart';
import 'package:grocery_list/Home.dart';
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

  runApp(MaterialApp(routes: {'/': (context) => Home()}));
}
