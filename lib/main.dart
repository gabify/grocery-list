import 'package:flutter/material.dart';
import 'package:grocery_list/AddCheckList.dart';
import 'package:grocery_list/Dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => Dashboard(),
        '/addChecklist': (context) => AddCheckList(),
      },
    ),
  );
}
