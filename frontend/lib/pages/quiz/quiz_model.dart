import '/components/quiz_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'quiz_widget.dart' show QuizWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuizModel extends FlutterFlowModel<QuizWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for QuizButton component.
  late QuizButtonModel quizButtonModel1;
  // Model for QuizButton component.
  late QuizButtonModel quizButtonModel2;
  // Model for QuizButton component.
  late QuizButtonModel quizButtonModel3;
  // Model for QuizButton component.
  late QuizButtonModel quizButtonModel4;

  @override
  void initState(BuildContext context) {
    quizButtonModel1 = createModel(context, () => QuizButtonModel());
    quizButtonModel2 = createModel(context, () => QuizButtonModel());
    quizButtonModel3 = createModel(context, () => QuizButtonModel());
    quizButtonModel4 = createModel(context, () => QuizButtonModel());
  }

  @override
  void dispose() {
    quizButtonModel1.dispose();
    quizButtonModel2.dispose();
    quizButtonModel3.dispose();
    quizButtonModel4.dispose();
  }
}
