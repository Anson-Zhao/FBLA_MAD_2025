
import 'package:edu_venture/games/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class ProgressBar extends PositionComponent with HasGameRef {
  final double barHeight;
  double playerProgress;
  double aiProgress;
  final Sprite playerIcon;
  final Sprite aiIcon;
  final Sprite finishIcon;

  late double totalWidth;

  ProgressBar({
    required this.barHeight,
    required this.playerProgress,
    required this.aiProgress,
    required this.playerIcon,
    required this.aiIcon,
    required this.finishIcon,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    totalWidth = gameWidth;
    size = Vector2(totalWidth, barHeight);
    position = Vector2(-gameRef.size.x / 2, -gameRef.size.y / 2 );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint backgroundPaint = Paint()..color = Colors.white;
    final Paint playerBarPaint = Paint()..color = Colors.red;
    final Paint aiBarPaint = Paint()..color = Colors.grey;

    // Draw background bar from left edge
    canvas.drawRect(
      Rect.fromLTWH(0, 0, totalWidth, barHeight),
      backgroundPaint,
    );

    // Draw player progress bar from left edge
    canvas.drawRect(
      Rect.fromLTWH(0, 0, totalWidth * playerProgress, barHeight),
      playerBarPaint,
    );

    // Draw AI progress bar from left edge
    canvas.drawRect(
      Rect.fromLTWH(0, 0, totalWidth * aiProgress, barHeight),
      aiBarPaint,
    );

        // Draw finish line icon
    finishIcon.render(
      canvas,
      position: Vector2(
        totalWidth - barHeight,
        0,
      ),
      size: Vector2(barHeight, barHeight),
    );
    
    // Draw player car icon
    playerIcon.render(
      canvas,
      position: Vector2(
        totalWidth * playerProgress - (barHeight / 2),
        0,
      ),
      size: Vector2(barHeight, barHeight),
    );

    // Draw AI car icon
    aiIcon.render(
      canvas,
      position: Vector2(
        totalWidth * aiProgress - (barHeight / 2),
        0,
      ),
      size: Vector2(barHeight, barHeight),
    );


  }
}
