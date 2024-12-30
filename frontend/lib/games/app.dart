import 'package:edu_venture/flutter_flow/flutter_flow_util.dart';
import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:edu_venture/games/ui/button_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameMath extends StatefulWidget {
  final String sign; // The operation sign (+, -, *, /)
  const GameMath({super.key, required this.sign});

  @override
  State<GameMath> createState() => _GameMathState();
}

class _GameMathState extends State<GameMath> {
  late final GoGreenGame game;

  @override
  void initState() {
    super.initState();
    game = GoGreenGame(
      onGameEnd: () {
        // Navigate to the end game screen
        GoRouter.of(context).go('/endGame');
        print("ON GAME END");
      },
      sign: widget.sign, // Pass the operation sign to GoGreenGame
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF263238),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FittedBox(
              child: Stack(
                children: [
                  SizedBox(
                    width: gameWidth,
                    height: gameHeight,
                    child: GameWidget(game: game),
                  ),
                  SizedBox(
                    width: gameWidth,
                    height: gameHeight,
                    child: ButtonScreen(
                      game: game,
                      world: game.gameWorld,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
