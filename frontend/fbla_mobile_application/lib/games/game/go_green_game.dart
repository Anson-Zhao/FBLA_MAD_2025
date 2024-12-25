import 'dart:math';
import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';


class GoGreenGame extends FlameGame {
  late final GoGreenWorld gameWorld;

  GoGreenGame()
      : super(
            camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        )) {
    gameWorld = GoGreenWorld([Random().nextInt(10), Random().nextInt(10)], "+");
    world = gameWorld;
  }

  void pauseGame() {
    gameWorld.stopAllMovement();
  }

  void resumeGame() {
    gameWorld.isPaused = false;
    // Add any additional reset logic here
  }
}
