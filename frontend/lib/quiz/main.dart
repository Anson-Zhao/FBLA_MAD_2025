import 'package:edu_venture/quiz/quizScreen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: QuizScreen(),
    );
  }
}