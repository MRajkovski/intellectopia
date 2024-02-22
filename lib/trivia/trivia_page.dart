import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_drawer.dart'; // Import the AppDrawer

class TriviaPage extends StatelessWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const TriviaPage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trivia'),
      ),
      drawer: AppDrawer(
        user: user,
        selectedIndex: selectedIndex,
        onDrawerItemTap: onDrawerItemTap,
      ),
      body: Center(
        child: Text('Trivia Content'),
      ),
    );
  }
}
