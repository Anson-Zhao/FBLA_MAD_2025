import 'dart:math';
import 'dart:ui';
import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class GoGreenGame extends FlameGame {
  late final GoGreenWorld gameWorld;
  final VoidCallback onGameEnd; // Callback for navigation
  final String sign;

  GoGreenGame({required this.onGameEnd, required this.sign})
      : super(
            camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        )) {
    gameWorld = GoGreenWorld(
      [Random().nextInt(10), Random().nextInt(10)],
      sign,
      onGameEnd: onGameEnd, // Pass the callback to the game world
    );
    world = gameWorld;
  }

  void pauseGame() {
    gameWorld.stopAllMovement();
  }

  void resumeGame() {
    gameWorld.isPaused = false;
  }
}
