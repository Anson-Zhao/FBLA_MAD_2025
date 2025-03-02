import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'stroke_button_model.dart';
export 'stroke_button_model.dart';

class StrokeButtonWidget extends StatefulWidget {
  const StrokeButtonWidget({
    super.key,
    String? buttonLabel,
  }) : buttonLabel = buttonLabel ?? 'text';

  final String buttonLabel;

  @override
  State<StrokeButtonWidget> createState() => _StrokeButtonWidgetState();
}

class _StrokeButtonWidgetState extends State<StrokeButtonWidget> {
  late StrokeButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StrokeButtonModel());
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
      height: 37.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(70.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 2.0,
        ),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Text(
          widget.buttonLabel,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Prompt',
                color: FlutterFlowTheme.of(context).primary,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
