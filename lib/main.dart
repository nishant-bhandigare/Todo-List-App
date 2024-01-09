import 'package:flutter/material.dart';
import 'package:todo_list_app/screens/home.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blue, // Change primary color as needed
  hintColor: Colors.cyanAccent, // Change accent color as needed
  scaffoldBackgroundColor: Colors.grey[900], // Change background color as needed
  appBarTheme: AppBarTheme(
    color: Colors.grey[800], // Change app bar color as needed
  ),
  cardColor: Colors.grey[800], // Change card color as needed
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white), // Change text color as needed
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white, // Change icon color as needed
  ),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // theme: darkTheme,
      home: const HomeScreen(),
    ),
  );
}
