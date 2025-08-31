import 'package:flutter/material.dart';

class AddCheckList extends StatefulWidget {
  const AddCheckList({super.key});

  @override
  State<AddCheckList> createState() => _AddCheckListState();
}

class _AddCheckListState extends State<AddCheckList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Checklist')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'New Checklist',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    Text('Subtext for the title'),

                    SizedBox(height: 30),

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Budget'),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Center(child: Text('Click the + to add items to the list')),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Item'),
                content: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Item Name'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Estimated Cost'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
