import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_drawer.dart';
class QuizzesPage extends StatelessWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const QuizzesPage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
      ),
      drawer: AppDrawer(
        user: user,
        selectedIndex: selectedIndex,
        onDrawerItemTap: onDrawerItemTap,
      ),
      body: Center(
        child: Text('Quizzes Content'),
      ),
    );
  }
}
