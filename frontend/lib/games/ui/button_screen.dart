import 'dart:math';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:edu_venture/games/game/go_green_world.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class ButtonScreen extends StatefulWidget {
  final GoGreenGame game;
  final GoGreenWorld world;

  ButtonScreen({super.key, required this.game, required this.world});

  @override
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  final Random _random = Random();
  late List<int> answerList;
  late int correctAnswer;
  late List<Color> buttonColors;
  bool buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
    _generateAnswers();
  }

  void _generateAnswers() {
    if (widget.world.action == '+'){
      correctAnswer = widget.world.numbers.reduce((a, b) => a + b);
    } else if (widget.world.action == '*'){
      correctAnswer = widget.world.numbers.reduce((a, b) => a * b);
    } else if (widget.world.action == '-'){
      correctAnswer = widget.world.numbers.reduce((a, b) => a - b);
    } else {
      correctAnswer = widget.world.numbers.reduce((a, b) => a ~/ b);
    }
    Set<int> answers = {correctAnswer};

    while (answers.length < 4) {
      int randomAnswer = _random.nextInt(21);
      if (randomAnswer != correctAnswer) {
        answers.add(randomAnswer);
      }
    }

    answerList = answers.toList()..shuffle(_random);
    buttonColors = List<Color>.filled(4,Color(0xFF263238));
  }

  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 450;
    const double buttonHeight = 150;

    List<Offset> positions = [
      const Offset(40, 1500),
      const Offset(590, 1500),
      const Offset(40, 1700),
      const Offset(590, 1700),
    ];

    return Stack(
      children: List.generate(answerList.length, (index) {
        return _buildAnswerButton(index, positions[index], buttonWidth, buttonHeight);
      }),
    );
  }

  Widget _buildAnswerButton(int index, Offset position, double width, double height) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: buttonsEnabled ? () => _handleTap(index) : null,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: buttonColors[index],
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            answerList[index].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap(int index) {
    if (widget.world.isPaused) return;

    bool isCorrect = answerList[index] == correctAnswer;
    setState(() {
      buttonColors[index] = isCorrect ? Colors.green : Colors.red;
      buttonsEnabled = !isCorrect;
    });

    if (isCorrect) {
      widget.world.setAnswerCorrect(true);
      if (!widget.world.isPaused) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            widget.world.setNewQuestion(true);
            _generateAnswers();
            buttonsEnabled = true;
          });
        });
      }
    }
  }
}
