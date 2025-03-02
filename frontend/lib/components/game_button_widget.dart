import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'game_button_model.dart';
export 'game_button_model.dart';

class GameButtonWidget extends StatefulWidget {
  const GameButtonWidget({
    super.key,
    this.text,
  });

  final String? text;

  @override
  State<GameButtonWidget> createState() => _GameButtonWidgetState();
}

class _GameButtonWidgetState extends State<GameButtonWidget> {
  late GameButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameButtonModel());
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
      height: 46.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Align(
        alignment: const AlignmentDirectional(-1.0, 0.0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              widget.text,
              'Level 1',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Prompt',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
          ),
        ),
      ),
    );
  }
}
