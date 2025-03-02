
import 'package:edu_venture/games/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class Question extends PositionComponent {
  final List<int> numbers;
  final String action;

  Question({required this.numbers, required this.action}) {
    size = Vector2(gameWidth * 3 / 4, 250);
    position = Vector2(0, -gameHeight / 2 + 200);
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Additional loading logic can be placed here if needed in the future.
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _drawBackground(canvas);
    _drawQuestionText(canvas);
  }

  void _drawBackground(Canvas canvas) {
    final Paint backgroundPaint = Paint()
      ..color = const Color(0xFF263238)
      ..style = PaintingStyle.fill;

    final RRect backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      const Radius.circular(40),
    );

    canvas.drawRRect(backgroundRect, backgroundPaint);
  }

  void _drawQuestionText(Canvas canvas) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${numbers[0]} $action ${numbers[1]} = ?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final Offset textOffset = Offset(
      (size.x - textPainter.width) / 2,
      (size.y - textPainter.height) / 2,
    );

    textPainter.paint(canvas, textOffset);
  }
}
