import '/components/button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'edit_widget.dart' show EditWidget;
import 'package:flutter/material.dart';

class EditModel extends FlutterFlowModel<EditWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TextInput component.
  late TextInputModel textInputModel;
  // Model for Button component.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textInputModel = createModel(context, () => TextInputModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textInputModel.dispose();
    buttonModel.dispose();
  }
}
