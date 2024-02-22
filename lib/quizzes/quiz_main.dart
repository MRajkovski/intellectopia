import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intellectopia/quizzes/quiz_result.dart';
import 'package:intellectopia/quizzes/quizzes_page.dart';
import 'quiz_model.dart';
import '../app_drawer.dart';

class QuizMain extends StatefulWidget {
  final Quiz quiz;
  final User? user;

  QuizMain({required this.quiz, required this.user});

  @override
  _QuizMainState createState() => _QuizMainState();
}

class _QuizMainState extends State<QuizMain> {
  int _currentQuestionIndex = 0;
  List<int> _selectedOptions = [];
  late Timer _timer;
  int _timerSeconds = 30;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.filled(widget.quiz.questions.length, 0);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer.cancel();
          _selectedOptions[_currentQuestionIndex] =
              _selectedOptions[_currentQuestionIndex] == -1
                  ? 0
                  : _selectedOptions[_currentQuestionIndex];
          if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
            _nextQuestion();
            _timerSeconds = 30;
            _startTimer();
          } else {
            _finishQuiz();
          }
        }
      });
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _timerSeconds = 30;
    });
  }

  void _selectOption(int optionIndex) {
    setState(() {
      _selectedOptions[_currentQuestionIndex] = optionIndex;
    });
  }

  void _finishQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResult(
          quiz: widget.quiz,
          selectedOptions: _selectedOptions,
          user: widget.user,
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.question,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: question.options.length,
          itemBuilder: (context, index) {
            return RadioListTile<int>(
              title: Text(question.options[index]),
              value: index,
              groupValue: _selectedOptions[_currentQuestionIndex],
              onChanged: (value) {
                _selectOption(value!);
              },
            );
          },
        ),
        SizedBox(height: 20),
        Text(
          'Time Left: $_timerSeconds seconds',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.quiz.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      drawer: AppDrawer(
          user: widget.user, selectedIndex: 1, onDrawerItemTap: (index) {}),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuestion(currentQuestion),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentQuestionIndex < widget.quiz.questions.length - 1)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text('Next Question'),
                  ),
                if (_currentQuestionIndex == widget.quiz.questions.length - 1)
                  ElevatedButton(
                    onPressed: _finishQuiz,
                    child: Text('Finish'),
                  ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizzesPage(
                      user: widget.user,
                      selectedIndex: 1,
                      onDrawerItemTap: (index) {},
                    ),
                  ),
                );
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
