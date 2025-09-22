import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Product.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double price = 0.0;
  String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 30,
          top: 20,
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
                      'Create New Product',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'What new things are you going to buy?',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        letterSpacing: 0.7,
                      ),
                    ),

                    SizedBox(height: 40),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'Ex. Nescafe 25g',
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*Please provide a name of the product';
                                }

                                return null;
                              },
                              onSaved: (v) => name = v!,
                            ),

                            SizedBox(height: 30),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Price',
                                hintText: 'Ex. 100.0 Php',
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*Please provide a a price for the product';
                                }

                                String priceValue = value.trim();

                                try {
                                  double price = double.parse(priceValue);

                                  if (price <= 0) {
                                    return '*Price must be atleast greater than 0.';
                                  }

                                  return null;
                                } catch (e) {
                                  return '*Only numbers are allowed.';
                                }
                              },
                              onSaved: (v) => price = double.parse(v!),
                            ),

                            SizedBox(height: 30),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Category',
                                hintText: 'Ex.Essentials',
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '*Please provide a category of the product';
                                }

                                return null;
                              },
                              onSaved: (v) => category = v!,
                            ),

                            SizedBox(height: 35),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Product newProduct = Product(
                          productName: name,
                          price: price,
                          category: category,
                        );

                        context.read<ProductProvider>().addProduct(newProduct);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      foregroundColor: Colors.grey[50],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
