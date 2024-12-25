import '/components/achievements_track_widget.dart';
import '/components/achievements_unblocked_widget.dart';
import '/components/avhievements_blocked_widget.dart';
import '/components/progress_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'progress_page_widget.dart' show ProgressPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProgressPageModel extends FlutterFlowModel<ProgressPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AchievementsTrack component.
  late AchievementsTrackModel achievementsTrackModel1;
  // Model for AchievementsTrack component.
  late AchievementsTrackModel achievementsTrackModel2;
  // Model for AchievementsTrack component.
  late AchievementsTrackModel achievementsTrackModel3;
  // Model for AchievementsUnblocked component.
  late AchievementsUnblockedModel achievementsUnblockedModel1;
  // Model for AchievementsUnblocked component.
  late AchievementsUnblockedModel achievementsUnblockedModel2;
  // Model for AvhievementsBlocked component.
  late AvhievementsBlockedModel avhievementsBlockedModel1;
  // Model for AvhievementsBlocked component.
  late AvhievementsBlockedModel avhievementsBlockedModel2;
  // Model for ProgressBar component.
  late ProgressBarModel progressBarModel;

  @override
  void initState(BuildContext context) {
    achievementsTrackModel1 =
        createModel(context, () => AchievementsTrackModel());
    achievementsTrackModel2 =
        createModel(context, () => AchievementsTrackModel());
    achievementsTrackModel3 =
        createModel(context, () => AchievementsTrackModel());
    achievementsUnblockedModel1 =
        createModel(context, () => AchievementsUnblockedModel());
    achievementsUnblockedModel2 =
        createModel(context, () => AchievementsUnblockedModel());
    avhievementsBlockedModel1 =
        createModel(context, () => AvhievementsBlockedModel());
    avhievementsBlockedModel2 =
        createModel(context, () => AvhievementsBlockedModel());
    progressBarModel = createModel(context, () => ProgressBarModel());
  }

  @override
  void dispose() {
    achievementsTrackModel1.dispose();
    achievementsTrackModel2.dispose();
    achievementsTrackModel3.dispose();
    achievementsUnblockedModel1.dispose();
    achievementsUnblockedModel2.dispose();
    avhievementsBlockedModel1.dispose();
    avhievementsBlockedModel2.dispose();
    progressBarModel.dispose();
  }
}
