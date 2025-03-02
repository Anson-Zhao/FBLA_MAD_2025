import '/components/button_widget.dart';
import '/components/stroke_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'splash_widget.dart' show SplashWidget;
import 'package:flutter/material.dart';

class SplashModel extends FlutterFlowModel<SplashWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StrokeButton component.
  late StrokeButtonModel strokeButtonModel;
  // Model for Button component.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    strokeButtonModel = createModel(context, () => StrokeButtonModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    strokeButtonModel.dispose();
    buttonModel.dispose();
  }
}
