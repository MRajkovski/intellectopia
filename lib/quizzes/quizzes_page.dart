import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_drawer.dart';
import 'quiz_model.dart';
import 'quiz_main.dart';

class QuizzesPage extends StatelessWidget {
  final User? user;
  final int selectedIndex;
  final Function(int) onDrawerItemTap;

  QuizzesPage({
    Key? key,
    required this.user,
    required this.selectedIndex,
    required this.onDrawerItemTap,
  }) : super(key: key);

  // Sample quiz data (Replace this with data from Firebase)
  final List<Quiz> quizzes = [
    Quiz(
      id: '1',
      title: 'Quiz 1',
      categories: ['Category C', 'Category D'],
      difficulty: 1,
      description: 'This is quiz 2 description.',
      questions: [
        Question(
          question: 'Question 1?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 1,
        ),
        Question(
          question: 'Question 2?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
        Question(
          question: 'Question 3?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 0,
        ),
        Question(
          question: 'Question 4?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 3,
        ),
        Question(
          question: 'Question 5?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
      ],
    ),
    Quiz(
      id: '2',
      title: 'Quiz 2',
      categories: ['Category C', 'Category D'],
      difficulty: 2,
      description: 'This is quiz 2 description.',
      questions: [
        Question(
          question: 'Question 1?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 1,
        ),
        Question(
          question: 'Question 2?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
        Question(
          question: 'Question 3?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 0,
        ),
        Question(
          question: 'Question 4?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 3,
        ),
        Question(
          question: 'Question 5?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
      ],
    ),
    Quiz(
      id: '3',
      title: 'Quiz 3',
      categories: ['Category C', 'Category D'],
      difficulty: 3,
      description: 'This is quiz 2 description.',
      questions: [
        Question(
          question: 'Question 1?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 1,
        ),
        Question(
          question: 'Question 2?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
        Question(
          question: 'Question 3?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 0,
        ),
        Question(
          question: 'Question 4?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 3,
        ),
        Question(
          question: 'Question 5?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
      ],
    ),
    Quiz(
      id: '4',
      title: 'Quiz 4',
      categories: ['Category C', 'Category D'],
      difficulty: 4,
      description: 'This is quiz 2 description.',
      questions: [
        Question(
          question: 'Question 1?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 1,
        ),
        Question(
          question: 'Question 2?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
        Question(
          question: 'Question 3?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 0,
        ),
        Question(
          question: 'Question 4?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 3,
        ),
        Question(
          question: 'Question 5?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
      ],
    ),
    Quiz(
      id: '5',
      title: 'Quiz 5',
      categories: ['Category C', 'Category D'],
      difficulty: 5,
      description: 'This is quiz 2 description.',
      questions: [
        Question(
          question: 'Question 1?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 1,
        ),
        Question(
          question: 'Question 2?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
        Question(
          question: 'Question 3?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 0,
        ),
        Question(
          question: 'Question 4?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 3,
        ),
        Question(
          question: 'Question 5?',
          options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
          correctOption: 2,
        ),
      ],
    ),
  ];

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
      body: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return ListTile(
            title: Text(quiz.title),
            subtitle: Text(quiz.description),
            trailing: ElevatedButton(
              onPressed: () {
                // Navigate to QuizMain when "Start Quiz" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizMain(quiz: quiz, user: user),
                  ),
                );
              },
              child: Text('Start Quiz'),
            ),
          );
        },
      ),
    );
  }
}
