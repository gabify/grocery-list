import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  //Load Data
  Future<void> loadProducts() async {
    final data = await Databasehelper().getProducts();
    _products = data.map((p) => Product.fromMap(p)).toList();

    notifyListeners();
  }

  //Add Data
  Future<String> addProduct(Product newProduct) async {
    try {
      await Databasehelper().insertProduct(newProduct);
      loadProducts();
      notifyListeners();

      return 'Success';
    } catch (e) {
      return 'failed';
    }
  }

  //Getters
  List<Product> get products => List.unmodifiable(_products);
}
