import 'package:flutter/material.dart';
import 'package:grocery_list/Grocerylist.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/checklist.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Checklist> myList = [];

  Future<List<Checklist>> loadChecklist() async {
    final data = await Databasehelper().getGroceryLists();
    return data.map((e) => Checklist.fromMap(e)).toList();
  }

  @override
  void initState() {
    loadChecklist().then((result) {
      setState(() {
        myList = result;
      });
    });

    // TODO: implement initState
    super.initState();
  }

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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Grocerylist(groceryListId: list.id!),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addChecklist');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
