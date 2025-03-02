import '/components/back_button_widget.dart';
import '/components/subject_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'basics_widget.dart' show BasicsWidget;
import 'package:flutter/material.dart';

class BasicsModel extends FlutterFlowModel<BasicsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SubjectButton component.
  late SubjectButtonModel subjectButtonModel1;
  // Model for SubjectButton component.
  late SubjectButtonModel subjectButtonModel2;
  // Model for SubjectButton component.
  late SubjectButtonModel subjectButtonModel3;
  // Model for SubjectButton component.
  late SubjectButtonModel subjectButtonModel4;
  // Model for BackButton component.
  late BackButtonModel backButtonModel;

  @override
  void initState(BuildContext context) {
    subjectButtonModel1 = createModel(context, () => SubjectButtonModel());
    subjectButtonModel2 = createModel(context, () => SubjectButtonModel());
    subjectButtonModel3 = createModel(context, () => SubjectButtonModel());
    subjectButtonModel4 = createModel(context, () => SubjectButtonModel());
    backButtonModel = createModel(context, () => BackButtonModel());
  }

  @override
  void dispose() {
    subjectButtonModel1.dispose();
    subjectButtonModel2.dispose();
    subjectButtonModel3.dispose();
    subjectButtonModel4.dispose();
    backButtonModel.dispose();
  }
}
