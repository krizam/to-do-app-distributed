import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? _user;
  String? _name;
  String? _email;
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();
    // Retrieve the currently signed-in user
    _user = FirebaseAuth.instance.currentUser;
    // Fetch additional user profile information
    fetchUserProfile();
  }

  // Function to fetch additional user profile information
  void fetchUserProfile() async {
    if (_user != null) {
      // Retrieve user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      // Extract user data from the snapshot
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          _name = data['name'] ?? 'N/A';
          _email = _user!.email;
          _phoneNumber = data['phone'] ?? 'N/A';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: _user != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display user data
            Text(
              'Name: ${_name ?? 'N/A'}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${_email ?? 'N/A'}',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Phone Number: ${_phoneNumber ?? 'N/A'}',
              style: TextStyle(color: Colors.white),
            ),
            // Add additional widgets here
          ],
        )
            : CircularProgressIndicator(), // Show loading indicator if user data is being fetched
      ),
    );
  }
}