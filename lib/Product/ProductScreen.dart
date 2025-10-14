import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_list/Services/Product.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final totalProducts = context.watch<ProductProvider>().totalProducts;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Products',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.pink[400],
          foregroundColor: Colors.grey[50],
          centerTitle: true,
          toolbarHeight: 75,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Products',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          totalProducts.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = products[index];

            return Slidable(
              key: ValueKey(product.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => print('Edit'),
                    backgroundColor: Colors.amberAccent,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (_) => print('Delete'),
                    backgroundColor: Colors.redAccent,
                    icon: Icons.delete_forever_rounded,
                    label: 'Delete',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(product.productName),
                subtitle: Text("${product.price}.00 Php"),
              ),
            );
          }, childCount: products.length),
        ),
      ],
    );
  }
}
