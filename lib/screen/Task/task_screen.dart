import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screen/Task/task_card.dart';
import 'package:todo_app/screen/Task/viewtask_screen.dart';
import '../../const/const.dart';
import '../../model/task_model.dart';
import '../../provider/task_view_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskViewModel _viewModel = TaskViewModel();
  late String _currentUserId = FirebaseAuth.instance.currentUser!.uid; // Initialize _currentUserId

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Food":
        return Colors.orange;
      case "Workout":
        return Colors.green;
      case "Work":
        return Colors.blue;
      case "Timer":
        return Colors.yellow;
      case "Study":
        return Colors.pink;
      case "None":
        return Color(0xff616B7B);
      default:
        return Color(0xffffffff);
    }
  }

  @override
  void initState() {
    super.initState();
    // Get current user's ID when the widget initializes
    _currentUserId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff0e0e0e),
      appBar: AppBar(
        backgroundColor: Color(0xff616B7B),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Title(
          color: Colors.green,
          child: Text(
            "Tasks",
            style: GoogleFonts.robotoCondensed(color: Colors.white),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _viewModel.getTasksStream(_currentUserId), // Pass current user's ID here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              TaskModel task = TaskModel.fromSnapshot(snapshot.data!.docs[index]);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewTaskScreen(
                        Document: snapshot.data!.docs[index].data() as Map<String, dynamic>,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Task Actions"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewTaskScreen(
                                      Document: snapshot.data!.docs[index].data() as Map<String, dynamic>,
                                      id: snapshot.data!.docs[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: Text("Update Task"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Tasks")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete()
                                    .then((_) {
                                  Navigator.pop(context);
                                })
                                    .catchError((error) {
                                  print("Failed to delete task: $error");
                                });
                              },
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                              child: Text("Delete Task"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("Tasks")
                                    .doc(snapshot.data!.docs[index].id)
                                    .update({"check": true})
                                    .then((_) {
                                  Navigator.pop(context);
                                })
                                    .catchError((error) {
                                  print("Failed to update task: $error");
                                });
                              },
                              style: ElevatedButton.styleFrom(primary: Colors.blue),
                              child: Text("Check Task"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: TaskCard(
                  title: task.title,
                  description: task.description,
                  imp: task.important,
                  time: task.time,
                  check: task.check,
                  id: snapshot.data!.docs[index].id,
                  idx: category.indexOf(task.category),
                  categoryColor: _getCategoryColor(task.category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
