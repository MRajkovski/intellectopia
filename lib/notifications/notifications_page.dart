import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_drawer.dart'; // Import the AppDrawer

class NotificationsPage extends StatelessWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const NotificationsPage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      drawer: AppDrawer(
        user: user,
        selectedIndex: selectedIndex,
        onDrawerItemTap: onDrawerItemTap,
      ),
      body: Center(
        child: Text('Notifications Content'),
      ),
    );
  }
}
