import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/todo_item.dart';

class TodoList extends StatefulWidget {
  TodoList({Key? key, required this.todoList, required this.removeTodo})
      : super(key: key);

  void Function(int index) removeTodo;
  List<String> todoList;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> todoWidgets = [];

    for (int index = 0; index < widget.todoList.length; index++) {
      todoWidgets.add(
        Dismissible(
          key: ValueKey(widget.todoList[index]),
          onDismissed: (direction) {
            widget.removeTodo(index);
          },
          child: TodoItem(
            todo: widget.todoList[index],
          ),
        ),
      );
    }

    return Column(
      children: todoWidgets,
    );
  }
}
