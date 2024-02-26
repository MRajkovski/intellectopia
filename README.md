# Intellectopia Documentation

## Introduction
This documentation provides an overview and guidance for setting up and understanding the structure of a Flutter project used for MIS 2024

### Project Overview
This application allows users to get interesting facts, and take quizzes on topics of their choice.
The project includes functionalities such as:

- User authentication
- User profiles
- Quizzes
- Trivia page

## Getting Started

### Prerequisites
- Flutter SDK installed on your machine
- Dart SDK installed on your machine
- Android Studio / VS Code / any preferred IDE for Flutter development

### Installation
1. Clone the repository to your local machine.
   ```
   git clone https://github.com/MRajkovski/intellectopia
   ```

2. Navigate to the project directory.
   ```
   cd intellectopia
   ```

3. Install dependencies.
   ```
   flutter pub get
   ```

### Running the App
To run the app on a simulator or a physical device:
```
flutter run
```

## Project Structure
The project follows a structured architecture to maintain code readability and scalability.

### `lib` Directory
- `main.dart`: Entry point of the application
- `app_drawer.dart`: Slidable side menu for navigation
- `assts/`: Contains static assets used in the application
- `auth/`: Auth UI components
  - `login.dart`: Login widget
  - `register.dart`: Register widget 
- `history/`: History UI components used for viewing past quiz results and search history
  - `history_page.dart`: History page widget and search history
- `notifications/`: Notifications components
  - `notifications_page.dart`: Notifications page widget
- `premium/`: Premium UI components used for viewing plans and premium features
  - `premium_page.dart`: Premium page widget
- `quizzes/`: Quiz UI components
  - `quiz_main.dart`: Quiz widget 
  - `quiz_model.dart`: Quiz model
  - `quiz_result.dart`: Quiz result widget
  - `quizzes_main.dart`: List of available quizzes widget
- `trivia/`: Trivia components
  - `trivia_page.dart`: Trivia page widget
- `user_profile/`: User profile components
  - `edit_profile.dart`: Page where user can edit account information
  - `user_profile.dart`: Page where user can view account information
  - `user_avatar.dart`: Page where user can set their account avatar

## Contributors
- Martin Rajkovski 181557
- Marko Markovikj 181161

## Image sneak peak [here](https://ibb.co/album/S5G01s)
