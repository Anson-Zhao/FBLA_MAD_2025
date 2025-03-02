import 'dart:async';
import 'package:edu_venture/games/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';


class Road extends ParallaxComponent {
  static Vector2 initialBaseVelocity = Vector2(0, -800);
  static Vector2 velocityMultiplier = Vector2(1.0, 1.0);
  static const double initialXOffset = -220.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadParallax();
    _initializePosition();
  }

  Future<void> _loadParallax() async {
    parallax = await Parallax.load(
      [ParallaxImageData('road_3.png')],
      baseVelocity: initialBaseVelocity,
      velocityMultiplierDelta: velocityMultiplier,
      repeat: ImageRepeat.repeatY,
    );
  }

  void _initializePosition() {
    position = Vector2(initialXOffset, -gameHeight / 2);
    anchor = Anchor.topLeft;
  }

  void stopRoad() {
    if (parallax != null) {
      parallax!.baseVelocity = Vector2.zero();
    }
  }
}
