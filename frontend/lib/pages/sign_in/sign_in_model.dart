import '/components/button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sign_in_widget.dart' show SignInWidget;
import 'package:flutter/material.dart';

class SignInModel extends FlutterFlowModel<SignInWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextInput component.
  late TextInputModel textInputModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for Button component.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textInputModel = createModel(context, () => TextInputModel());
    passwordVisibility = false;
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textInputModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    buttonModel.dispose();  
  }
}
