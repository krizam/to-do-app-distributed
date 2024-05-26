import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final int idx;
  final bool imp;
  final bool? check;
  final String id;
  final Color categoryColor;

  TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.idx,
    required this.imp,
    required this.check,
    required this.id,
    required this.categoryColor,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: 10, left: 5),
      width: w - w / 6,
      height: h / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.categoryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(h / 144),
                width: w / 8,
                child: widget.check ?? false ? Icon(Icons.check, color: Colors.white) : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: h / 72),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h / 70,
                ),
                if (widget.imp)
                  Icon(
                    Icons.star,
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
                else
                  SizedBox(
                    height: h / 60,
                  ),
                SizedBox(
                  height: h / 60,
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
