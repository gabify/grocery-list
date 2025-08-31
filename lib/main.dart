import 'package:flutter/material.dart';
import 'package:grocery_list/checklist.dart';

void main() {
  runApp(MaterialApp(home: Dashboard()));
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Checklist> myList = [
    Checklist(budget: 5000, date: 'sample'),
    Checklist(budget: 5000, date: 'sample'),
    Checklist(budget: 5000, date: 'sample'),
    Checklist(budget: 5000, date: 'sample'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grocery List')),
      body: ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          final list = myList[index];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: ListTile(
              title: Text(list.budget.toString()),
              tileColor: Colors.blueGrey[100],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
