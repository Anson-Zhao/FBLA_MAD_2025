import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'achievements_track_model.dart';
export 'achievements_track_model.dart';

class AchievementsTrackWidget extends StatefulWidget {
  const AchievementsTrackWidget({
    super.key,
    this.text,
    this.achieved,
    this.achievements,
  });

  final String? text;
  final String? achieved;
  final String? achievements;

  @override
  State<AchievementsTrackWidget> createState() =>
      _AchievementsTrackWidgetState();
}

class _AchievementsTrackWidgetState extends State<AchievementsTrackWidget> {
  late AchievementsTrackModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AchievementsTrackModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget.text,
                'Achievements',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Prompt',
                    color: FlutterFlowTheme.of(context).secondary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                  child: Container(
                    width: 49.0,
                    height: 43.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/Vector.png',
                        ).image,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.achieved,
                      '1',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Prompt',
                          fontSize: 48.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Text(
                  '/',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Prompt',
                        color: const Color(0x7F263238),
                        fontSize: 48.0,
                        letterSpacing: 0.0,
                      ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 1.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.achievements,
                      '2',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Prompt',
                          color: const Color(0x80000000),
                          fontSize: 36.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
