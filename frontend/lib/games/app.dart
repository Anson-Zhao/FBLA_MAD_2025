import 'package:edu_venture/games/constants.dart';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:edu_venture/games/ui/button_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameMath extends StatefulWidget {
  final String sign;
  final String level;
  const GameMath({super.key, required this.sign, required this.level});

  @override
  State<GameMath> createState() => _GameMathState();
}

class _GameMathState extends State<GameMath> {
  GoGreenGame? game; // Make game nullable

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
              child: StatefulBuilder(
                builder: (context, setState) {
                  if (game == null) {
                    game = GoGreenGame(
                      context: context,
                      sign: widget.sign,
                      level: widget.level,
                    );
                  }

                  return Stack(
                    children: [
                      SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(game: game!),
                      ),
                      SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: ButtonScreen(
                          game: game!,
                          world: game!.gameWorld,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
