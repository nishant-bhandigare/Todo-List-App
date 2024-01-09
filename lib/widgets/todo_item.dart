import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  TodoItem({super.key, required this.todo, required this.strikeThrough});

  String todo;
  bool strikeThrough;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(todo,  style: TextStyle(
          decoration: strikeThrough ? TextDecoration.lineThrough : null,
        ),),
      ),
    );
  }
}
