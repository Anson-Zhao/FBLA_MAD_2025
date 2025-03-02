import '/components/stroke_button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'notification_widget.dart' show NotificationWidget;
import 'package:flutter/material.dart';

class NotificationModel extends FlutterFlowModel<NotificationWidget> {
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
