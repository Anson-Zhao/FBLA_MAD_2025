import '/components/setting_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SettingButton component.
  late SettingButtonModel settingButtonModel1;
  // Model for SettingButton component.
  late SettingButtonModel settingButtonModel2;
  // Model for SettingButton component.
  late SettingButtonModel settingButtonModel3;
  // Model for SettingButton component.
  late SettingButtonModel settingButtonModel4;

  @override
  void initState(BuildContext context) {
    settingButtonModel1 = createModel(context, () => SettingButtonModel());
    settingButtonModel2 = createModel(context, () => SettingButtonModel());
    settingButtonModel3 = createModel(context, () => SettingButtonModel());
    settingButtonModel4 = createModel(context, () => SettingButtonModel());
  }

  @override
  void dispose() {
    settingButtonModel1.dispose();
    settingButtonModel2.dispose();
    settingButtonModel3.dispose();
    settingButtonModel4.dispose();
  }
}
