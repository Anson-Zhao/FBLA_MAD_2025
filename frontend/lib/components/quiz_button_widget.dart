import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'quiz_button_model.dart';
export 'quiz_button_model.dart';

class QuizButtonWidget extends StatefulWidget {
  const QuizButtonWidget({
    super.key,
    this.answerVal,
    Color? correctness,
  }) : correctness = correctness ?? const Color(0x41FFFFFF);

  final String? answerVal;
  final Color correctness;

  @override
  State<QuizButtonWidget> createState() => _QuizButtonWidgetState();
}

class _QuizButtonWidgetState extends State<QuizButtonWidget> {
  late QuizButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondary,
        borderRadius: BorderRadius.circular(70.0),
        border: Border.all(
          color: widget.correctness,
          width: 2.0,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(-1.0, 0.0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              widget.answerVal,
              'val',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Prompt',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ),
    );
  }
}
