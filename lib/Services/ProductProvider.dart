import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  int _totalProducts = 0;

  //Load Data
  Future<void> loadProducts() async {
    final data = await Databasehelper().getProducts();
    _products = data.map((p) => Product.fromMap(p)).toList();
    _totalProducts = _products.length;

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
  int get totalProducts => _totalProducts;
}
