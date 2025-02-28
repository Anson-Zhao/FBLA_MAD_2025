import '/components/back_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'topic_cards_widget.dart' show TopicCardsWidget;
import 'package:flutter/material.dart';

class TopicCardsModel extends FlutterFlowModel<TopicCardsWidget> {
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
