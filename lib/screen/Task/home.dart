import 'package:flutter/material.dart';
import 'package:todo_app/screen/Login/login_screen.dart';
import 'package:todo_app/screen/Task/addtask_screen.dart';
import 'package:todo_app/screen/Task/task_screen.dart';
import '../../Profile/profile_screen.dart';

import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

List<Widget> screens = [TaskScreen(), Addtask(), ProfileScreen()];

class _HomeState extends State<Home> {
  int currentIdx = 0;

  // Function to handle logout
  void _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIdx == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          return true;
        }
        setState(() {
          currentIdx = (currentIdx - 1).clamp(0, screens.length - 1);
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _handleLogout, // Call the logout function
            ),
          ],
        ),
        body: screens[currentIdx],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIdx,
          onTap: (int index) {
            setState(() {
              currentIdx = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: currentIdx == 0
            ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addtask()),
            );
          },
          child: Icon(Icons.add),
        )
            : null,
      ),
    );
  }
}
