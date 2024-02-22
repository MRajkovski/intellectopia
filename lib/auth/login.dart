import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../trivia/trivia_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Navigate to TriviaPage on successful login and pass the User object via RouteSettings
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TriviaPage(user: userCredential.user!, selectedIndex: 2, onDrawerItemTap: (index) {}),
          settings: RouteSettings(arguments: userCredential.user),
        ),
      );
    } catch (e) {
      // Handle sign in errors (e.g., show error message)
      print("Sign in error: $e");
      // Show a snackbar for failed login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(52.0),
                child: Image.asset(
                  'lib/assets/logo.jpg', // Corrected image path
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signIn(context),
                child: Text('Sign In'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to RegisterPage
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
