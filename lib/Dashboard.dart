import 'package:flutter/material.dart';
import 'package:grocery_list/Grocerylist.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Grocerylistprovider.dart';
import 'package:grocery_list/checklist.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> _initData() async {
    await context.read<Grocerylistprovider>().loadChecklist();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final checklists = context.watch<Grocerylistprovider>().checklists;

    return Scaffold(
      appBar: AppBar(title: Text('Grocery List')),
      body: ListView.builder(
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          final list = checklists[index];

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
          Navigator.pushReplacementNamed(context, '/addChecklist');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
