import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'quizzes_widget.dart' show QuizzesWidget;
import 'package:flutter/material.dart';

class QuizzesModel extends FlutterFlowModel<QuizzesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BackButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
  }
}
