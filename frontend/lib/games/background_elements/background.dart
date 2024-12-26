import 'dart:async';

import 'package:edu_venture/games/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Background extends ParallaxComponent {
  static Vector2 initialBaseVelocity = Vector2(0, -800);
  static Vector2 velocityMultiplier = Vector2(1.0, 1.0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadParallax();
    _initializePositionAndSize();
  }

  Future<void> _loadParallax() async {
    parallax = await Parallax.load(
      [ParallaxImageData('background-2.png')],
      baseVelocity: initialBaseVelocity,
      velocityMultiplierDelta: velocityMultiplier,
      repeat: ImageRepeat.repeatY,
    );
  }

  void _initializePositionAndSize() {
    size = Vector2(game.size.x, game.size.y);
    position = Vector2(-gameWidth / 2, -gameHeight / 2);
    anchor = Anchor.topLeft;
  }

  void stopBackground() {
    if (parallax != null) {
      parallax!.baseVelocity = Vector2.zero();
    }
  }
}
