import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/const/const.dart';

class ViewTaskScreen extends StatefulWidget {
  ViewTaskScreen({Key? key, required this.Document, required this.id});
  final Map<String, dynamic> Document;
  final String id;

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  late TextEditingController _title;
  late TextEditingController _description;
  late int idx;
  late bool imp;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.Document["title"]);
    _description = TextEditingController(text: widget.Document["description"]);

    // Check if category is a string
    if (widget.Document["category"] is String) {
      // Find the index of the category in the list
      idx = category.indexOf(widget.Document["category"] as String);

      // If the category is not found, provide a default index (e.g., 0)
      if (idx == -1) {
        idx = 0;
      }
    } else {
      // If the category is not a string, provide a default index (e.g., 0)
      idx = 0;
    }

    imp = widget.Document["important"];
  }


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    List<Widget> buttons = List.generate(category.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              idx = index;
            });
          },
          style: ElevatedButton.styleFrom(
            primary: colors[index],
            onPrimary: Colors.white,
          ),
          child: Text(category[index]),
        ),
      );
    });

    Widget label(String text, double size, FontWeight fontWeight) {
      return Text(
        text,
        style: GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
            fontSize: size,
            color: Colors.white,
            fontWeight: fontWeight,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xff030404),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h / 30,
              ),
              label("View", 40, FontWeight.bold),
              label("Your Task", 40, FontWeight.bold),
              SizedBox(
                height: h / 30,
              ),
              label("Task title", 20, FontWeight.normal),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: w - w / 30,
                  height: h / 13,
                  decoration: BoxDecoration(
                    gradient: gradient(colors[idx]),
                    color: Color(0xff616B7B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _title,
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: imp
                            ? Icon(
                          Icons.star_outline_outlined,
                          color: Colors.red,
                          size: w / 15,
                          shadows: [
                            BoxShadow(
                              color: Colors.red,
                              blurRadius: 30.0,
                              spreadRadius: 6.0,
                            ),
                          ],
                        )
                            : null,
                        border: InputBorder.none,
                        hintText: "Add title",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(left: 20, top: 10),
                      ),
                      cursorColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              label("Description", 20, FontWeight.normal),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: w - w / 30,
                  height: h / 5,
                  decoration: BoxDecoration(
                    gradient: gradient(colors[idx]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _description,
                    style: GoogleFonts.robotoCondensed(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add title",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20, top: 8),
                    ),
                    cursorColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!imp)
                    imp = true;
                  else
                    imp = false;
                  setState(() {});
                },
                child: Text(
                  "Important",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              label("Category", 20, FontWeight.normal),
              Wrap(
                children: buttons,
              ),
              SizedBox(
                height: h / 30,
              ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Tasks")
                    .doc(widget.id)
                    .update({
                  "title": _title.text.toString(),
                  "description": _description.text.toString(),
                  "category": category[idx], // Update this line
                  "important": imp,
                  "time": "${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour <= 12 ? "AM" : "PM"}",
                })
                    .then((_) {
                  Navigator.pop(context);
                })
                    .catchError((error) {
                  print("Failed to update task: $error");
                  // Handle the error, show a snackbar, etc.
                });
              },
              child: Text("Update Task"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
