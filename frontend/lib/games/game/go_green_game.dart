import 'dart:math';
import 'package:edu_venture/flutter_flow/flutter_flow_util.dart';
import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class GoGreenGame extends FlameGame {
  late final GoGreenWorld gameWorld;
  final BuildContext context; // Add context here
  final String sign;
  final String level;

  GoGreenGame({required this.context, required this.level, required this.sign})
      : super(
            camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        )) {
    gameWorld = GoGreenWorld(
      sign,
      randomInt(),
      onGameEnd: _handleGameEnd, // Pass the callback to the game world
    );
    world = gameWorld;
  }

  List<int> randomInt() {
    final List<int> numbers = [0, 0];

    if (sign == '/') {
      numbers[1] = Random().nextInt(9) + 1;
      int multiplier = Random().nextInt(10) + 1;
      numbers[0] = numbers[1] * multiplier; 
    } else {
      numbers[0] = Random().nextInt(10);
      numbers[1] = Random().nextInt(10);
    }

    return numbers;
  }

  // Callback function to handle game end
  void _handleGameEnd(bool didPlayerWin) {
    // Navigate based on win/loss
    if (didPlayerWin) {
      context.pushNamed(
        'WonGame', // Assuming 'PlayGame' is the correct route name
        queryParameters: {
          'level':
              level, // No need for serializeParam if level is already a String
          'action': sign, // Same here, assuming sign is a String
        }.withoutNulls,
      );
      print("Player Wins!");
    } else {
      context.pushNamed(
        'LostGame', // Assuming 'PlayGame' is the correct route name
        queryParameters: {
          'level':
              level, // No need for serializeParam if level is already a String
          'action': sign, // Same here, assuming sign is a String
        }.withoutNulls,
      );
      print("AI Wins!");
    }
  }

  void pauseGame() {
    gameWorld.stopAllMovement();
  }

  void resumeGame() {
    gameWorld.isPaused = false;
  }
}
