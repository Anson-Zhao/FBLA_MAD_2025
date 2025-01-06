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
import 'algebra_model.dart';
export 'algebra_model.dart';

class AlgebraWidget extends StatefulWidget {
  const AlgebraWidget({super.key});

  @override
  State<AlgebraWidget> createState() => _AlgebraWidgetState();
}

class _AlgebraWidgetState extends State<AlgebraWidget> {
  late AlgebraModel _model;
  String? username;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlgebraModel());
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
                      'Self Study: Algebra',
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
                                        'Variables and Expressions',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Variables are placeholders for unknown numbers, often represented by x or y. How it Works: Example: x + 5 = 10. Solve by subtracting 5: x = 5.  Quick Tip: Think of variables as mystery numbers to uncover.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Variables and Expressions',
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
                                        ' Solving Linear Equations',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Linear equations have one or more variables with no exponents. How it Works: Example: Solve 2x + 3 = 7. Subtract 3 from both sides: 2x = 4. Divide both sides by 2: x = 2.  Quick Tip: Always simplify step by step.Linear equations have one or more variables with no exponents. How it Works: Example: Solve 2x + 3 = 7. Subtract 3 from both sides: 2x = 4. Divide both sides by 2: x = 2.  Quick Tip: Always simplify step by step.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Solving Linear Equations',
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
                                        'Simplifying Expressions',
                                        ParamType.String,
                                      ),
                                      'text': serializeParam(
                                        'Combine like terms to simplify expressions. How it Works: Example: Simplify 3x + 2x - 4: Combine 3x and 2x: 5x - 4.  Quick Tip: Add or subtract terms with the same variable.',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: wrapWithModel(
                                  model: _model.subjectButtonModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SubjectButtonWidget(
                                    buttonLabel: 'Simplifying Expressions',
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
                                      'Graphing Equations',
                                      ParamType.String,
                                    ),
                                    'text': serializeParam(
                                      'Plot points on a graph to visualize equations. How it Works: Example: y = 2x + 1: Plug in values for x (e.g., 0, 1, 2). Find corresponding y values: (0,1), (1,3), (2,5). Draw the line connecting the points.  Quick Tip: Graphs make equations easier to understand.',
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: wrapWithModel(
                                model: _model.subjectButtonModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: SubjectButtonWidget(
                                  buttonLabel: 'Graphing Equations',
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
