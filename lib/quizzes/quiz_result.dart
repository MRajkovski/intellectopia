import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellectopia/quizzes/quiz_model.dart';
import '../app_drawer.dart';
import 'quizzes_page.dart';

class QuizResult extends StatelessWidget {
  final User? user;
  final Quiz quiz;
  final List<int> selectedOptions;

  QuizResult(
      {required this.quiz, required this.selectedOptions, required this.user});

  void _onDrawerItemTap(int index) {
  }

  @override
  Widget build(BuildContext context) {
    int score = 0;
    for (int i = 0; i < selectedOptions.length; i++) {
      if (selectedOptions[i] == quiz.questions[i].correctOption) {
        score++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      drawer: AppDrawer(
        user: user,
        selectedIndex: 0,
        onDrawerItemTap: _onDrawerItemTap,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/${quiz.questions.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizzesPage(
                      user: user,
                      selectedIndex: 1,
                      onDrawerItemTap: _onDrawerItemTap,
                    ),
                  ),
                );
              },
              child: Text('Back to Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}
