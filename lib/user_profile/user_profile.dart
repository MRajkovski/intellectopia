import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart';
import '../app_drawer.dart';
import 'user_avatar.dart'; // Import the UserAvatarPage

class UserProfilePage extends StatefulWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const UserProfilePage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String firstName = '';
  String lastName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (widget.user != null) {
      // Get the current user's document from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).get();

      // Set the user data
      setState(() {
        firstName = snapshot.data()?['firstName'] ?? '';
        lastName = snapshot.data()?['lastName'] ?? '';
        email = snapshot.data()?['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      drawer: AppDrawer(
        user: widget.user,
        selectedIndex: widget.selectedIndex,
        onDrawerItemTap: widget.onDrawerItemTap,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'First Name: $firstName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Last Name: $lastName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: $email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to EditProfilePage and pass current user info
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      user: widget.user,
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                    ),
                  ),
                ).then((value) {
                  // Refresh user data after editing profile
                  fetchUserData();
                });
              },
              child: Text('Change Information'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to UserAvatarPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserAvatarPage(),
                  ),
                );
              },
              child: Text('Change Avatar'),
            ),
          ],
        ),
      ),
    );
  }
}
