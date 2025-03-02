import 'dart:async';

import 'package:edu_venture/games/cars/ai_car.dart';
import 'package:edu_venture/games/cars/car.dart';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:edu_venture/games/game/go_green_world.dart';
import 'package:flame/components.dart';


class Finish extends SpriteComponent with HasGameRef<GoGreenGame> {
  Car? playerCar;
  AiCar? aiCar;
  late GoGreenWorld world;
  bool shouldMove = false;
  bool gameEnded = false;
  double targetY = -380;

  @override
  FutureOr<void> onLoad() async {
    world = gameRef.gameWorld;
    sprite = await Sprite.load("finish.png");
    position = Vector2(0, -(gameRef.size.y / 2) - size.y / 2 - 20);
    anchor = Anchor.center;
    size = Vector2(440, 200);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gameEnded) {
      if (playerCar!.position.y <= -380 || aiCar!.position.y <= -380) {
        shouldMove = true;
        targetY = (playerCar!.position.y <= -380) ? playerCar!.position.y : aiCar!.position.y;
      }

      if (shouldMove) {
        double speed = 720;
        position.y += dt * speed;

        if (position.y >= targetY) {
          position.y = targetY;
          shouldMove = false;
          stopGame();
        }
      }
    }
  }

  void stopGame() {
    gameEnded = true;
    world.stopAllMovement();
    playerCar?.stop();
    aiCar?.stop();
  }
}
