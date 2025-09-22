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
      body: Center(child: Text('This is where you add checklist')),
    );
  }
}
