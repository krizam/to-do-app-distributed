import 'package:cloud_firestore/cloud_firestore.dart';

import '../screen/Task/task.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTasksStream(String userId) {
    return _firestore
        .collection('Tasks')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<void> deleteTask(String taskId) {
    return _firestore.collection('Tasks').doc(taskId).delete();
  }

  Future<List<Task>> getTasksByUserId(String userId) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('Tasks')
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs.map((doc) => Task.fromSnapshot(doc)).toList();
  }
}
