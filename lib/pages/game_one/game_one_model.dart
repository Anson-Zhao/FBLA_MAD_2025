import '/components/back_button_widget.dart';
import '/components/blocked_game_button_widget.dart';
import '/components/game_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'game_one_widget.dart' show GameOneWidget;
import 'package:flutter/material.dart';

class GameOneModel extends FlutterFlowModel<GameOneWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for GameButton component.
  late GameButtonModel gameButtonModel1;
  // Model for GameButton component.
  late GameButtonModel gameButtonModel2;
  // Model for BlockedGameButton component.
  late GameButtonModel gameButtonModel3;
  // Model for BlockedGameButton component.
  late GameButtonModel gameButtonModel4;
  // Model for BlockedGameButton component.
  late BlockedGameButtonModel blockedGameButtonModel3;
  // Model for BackButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    gameButtonModel1 = createModel(context, () => GameButtonModel());
    gameButtonModel2 = createModel(context, () => GameButtonModel());
    gameButtonModel3 = createModel(context, () => GameButtonModel());
    gameButtonModel4 = createModel(context, () => GameButtonModel());
    blockedGameButtonModel3 =
        createModel(context, () => BlockedGameButtonModel());
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    gameButtonModel1.dispose();
    gameButtonModel2.dispose();
    gameButtonModel3.dispose();
    gameButtonModel4.dispose();
    blockedGameButtonModel3.dispose();
    backButtonModel.dispose();
  }
}
