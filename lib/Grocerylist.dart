import 'dart:ffi';

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
      body: Column(
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) {
            final item = groceryItems[index];

            return Container(
              margin: EdgeInsets.symmetric(vertical: 3),
              child: ListTile(
                title: Row(
                  children: [
                    Text(item.name),
                    SizedBox(width: 10),
                    Text("${item.quantity} pcs"),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Estimated Price: ₱ ${item.estimatedPrice}"),
                    Text(" Actual Price: ₱ ${item.actualPrice ?? 0.0}"),
                  ],
                ),
                tileColor: Colors.grey[100],
                trailing: Icon(
                  Icons.check_circle,
                  color: item.isBought ? Colors.green[400] : Colors.grey[100],
                  size: 25,
                ),
                onTap: () {
                  setState(() {
                    item.isBought = !item.isBought;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
