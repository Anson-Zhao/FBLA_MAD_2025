import '/components/back_button_widget.dart';
import '/components/button_widget.dart';
import '/components/stroke_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for BackButton component.
  late BackButtonModel backButtonModel;
  // Model for Button component.
  late ButtonModel buttonModel;
  // Model for StrokeButton component.
  late StrokeButtonModel strokeButtonModel;

  @override
  void initState(BuildContext context) {
    backButtonModel = createModel(context, () => BackButtonModel());
    buttonModel = createModel(context, () => ButtonModel());
    strokeButtonModel = createModel(context, () => StrokeButtonModel());
  }

  @override
  void dispose() {
    backButtonModel.dispose();
    buttonModel.dispose();
    strokeButtonModel.dispose();
  }
}
