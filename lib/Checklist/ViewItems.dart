import 'package:flutter/material.dart';
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
    final items = context.watch<ItemProvider>().items;
    final products = context.watch<ProductProvider>().products;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Done buying?'),
              content: const Text('Are you sure you want to go back?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await context.read<ItemProvider>().updateItemStatus();
                    Navigator.pop(context, true);
                  },
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
          backgroundColor: Colors.pink[400],
          foregroundColor: Colors.grey[50],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = items[index];
                final product = products.firstWhere(
                  (p) => p.id == item.productId,
                );

                return Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(product.productName),
                    subtitle: Text(
                      "${item.quantity} ${item.quantity > 1 ? 'pcs' : 'pc'}",
                    ),
                    trailing: Icon(
                      Icons.check_circle_outline_outlined,
                      color: item.isBought ? Colors.green[600] : Colors.white,
                    ),
                    onTap: () {
                      context.read<ItemProvider>().changeStatus(index);
                    },
                  ),
                );
              }, childCount: items.length),
            ),
          ],
        ),
      ),
    );
  }
}
