import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String title;
  final String description;
  final String category;  // Update this to String
  final bool important;
  final String time;
  final bool check;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.important,
    required this.time,
    required this.check,
  });

  factory TaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data == null) {
      return TaskModel(
        title: '',
        description: '',
        category: '',
        important: false,
        time: '',
        check: false,
      );
    }

    return TaskModel(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category']?.toString() ?? '',
      important: data['important'] ?? false,
      time: data['time']?.toString() ?? '',
      check: data['check'] ?? false,
    );
  }
}
