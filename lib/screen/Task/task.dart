import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final String userId; // Add userId field

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.userId,
  });

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Task(
      id: snapshot.id,
      title: data['title'],
      description: data['description'],
      completed: data['completed'],
      userId: data['userId'], // Update to fetch userId from Firestore
    );
  }
}
