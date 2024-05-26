import 'package:flutter/material.dart';
import 'package:todo_app/screen/Login/forgot_password.dart';
import 'package:todo_app/screen/Task/addtask_screen.dart';
import 'package:todo_app/screen/Task/home.dart';

import '../Profile/profile_screen.dart';
import '../screen/Login/login_screen.dart';
import '../screen/Login/signup_screen.dart';
import '../screen/Task/task_screen.dart';
import '../screen/Task/viewtask_screen.dart';

class route_generator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    print(settings.name);
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/signup": // Add a case for SignUpScreen
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case "/profile":
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case "/task_screen":
        return MaterialPageRoute(builder: (_) => TaskScreen());
      case "/forgot":
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      case "/addtask":
        return MaterialPageRoute(builder: (_) => Addtask());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      case "/view_task":
        if (arg is Map<String, dynamic> && arg.containsKey("Document") && arg.containsKey("id")) {
          return MaterialPageRoute(builder: (_) => ViewTaskScreen(Document: arg["Document"], id: arg["id"]));
        }
    // case "/firestore":
    //   return MaterialPageRoute(builder: (_) => const FirestoreExample());
      default:
        return _pnf();
    }
  }

  static Route<dynamic>? _pnf() {
    print("iamhere");
    return MaterialPageRoute(
      builder: (_) => const Scaffold(body: Text("Page Not Found")),
    );
  }
}
