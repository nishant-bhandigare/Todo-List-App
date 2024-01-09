import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/todo_item.dart';

class CompletedTodoList extends StatefulWidget {
  CompletedTodoList({Key? key, required this.todoList, required this.reAddTodo})
      : super(key: key);

  void Function(int index) reAddTodo;
  List<String> todoList;

  @override
  State<CompletedTodoList> createState() => _CompletedTodoListState();
}

class _CompletedTodoListState extends State<CompletedTodoList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> todoWidgets = [];

    for (int index = 0; index < widget.todoList.length; index++) {
      todoWidgets.add(
        Dismissible(
          key: ValueKey(widget.todoList[index]),
          onDismissed: (direction) {
            widget.reAddTodo(index);
          },
          child: TodoItem(
            todo: widget.todoList[index],
            strikeThrough: true,
          ),
        ),
      );
    }

    return Column(
      children: todoWidgets,
    );
  }
}
