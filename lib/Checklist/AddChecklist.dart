import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist/VerifyChecklist.dart';
import 'package:grocery_list/Services/Item.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class AddChecklist extends StatefulWidget {
  const AddChecklist({super.key});

  @override
  State<AddChecklist> createState() => _AddChecklistState();
}

class _AddChecklistState extends State<AddChecklist> {
  final TextEditingController _budgetController = TextEditingController();
  List<Item> items = [];
  double budget = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _budgetController.addListener(() {
      setState(() => budget = double.parse(_budgetController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Discard changes'),
              content: const Text(
                'Are you sure you want to go back? Unsaved data will be lost.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Yes'),
                ),
              ],
            ),
          );

          if (shouldExit ?? false) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cancel'),
          backgroundColor: Colors.pink[400],
          foregroundColor: Colors.grey[50],
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
                              TextFormField(
                                controller: _budgetController,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: 'Set your budget first!',
                                  hintText: 'Set your budget first!',
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                      width: 1.4,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = products[index];
                Icon dynamicTrailing = product.isSelected
                    ? Icon(
                        Icons.do_disturb_on,
                        color: Colors.red[300],
                        size: 30,
                      )
                    : Icon(
                        Icons.add_circle,
                        color: Colors.green[400],
                        size: 30,
                      );

                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text("${product.price}.00 Php"),
                  trailing: dynamicTrailing,
                  onTap: () {
                    setState(() {
                      final selected = items.any(
                        (i) => i.productId == product.id,
                      );

                      if (selected) {
                        items.removeWhere((i) => i.productId == product.id);
                        product.isSelected = false;
                      } else {
                        items.add(Item(productId: product.id, quantity: 1));
                        product.isSelected = true;
                      }
                    });
                  },
                );
              }, childCount: products.length),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyChecklist(items: items, budget: budget),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.shopping_cart, size: 35),
              if (items.isNotEmpty)
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.pink[400],
                    child: Text(
                      "${items.length}",
                      style: TextStyle(fontSize: 15, color: Colors.grey[50]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
