import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'games_widget.dart' show GamesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GamesModel extends FlutterFlowModel<GamesWidget> {
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
