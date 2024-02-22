import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatarPage extends StatefulWidget {
  @override
  _UserAvatarPageState createState() => _UserAvatarPageState();
}

class _UserAvatarPageState extends State<UserAvatarPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveImage() {
    // Implement save image logic here
    // For example, you can upload the image to Firebase Storage
  }

  void _cancel() {
    // Implement cancel logic here
    // For example, you can navigate back to the UserProfilePage
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Avatar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, width: 200, height: 200)
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Take Photo'),
            ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Choose from Gallery'),
            ),
            ElevatedButton(
              onPressed: _saveImage,
              child: Text('Save Image'),
            ),
            ElevatedButton(
              onPressed: _cancel,
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
