import 'dart:async';
import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:flame/components.dart';


class Car extends SpriteComponent with HasGameRef<GoGreenGame> {
  final double initialXPosition;
  final double initialYPosition;
  final String carModel;
  bool shouldUpdatePosition = false;
  bool isMoving = true;
  static const double movementSpeed = 100.0;
  static const double targetMovement = 40.0;
  double distanceMoved = 0.0;

  Car(this.initialXPosition, this.carModel, this.initialYPosition);

  @override
  FutureOr<void> onLoad() async {
    await _loadSprite();
    _initializePosition();
  }

  Future<void> _loadSprite() async {
    sprite = await Sprite.load(carModel);
    size = Vector2(100, 200);
  }

  void _initializePosition() {
    position = Vector2(initialXPosition, gameHeight / 2 - initialYPosition);
    anchor = Anchor.topCenter;
  }

  @override
  void update(double dt) {
    if (!isMoving) return;
    super.update(dt);
    
    if (shouldUpdatePosition) {
      _updatePosition(dt);
    }
  }

  void _updatePosition(double dt) {
    double moveAmount = movementSpeed * dt;
    distanceMoved += moveAmount;
    position.y -= moveAmount;

    if (distanceMoved >= targetMovement) {
      position.y += (distanceMoved - targetMovement);
      shouldUpdatePosition = false;
      distanceMoved = 0.0;
    }
  }

  void stop() {
    isMoving = false;
    shouldUpdatePosition = false;
  }

  void triggerPositionUpdate() {
    shouldUpdatePosition = true;
    distanceMoved = 0.0;
  }

  double calculateRoadPercentage() {
    double startPosition = gameHeight / 2 - initialYPosition;
    const double finishPosition = -440;
    final percentage = (startPosition - position.y) / (startPosition - finishPosition);
    return percentage.clamp(0.0 , 1.0);
  }
}
