import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'subject_button_model.dart';
export 'subject_button_model.dart';

class SubjectButtonWidget extends StatefulWidget {
  const SubjectButtonWidget({
    super.key,
    required this.buttonLabel,
  });

  final String? buttonLabel;

  @override
  State<SubjectButtonWidget> createState() => _SubjectButtonWidgetState();
}

class _SubjectButtonWidgetState extends State<SubjectButtonWidget> {
  late SubjectButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubjectButtonModel());
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
      height: 41.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(70.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 3.0,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Text(
          valueOrDefault<String>(
            widget!.buttonLabel,
            'hello',
          ),
          style: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Prompt',
                color: FlutterFlowTheme.of(context).primary,
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
