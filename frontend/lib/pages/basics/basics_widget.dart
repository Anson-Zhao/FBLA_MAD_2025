import 'package:edu_venture/local_storage.dart';

import '/components/back_button_widget.dart';
import '/components/subject_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'basics_model.dart';
export 'basics_model.dart';

class BasicsWidget extends StatefulWidget {
  const BasicsWidget({super.key});

  @override
  State<BasicsWidget> createState() => _BasicsWidgetState();
}

class _BasicsWidgetState extends State<BasicsWidget> {
  late BasicsModel _model;
  String? username;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BasicsModel());
    _loadUsername();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _loadUsername() async {
    String? fetchedUsername = await LocalStorage.username;
    setState(() {
      username =
          fetchedUsername ?? 'Guest'; // Set username or default to 'Guest'
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/1767e1d7-e82e-4ae8-a07f-558795a0c97e_1.png',
              ).image,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 64.0, 20.0, 32.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 51.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            8.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(70.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 3.0, 0.0),
                                  child: Container(
                                    width: 41.0,
                                    height: 41.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(70.0),
                                    ),
                                  ),
                                ),
                                Text(
                                  username ?? '',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Prompt',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('Settings');
                          },
                          child: Container(
                            width: 51.0,
                            height: 51.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(70.0),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Vector_(3).png',
                                  width: 18.0,
                                  height: 18.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 64.0),
                    child: Text(
                      'Self Study: Basics',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 32.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: Color(0x41FFFFFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Color(0x0D000000),
                            offset: Offset(
                              0.0,
                              8.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(17.0),
                        border: Border.all(
                          color: Color(0x0F455A64),
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            32.0, 64.0, 32.0, 64.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'TopicCards',
                                    queryParameters: {
                                      'topic': serializeParam(
                                        'Addition',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Addition combines numbers to get a total or sum. How it Works:  Example: 2 + 3 = 5. Combine two numbers by counting forward.  Quick Tip: Think of adding as putting things together.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Addition (+)',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'TopicCards',
                                    queryParameters: {
                                      'topic': serializeParam(
                                        'Subtrtion',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Subtraction finds theSubtraction finds the difference between numbers or takes one away from another. How it Works: Example: 5 - 2 = 3. Count backward to subtract.  Quick Tip: Subtracting is like taking things away. difference between numbers or takes one away from another. How it Works: Example: 5 - 2 = 3. Count backward to subtract.  Quick Tip: Subtracting is like taking things away.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Subtraction (-)',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'TopicCards',
                                    queryParameters: {
                                      'topic': serializeParam(
                                        'Multiplication',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Multiplication is repeated addition. How it Works: Example: 3 × 4 = 12. Add 3 four times: 3 + 3 + 3 + 3 = 12.  Quick Tip: Use rows and columns, like 3 rows of 4 apples each.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Multiplication (×)',
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  'TopicCards',
                                  queryParameters: {
                                    'topic': serializeParam(
                                      'Division',
                                      ParamType.String,
                                    ),
                                    'text': serializeParam(
                                      'Division splits numbers into equal parts. How it Works: Example: 12 ÷ 3 = 4. Split 12 into 3 equal groups of 4.  Quick Tip: Division is sharing equally.',
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: wrapWithModel(
                                model: _model.subjectButtonModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: SubjectButtonWidget(
                                  buttonLabel: 'Division (÷)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                wrapWithModel(
                  model: _model.backButtonModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BackButtonWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
