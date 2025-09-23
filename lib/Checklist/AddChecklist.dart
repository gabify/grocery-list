import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Item.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class AddChecklist extends StatefulWidget {
  const AddChecklist({super.key});

  @override
  State<AddChecklist> createState() => _AddChecklistState();
}

class _AddChecklistState extends State<AddChecklist> {
  final _formKey = GlobalKey<FormState>();
  List<Item> items = [];
  int totalItems = 0;
  double budget = 0.0;
  String createdAt = '';

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {},
              label: Text('Cancel', style: TextStyle(color: Colors.grey[50])),
              icon: Icon(Icons.close, color: Colors.grey[50]),
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text('Save', style: TextStyle(color: Colors.grey[50])),
              icon: Icon(Icons.check, color: Colors.grey[50]),
            ),
          ],
        ),
        backgroundColor: Colors.pink[400],
        toolbarHeight: 70,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 30,
                top: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Grocery List',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                              fontSize: 25,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'What should we buy today?',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              letterSpacing: 0.7,
                            ),
                          ),

                          SizedBox(height: 40),

                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 310,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Set your budget first!',
                                        hintText: 'Set your budget first!',
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 1.4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '*Please provide a budget';
                                        }

                                        try {
                                          String budgetString = value.trim();
                                          double budgetValue = double.parse(
                                            budgetString,
                                          );

                                          if (budgetValue <= 0) {
                                            return '*Budget should atleast greater than 0';
                                          }

                                          return null;
                                        } catch (e) {
                                          return '*Only numbers are allowed.';
                                        }
                                      },
                                      onSaved: (v) => budget = double.parse(v!),
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      }
                                    },
                                    icon: Icon(Icons.check),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = products[index];
              Icon dynamicTrailing = product.isSelected
                  ? Icon(Icons.do_disturb_on, color: Colors.red[300], size: 30)
                  : Icon(Icons.add_circle, color: Colors.green[400], size: 30);

              return ListTile(
                title: Text(product.productName),
                subtitle: Text("${product.price}.00 Php"),
                trailing: dynamicTrailing,
                onTap: () =>
                    setState(() => product.isSelected = !product.isSelected),
              );
            }, childCount: products.length),
          ),
        ],
      ),
    );
  }
}
