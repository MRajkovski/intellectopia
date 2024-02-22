import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  final String firstName;
  final String lastName;
  final String email;

  const EditProfilePage({Key? key, required this.user, required this.firstName, required this.lastName, required this.email}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController newEmailController;
  late TextEditingController verificationCodeController;
  late TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    newEmailController = TextEditingController(text: widget.email);
    verificationCodeController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 16),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _updateProfile(context);
                      },
                      child: Text('Save Changes'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: newEmailController,
                decoration: InputDecoration(labelText: 'New Email'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _changeEmail(context);
                      },
                      child: Text('Change Email'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _resetPassword(context);
                      },
                      child: Text('Change Password'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName('${firstNameController.text} ${lastNameController.text}');
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(newEmailController.text); // Update email
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(widget.user!.uid).update({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': newEmailController.text,
      });

      // Show a success message or navigate back to UserProfilePage
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated successfully!'),
      ));
      Navigator.pop(context); // Go back to UserProfilePage
    } catch (e) {
      // Handle errors
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile. Please try again.'),
      ));
    }
  }

  Future<void> _changeEmail(BuildContext context) async {
    try {
      // Prompt the user to enter their current password
      String? currentPassword = await _showPasswordDialog(context);
      if (currentPassword == null) {
        return; // User cancelled, do nothing
      }

      // Reauthenticate the user with their current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: widget.email,
        password: currentPassword,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);

      // After successful reauthentication, send a verification email to the new email
      print("NewEmail: "+newEmailController.text);
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(newEmailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A verification link has been sent to your new email. Please check your inbox.'),
        ),
      );
    } catch (e) {
      // Handle errors
      print("Error resetting email: $e");
      String errorMessage = 'Failed to reset email. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          errorMessage = 'Invalid password. Please enter the correct password.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<String?> _showPasswordDialog(BuildContext context) async {
    String? password;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Enter your current password'),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(password);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );

    return password;
  }

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A password reset link has been sent to your email. Please check your inbox.'),
        ),
      );
    } catch (e) {
      print("Error resetting password: $e");
      String errorMessage = 'Failed to reset password. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address. Please enter a valid email.';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'User with this email does not exist.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }


  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    newEmailController.dispose();
    verificationCodeController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
