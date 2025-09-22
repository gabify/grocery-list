import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_list/Services/Checklist.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<Checklist> checklists = [
    Checklist(
      budget: 2000,
      totalItems: 10,
      boughtItems: 0,
      isDone: false,
      created_at: 'created_at',
    ),

    Checklist(
      budget: 2000,
      totalItems: 10,
      boughtItems: 0,
      isDone: false,
      created_at: 'created_at',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Grocery Lists',
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
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final checklist = checklists[index];

            return Slidable(
              key: ValueKey(checklist.id),
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
                title: Text(checklist.budget.toString()),
                subtitle: Text(checklist.created_at),
              ),
            );
          }, childCount: checklists.length),
        ),
      ],
    );
  }
}
