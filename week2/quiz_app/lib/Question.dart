import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  const Question(this.questionText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      questionText,
      style: const TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
