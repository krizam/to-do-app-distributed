import 'package:flutter/material.dart';

LinearGradient gradient(Color _color) {
  return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [
        0.0,
        1.0
      ],
      colors: [
        _color,
        Color(0xff616B7B),
      ]);
}

final List<Color> colors = [
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.pink,
  Color(0xff616B7B)
];
final List<String> category = [
  "Food",
  "Workout",
  "Work",
  "Timer",
  "Study",
  "None"
];
final List<String> path = [
  "asset/image/todo.png",
  "asset/image/todo.png",
  "asset/image/todo.png",
  "asset/image/todo.png",
  "asset/image/todo.png",
  "asset/image/todo.png",
];