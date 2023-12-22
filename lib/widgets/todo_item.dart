import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  TodoItem({super.key, required this.todo});

  String todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(todo),
    );
  }
}
