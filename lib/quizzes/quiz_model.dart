class Quiz {
  final String id;
  final String title;
  final List<String> categories;
  final int difficulty;
  final String description;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.categories,
    required this.difficulty,
    required this.description,
    required this.questions,
  });
}

class Question {
  final String question;
  final List<String> options;
  final int correctOption;

  Question({
    required this.question,
    required this.options,
    required this.correctOption,
  });
}
