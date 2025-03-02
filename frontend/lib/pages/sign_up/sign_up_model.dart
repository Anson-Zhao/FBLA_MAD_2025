import '/components/button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sign_up_widget.dart' show SignUpWidget;
import 'package:flutter/material.dart';

class SignUpModel extends FlutterFlowModel<SignUpWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextInput component.
  late TextInputModel textInputModel1;
  // Model for TextInput component.
  late TextInputModel textInputModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for Button component.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textInputModel1 = createModel(context, () => TextInputModel());
    textInputModel2 = createModel(context, () => TextInputModel());
    passwordVisibility1 = false;
    passwordVisibility2 = false;
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textInputModel1.dispose();
    textInputModel2.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    buttonModel.dispose();
  }
}
