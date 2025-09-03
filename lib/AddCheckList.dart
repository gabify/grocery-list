import 'package:flutter/material.dart';
import 'package:grocery_list/groceryItem.dart';

class AddCheckList extends StatefulWidget {
  const AddCheckList({super.key});

  @override
  State<AddCheckList> createState() => _AddCheckListState();
}

class _AddCheckListState extends State<AddCheckList> {
  final TextEditingController _controller = TextEditingController();

  List<Groceryitem> myList = [];
  double totalEstimatedPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Checklist')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
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

              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter your budget'),
              ),

              SizedBox(height: 50),

              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  final item = myList[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name),
                                Text("${item.quantity.toString()} pcs"),
                              ],
                            ),
                            Column(
                              children: [Text("P ${item.estimatedPrice}")],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Estimated Price: '),
                  Text("P ${totalEstimatedPrice.toString()}"),
                ],
              ),
              Row(children: [Text('Actual Price: '), Text('20,000.0')]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final _formKey = GlobalKey<FormState>();
              String _name = '';
              double _estimatedPrice = 0.0;
              int _quantity = 1;

              return AlertDialog(
                title: const Text('Add Item'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Item Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a name for the item";
                          }

                          return null;
                        },

                        onSaved: (value) => _name = value!,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Estimated Price',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide an estimated price for the item";
                          }

                          try {
                            if (double.parse(value.trim()) <= 0.0) {
                              return "Estimated price should be greater than 0";
                            }
                          } catch (e) {
                            return "Only numeric values are allowed";
                          }

                          return null;
                        },

                        onSaved: (value) =>
                            _estimatedPrice = double.parse(value!),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Quantity'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide quantity for the item";
                          }

                          try {
                            if (int.parse(value.trim()) <= 0) {
                              return "Quantity should be greater than 0";
                            }
                          } catch (e) {
                            return "Only numeric values are allowed";
                          }

                          return null;
                        },

                        onSaved: (value) => _quantity = int.parse(value!),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          myList.add(
                            Groceryitem(
                              name: _name,
                              estimatedPrice: _estimatedPrice,
                              quantity: _quantity,
                            ),
                          );

                          totalEstimatedPrice = myList.fold(
                            0.0,
                            (current, item) =>
                                current + (item.estimatedPrice * item.quantity),
                          );
                        });

                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
