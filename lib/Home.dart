import 'package:flutter/material.dart';
import 'package:grocery_list/Checklist/ChecklistScreen.dart';
import 'package:grocery_list/Product/ProductScreen.dart';
import 'package:grocery_list/Services/ChecklistProvider.dart';
import 'package:grocery_list/Services/ProductProvider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedScreen = 0;

  Future<void> initData() async {
    await context.read<ProductProvider>().loadProducts();
    await context.read<ChecklistProvider>().loadChecklists();
  }

  final List<Widget> _screens = [ChecklistScreen(), ProductScreen()];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initData();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedScreen),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
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
        onPressed: () {
          switch (_selectedScreen) {
            case 0:
              Navigator.pushReplacementNamed(context, '/addChecklist');
              break;
            case 1:
              Navigator.pushNamed(context, '/addProduct');
              break;
            default:
              Navigator.pushReplacementNamed(context, '/');
          }
        },
        shape: CircleBorder(),
        elevation: 0,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
