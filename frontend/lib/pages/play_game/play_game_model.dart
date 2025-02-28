import '/components/back_button_widget.dart';
import '/components/button_widget.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'play_game_widget.dart' show PlayGameWidget;
import 'package:flutter/material.dart';

class PlayGameModel extends FlutterFlowModel<PlayGameWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button component.
  late ButtonModel buttonModel;
  // Model for BackButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
    backButtonModel.dispose();
  }
}
