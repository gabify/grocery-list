import 'package:flutter/material.dart';

class AddChecklist extends StatefulWidget {
  const AddChecklist({super.key});

  @override
  State<AddChecklist> createState() => _AddChecklistState();
}

class _AddChecklistState extends State<AddChecklist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        foregroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Center(child: Text('This is where you add checklist')),
    );
  }
}
