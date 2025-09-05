import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist.dart';
import 'package:grocery_list/Groceryitem.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Grocerylistprovider.dart';

class AddCheckList extends StatefulWidget {
  const AddCheckList({super.key});

  @override
  State<AddCheckList> createState() => _AddCheckListState();
}

class _AddCheckListState extends State<AddCheckList> {
  final provider = Grocerylistprovider();
  final TextEditingController _controller = TextEditingController();
  List<Groceryitem> myList = [];
  double totalEstimatedPrice = 0.0;
  double budget = 0.0;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        budget = double.parse(_controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              label: Text('Cancel'),
              icon: Icon(Icons.close),
            ),
            TextButton.icon(
              onPressed: () {
                if (budget <= 0.0 || myList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please input a budget and grocery items'),
                    ),
                  );
                } else {
                  final groceryList = Checklist(
                    budget: budget,
                    created_at: 'September 05, 2024',
                  ).toMap();

                  //show loading
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );

                  Databasehelper().saveCheckList(groceryList, myList).then((
                    result,
                  ) {
                    if (result == null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'An error occured. Please try again later',
                          ),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                    }
                  });
                }
              },
              label: Text('Save'),
              icon: Icon(Icons.check),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
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
              Text('What are you going to buy today?'),

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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(item.name),
                                    SizedBox(width: 10),
                                    Text("${item.quantity.toString()} pcs"),
                                  ],
                                ),
                                Text("P ${item.estimatedPrice}"),
                              ],
                            ),
                            Text("P ${item.estimatedPrice * item.quantity}"),
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
              Row(
                children: [
                  Text('Remaining Budget: '),
                  Text("P ${(budget - totalEstimatedPrice).toString()}"),
                ],
              ),
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
                          myList.insert(
                            0,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
