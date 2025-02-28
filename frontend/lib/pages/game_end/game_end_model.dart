import '/components/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'game_end_widget.dart' show GameEndWidget;
import 'package:flutter/material.dart';

class GameEndModel extends FlutterFlowModel<GameEndWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button component.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
