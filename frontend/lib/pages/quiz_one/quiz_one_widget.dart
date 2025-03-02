import 'package:edu_venture/local_storage.dart';

import '/components/blocked_game_button_widget.dart';
import '/components/game_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'quiz_one_model.dart';
export 'quiz_one_model.dart';
import 'package:http/http.dart' as http;
import 'package:edu_venture/config.dart';

class QuizOneWidget extends StatefulWidget {
  const QuizOneWidget({super.key});

  @override
  State<QuizOneWidget> createState() => _QuizOneWidgetState();
}

class _QuizOneWidgetState extends State<QuizOneWidget> {
  late QuizOneModel _model;
  String? username;
  int quiz = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadQuizzesAllowed();
    super.initState();
    _model = createModel(context, () => QuizOneModel());
    _loadUsername();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  //Load username 
  Future<void> _loadUsername() async {
    String? fetchedUsername = await LocalStorage.username;
    setState(() {
      username =
          fetchedUsername; // Set username or default to 'Guest'
    });
  }


  //load and check quiz allowed 
  Future<void> _loadQuizzesAllowed() async {
    String? token = await LocalStorage.token;

    try {
      var response = await http.get(
        Uri.parse(quizzes_allowed),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Check if the widget is still mounted BEFORE updating state
      if (mounted) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          setState(() {
            quiz = data['current_level']; // No need for int.parse()
          });
        } else {
          // Fallback to level 1 if the API call fails
          setState(() {
            quiz = 1;
          });
        }
      }
    } catch (e) {
      // Handle exception - but only if the widget is still mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
          ),
        );
      }
    }
  }
  
  //Show dialog if user is not allowed to do this quiz 
  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          // Use Dialog instead of AlertDialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.695,
            height: MediaQuery.sizeOf(context).height * 0.216,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 2,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Oops! Please finish previous quiz!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Prompt',
                              fontSize: 24,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        'Your previous quiz score has to be more than 60!',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Prompt',
                              color: Color(0x97000000),
                              fontSize: 12,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        width: 100,
                        height: 32,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'ok',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Prompt',
                                  color:
                                      Colors.white, // Set text color to white
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 64.0, 0.0, 32.0),
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
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 64.0),
                          child: Text(
                            'Quiz 1',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Prompt',
                                  fontSize: 32.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 32.0),
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
                                  20.0, 32.0, 20.0, 32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (quiz >= 1) {
                                          context.pushNamed(
                                            'DoQuiz',
                                            queryParameters: {
                                              'quiz': serializeParam(
                                                '1',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          _showDialog();
                                        }
                                      },
                                      child: wrapWithModel(
                                        model: _model.gameButtonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: quiz >= 1
                                            ? GameButtonWidget(
                                                text: 'Quiz lvl. 1',
                                              )
                                            : BlockedGameButtonWidget(
                                                text: 'Quiz lvl. 1',
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (quiz >= 2) {
                                          context.pushNamed(
                                            'DoQuiz',
                                            queryParameters: {
                                              'quiz': serializeParam(
                                                '2',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          _showDialog();
                                        }
                                      },
                                      child: wrapWithModel(
                                        model: _model.gameButtonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: quiz >= 2
                                            ? GameButtonWidget(
                                                text: 'Quiz lvl. 2',
                                              )
                                            : BlockedGameButtonWidget(
                                                text: 'Quiz lvl. 2',
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (quiz >= 3) {
                                          context.pushNamed(
                                            'DoQuiz',
                                            queryParameters: {
                                              'quiz': serializeParam(
                                                '3',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          _showDialog();
                                        }
                                      },
                                      child: wrapWithModel(
                                        model: _model.gameButtonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: quiz >= 3
                                            ? GameButtonWidget(
                                                text: 'Quiz lvl. 3',
                                              )
                                            : BlockedGameButtonWidget(
                                                text: 'Quiz lvl. 3',
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        if (quiz >= 4) {
                                          context.pushNamed(
                                            'DoQuiz',
                                            queryParameters: {
                                              'quiz': serializeParam(
                                                '4',
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        } else {
                                          _showDialog();
                                        }
                                      },
                                      child: wrapWithModel(
                                        model: _model.gameButtonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: quiz >= 4
                                            ? GameButtonWidget(
                                                text: 'Quiz lvl. 4',
                                              )
                                            : BlockedGameButtonWidget(
                                                text: 'Quiz lvl. 4',
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
                                      if (quiz >= 5) {
                                        context.pushNamed(
                                          'DoQuiz',
                                          queryParameters: {
                                            'quiz': serializeParam(
                                              '5',
                                              ParamType.String,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        _showDialog();
                                      }
                                    },
                                    child: wrapWithModel(
                                      model: _model.gameButtonModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: quiz >= 5
                                          ? GameButtonWidget(
                                              text: 'Quiz lvl. 5',
                                            )
                                          : BlockedGameButtonWidget(
                                              text: 'Quiz lvl. 5',
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('HomePage');
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            size: 34.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
