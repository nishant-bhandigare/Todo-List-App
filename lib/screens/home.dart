import 'package:flutter/material.dart';
import 'package:todo_list_app/widgets/info.dart';
import 'package:todo_list_app/widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todoList = ["Buy Groceries", "Wash Your Car"];

  void newTodo(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NewTodo(
    //       addTodo: addTodo,
    //     ),
    //   ),
    // );

    final form = GlobalKey<FormState>();
    var enteredTask = "";

    void saveTodo() {
      final isValid = form.currentState!.validate();
      if (!isValid) {
        return;
      }
      form.currentState!.save();
      addTodo(enteredTask);
      Navigator.of(context).pop();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Task",
                    hintStyle:
                        TextStyle(fontSize: 20, color: Colors.grey[500]),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 4) {
                      return 'Please enter at least 4 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    enteredTask = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                saveTodo();
                print(enteredTask);
                 // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void addTodo(String todo) {
    setState(() {
      todoList.add(todo);
    });
  }

  void removeTodo(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Todo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Info(),
              TodoList(todoList: todoList, removeTodo: removeTodo),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newTodo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
