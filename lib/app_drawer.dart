import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/login.dart';
import 'user_profile/user_profile.dart';
import 'quizzes/quizzes_page.dart';
import 'trivia/trivia_page.dart';
import 'notifications/notifications_page.dart';
import 'premium/premium_page.dart';
import 'history/history_page.dart';

class AppDrawer extends StatefulWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  const AppDrawer({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('lib/assets/logo.jpg'),
                  fit: BoxFit.fill, // Fill the entire container
                ),
              ),
              child: Center(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDrawerItem(
                    title: 'Profile',
                    icon: Icons.person,
                    onTap: () {
                      widget.onDrawerItemTap(0); // Call the callback with index 0
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(user: widget.user, selectedIndex: 0, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 0,
                  ),
                  _buildDrawerItem(
                    title: 'Quizzes',
                    icon: Icons.quiz,
                    onTap: () {
                      widget.onDrawerItemTap(1); // Call the callback with index 1
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzesPage(user: widget.user, selectedIndex: 1, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 1,
                  ),
                  _buildDrawerItem(
                    title: 'Trivia',
                    icon: Icons.lightbulb_outline,
                    onTap: () {
                      widget.onDrawerItemTap(2); // Call the callback with index 2
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TriviaPage(user: widget.user, selectedIndex: 2, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 2,
                  ),
                  _buildDrawerItem(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    onTap: () {
                      widget.onDrawerItemTap(3); // Call the callback with index 3
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsPage(user: widget.user, selectedIndex: 3, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 3,
                  ),
                  _buildDrawerItem(
                    title: 'Premium',
                    icon: Icons.star,
                    onTap: () {
                      widget.onDrawerItemTap(4); // Call the callback with index 4
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PremiumPage(user: widget.user, selectedIndex: 4, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 4,
                  ),
                  _buildDrawerItem(
                    title: 'History',
                    icon: Icons.history,
                    onTap: () {
                      widget.onDrawerItemTap(5); // Call the callback with index 5
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryPage(user: widget.user, selectedIndex: 5, onDrawerItemTap: widget.onDrawerItemTap),
                        ),
                      );
                    },
                    selected: widget.selectedIndex == 5,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool selected,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.blue : null, // Change color if selected
          fontWeight: selected ? FontWeight.bold : null, // Bold if selected
        ),
      ),
      leading: Icon(icon, color: selected ? Colors.blue : null), // Change icon color if selected
      onTap: onTap,
    );
  }
}
