import '/components/back_button_widget.dart';
import '/components/blocked_game_button_widget.dart';
import '/components/game_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quiz_one_widget.dart' show QuizOneWidget;
import 'package:flutter/material.dart';

class QuizOneModel extends FlutterFlowModel<QuizOneWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for GameButton component.
  late GameButtonModel gameButtonModel1;
  // Model for GameButton component.
  late GameButtonModel gameButtonModel2;
  // Model for BlockedGameButton component.
  late BlockedGameButtonModel blockedGameButtonModel1;
  // Model for BlockedGameButton component.
  late BlockedGameButtonModel blockedGameButtonModel2;
  // Model for BlockedGameButton component.
  late BlockedGameButtonModel blockedGameButtonModel3;
  // Model for BackButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    gameButtonModel1 = createModel(context, () => GameButtonModel());
    gameButtonModel2 = createModel(context, () => GameButtonModel());
    blockedGameButtonModel1 =
        createModel(context, () => BlockedGameButtonModel());
    blockedGameButtonModel2 =
        createModel(context, () => BlockedGameButtonModel());
    blockedGameButtonModel3 =
        createModel(context, () => BlockedGameButtonModel());
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    gameButtonModel1.dispose();
    gameButtonModel2.dispose();
    blockedGameButtonModel1.dispose();
    blockedGameButtonModel2.dispose();
    blockedGameButtonModel3.dispose();
    backButtonModel.dispose();
  }
}
