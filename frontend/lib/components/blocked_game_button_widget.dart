import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'blocked_game_button_model.dart';
export 'blocked_game_button_model.dart';

class BlockedGameButtonWidget extends StatefulWidget {
  const BlockedGameButtonWidget({
    super.key,
    this.text,
  });

  final String? text;

  @override
  State<BlockedGameButtonWidget> createState() =>
      _BlockedGameButtonWidgetState();
}

class _BlockedGameButtonWidgetState extends State<BlockedGameButtonWidget> {
  late BlockedGameButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlockedGameButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 46.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
            width: 4.0,
          ),
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
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
