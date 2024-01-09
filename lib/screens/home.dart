import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todo_list_app/widgets/completed_todo_list.dart';
import 'package:todo_list_app/widgets/display.dart';
import 'package:todo_list_app/widgets/todo_list.dart';
import 'package:weather/weather.dart';

import '../api_key.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Position? _currentPosition;

  double lat = 0.0;
  double long = 0.0;
  String key = api_key;

  Weather? _weather;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        lat = position.latitude;
        long = position.longitude;
        getWeather(lat, long);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getWeather(double latitude, double longitude) async {
    const String apiKey = api_key;
    WeatherFactory wf = WeatherFactory(apiKey);

    try {
      final weather = await wf.currentWeatherByLocation(latitude, longitude);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  List<String> todoList = ["Buy Groceries", "Wash the Car"];
  List<String> completedTodoList = ["Clean the Dishes", "Clean the room"];

  void newTodo(BuildContext context) {
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
      completedTodoList.add(todoList[index]);
      todoList.removeAt(index);
    });
  }

  void reAddTodo(int index) {
    setState(() {
      todoList.add(completedTodoList[index]);
      completedTodoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Todo List App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DisplayWidget(
                  temp: _weather?.temperature?.celsius?.toInt() ?? 0,
                  realFeel: _weather?.tempFeelsLike?.celsius?.toInt() ?? 0),
              TodoList(todoList: todoList, removeTodo: removeTodo),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text("Completed (${completedTodoList.length})"),
              ),
              CompletedTodoList(
                  todoList: completedTodoList, reAddTodo: reAddTodo),
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
