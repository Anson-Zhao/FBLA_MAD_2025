import '/components/stroke_button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'forgot_password_widget.dart' show ForgotPasswordWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordModel extends FlutterFlowModel<ForgotPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextInput component.
  late TextInputModel textInputModel;
  // Model for StrokeButton component.
  late StrokeButtonModel strokeButtonModel;

  @override
  void initState(BuildContext context) {
    textInputModel = createModel(context, () => TextInputModel());
    strokeButtonModel = createModel(context, () => StrokeButtonModel());
  }

  @override
  void dispose() {
    textInputModel.dispose();
    strokeButtonModel.dispose();
  }
}
