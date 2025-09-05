import 'package:flutter/material.dart';
import 'package:grocery_list/Groceryitem.dart';
import 'package:grocery_list/Services/Databasehelper.dart';

class Grocerylist extends StatefulWidget {
  final int groceryListId;

  const Grocerylist({super.key, required this.groceryListId});

  @override
  State<Grocerylist> createState() => _GrocerylistState();
}

class _GrocerylistState extends State<Grocerylist> {
  List<Groceryitem> groceryItems = [];

  Future<List<Groceryitem>> loadItems() async {
    final data = await Databasehelper().getGroceryItems(widget.groceryListId);
    return data.map((e) => Groceryitem.fromMap(e)).toList();
  }

  @override
  void initState() {
    loadItems().then((result) {
      setState(() {
        groceryItems = result;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Grocery List')),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text('P ${item.estimatedPrice}'),
              tileColor: Colors.blueGrey[100],
            ),
          );
        },
      ),
    );
  }
}
