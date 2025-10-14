import 'package:flutter/material.dart';
import 'package:grocery_list/Services/Databasehelper.dart';
import 'package:grocery_list/Services/Item.dart';
import 'package:grocery_list/Services/ItemProvider.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class ViewItems extends StatefulWidget {
  const ViewItems({super.key});

  @override
  State<ViewItems> createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  @override
  Widget build(BuildContext context) {
    final _items = context.watch<ItemProvider>().items;
    final _products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.grey[50],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = _items[index];
              final product = _products.firstWhere(
                (p) => p.id == item.productId,
              );

              return Container(
                padding: const EdgeInsets.only(bottom: 7),
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text(product.productName),
                  subtitle: Text("${item.quantity}"),
                ),
              );
            }, childCount: _items.length),
          ),
        ],
      ),
    );
  }
}
