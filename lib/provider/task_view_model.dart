// task_view_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository/task_repository.dart';

class TaskViewModel {
  final TaskRepository _repository = TaskRepository();

  Stream<QuerySnapshot> getTasksStream(String userId) {
    return _repository.getTasksStream(userId); // Pass userId to repository method
  }

  Future<void> deleteTask(String taskId) {
    return _repository.deleteTask(taskId);
  }
}
