import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist/ChecklistScreen.dart';
import 'package:grocery_list/Product/ProductScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedScreen = 0;

  final List<Widget> _screens = [ChecklistScreen(), ProductScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedScreen),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 18,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => setState(() => _selectedScreen = 0),
              icon: Icon(Icons.add_shopping_cart_rounded),
              iconSize: 35,
            ),
            IconButton(
              onPressed: () => setState(() => _selectedScreen = 1),
              icon: Icon(Icons.set_meal_rounded),
              iconSize: 35,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
