import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Item.dart';
import 'package:grocery_list/Services/Product.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class VerifyChecklist extends StatefulWidget {
  final List<Item> items;

  const VerifyChecklist({super.key, required this.items});

  @override
  State<VerifyChecklist> createState() => _VerifyChecklistState();
}

class _VerifyChecklistState extends State<VerifyChecklist> {
  final TextEditingController _budgetController = TextEditingController();
  double budget = 0.0;
  double totalCost = 0.0;
  String createdAt = '';

  double _calculateTotalCost(List<Item> items, List<Product> products) {
    return items.fold(0.0, (sum, item) {
      final product = products.firstWhere((p) => p.id == item.productId);
      return sum + item.getCost(product.price);
    });

    //Dont know how to calculate the initial value of total cost T_T
  }

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.grey[50],
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
                          'Verify Grocery List',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800],
                            fontSize: 25,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          'Review thorougly the list before saving it!',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            letterSpacing: 0.7,
                          ),
                        ),

                        SizedBox(height: 40),

                        TextFormField(
                          controller: _budgetController,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'Set your budget here!',
                            filled: true,
                            fillColor: Colors.grey[50],
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = widget.items[index];
              final product = products.firstWhere(
                (p) => p.id == item.productId,
              );

              return Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(product.productName),
                  subtitle: Text(
                    "${(item.getCost(product.price)).toStringAsFixed(2)} Php",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 0) {
                              item.quantity--;
                              totalCost = _calculateTotalCost(
                                widget.items,
                                products,
                              );
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text('${item.quantity}', style: TextStyle(fontSize: 18)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                            totalCost = _calculateTotalCost(
                              widget.items,
                              products,
                            );
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: widget.items.length),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Total Cost: '),
                      Text("${totalCost.toStringAsFixed(2)} Php"),
                    ],
                  ),

                  Row(
                    children: [
                      Text('Remaining Budget: '),
                      Text("${(budget - totalCost).toStringAsFixed(2)} Php"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      foregroundColor: Colors.grey[50],
                    ),
                    child: Text(
                      'Save Grocery List',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
