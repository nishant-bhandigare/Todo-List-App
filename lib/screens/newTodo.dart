import 'package:flutter/material.dart';

class NewTodo extends StatelessWidget {
  NewTodo({Key? key, required this.addTodo}) : super(key: key);

  final void Function(String todo) addTodo;

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    var enteredTask = "";

    void saveTodo() {
      final isValid = form.currentState!.validate();
      if (!isValid) {
        return;
      }
      form.currentState!.save();
      addTodo(enteredTask);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Task",
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey[500]),
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
              ElevatedButton(
                onPressed: () {
                  saveTodo();
                  print(enteredTask);
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
