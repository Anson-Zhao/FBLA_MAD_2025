import 'dart:convert';
import 'dart:io';
import 'package:edu_venture/config.dart';
import 'package:edu_venture/flutter_flow/flutter_flow_theme.dart';
import 'package:edu_venture/flutter_flow/flutter_flow_util.dart';
import 'package:edu_venture/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'resultScreenModel.dart';
export 'resultScreenModel.dart';

class ResultScreen extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int quizId;
  final VoidCallback? onScreenLoaded;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.quizId,
    this.onScreenLoaded,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Resultscreenmodel _model;
  String? username;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    print("ResultScreen initState called"); // Add this line
    _model = createModel(context, () => Resultscreenmodel());
    _checkAndShowAchievement();
    _loadUsername();
    _submitQuiz();
  }

  //api call that submit the quiz is done if the result is more than 60 allow user to do next quiz 
  Future<void> _submitQuiz() async {
    String? token = await LocalStorage.token;

    try {
      var regBody = {
        "quiz_id": widget.quizId,
        "score": (widget.correctAnswers / widget.totalQuestions) * 100,
      };

      var response = await http.post(Uri.parse(submit_quiz),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(regBody));

      if (response.statusCode == 200) {
        print("quiz submitted");
      } else {
        print("didnot make api call");
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

  Future<void> _loadUsername() async {
    String? fetchedUsername = await LocalStorage.username;
    setState(() {
      username =
          fetchedUsername; // Set username or default to 'Guest'
    });
  }


  final time = DateTime.now()
      .toIso8601String()
      .replaceAll('.', '-')
      .replaceAll(':', '-');

  Future<void> saveAndShare(Uint8List bytes) async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final image = File('${directory!.path}/$time.png');
    image.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(image.path)]);
  }

  Future<void> saveImage(Uint8List bytes) async {
    final name = 'screenshot_$time';
    await Permission.storage.request();
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    debugPrint('result: $result');
  }

  Future<void> _checkAndShowAchievement() async {
    print(widget.quizId);
    if (widget.quizId == 1 || widget.quizId == 5) {
      _getAchievement();
    }
  }

  void _getAchievement() async {
    String? token = await LocalStorage.token;
    String achievementTypeId = widget.quizId == 5 ? "4" : "3";

    var regBody = {
      'achievementTypeId': achievementTypeId,
    };

    try {
      var response = await http.post(
        Uri.parse(new_achievement),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 201) {
        _showAchievementDialog();
        print('Got new achievement');
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showAchievementDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Use Dialog instead of AlertDialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Screenshot(
            controller: _screenshotController,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: MediaQuery.sizeOf(context).height * 0.45,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 4, 0),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 195,
                          height: 195,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Container(
                                width: widget.quizId == 1 ? 70.5 : 94.5,
                                height: widget.quizId == 1 ? 61.5 : 76.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(
                                      widget.quizId == 1
                                          ? 'assets/images/quiz_achievement_1.png'
                                          : 'assets/images/quiz_achievement_2.png',
                                    ).image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'You got a new achievement in your arsenal!',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            letterSpacing: 0.0,
                          ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await _screenshotController.capture().then(
                          (bytes) {
                            if (bytes != null) {
                              //saveImage(bytes);
                              saveAndShare(bytes);
                            }
                          },
                        ).catchError(
                          (onError) {
                            debugPrint(onError);
                          },
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 32,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Share',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Prompt',
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (widget.correctAnswers / widget.totalQuestions) * 100;
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/1767e1d7-e82e-4ae8-a07f-558795a0c97e_1.png',
            ).image,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 64, 0, 32),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 51,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          8,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 3, 0),
                                child: Container(
                                  width: 41,
                                  height: 41,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(70),
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
                                      fontSize: 16,
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
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/Vector_(3).png',
                                width: 18,
                                height: 18,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: Color(0x41FFFFFF),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Color(0x0D000000),
                                offset: Offset(
                                  0,
                                  8,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: Color(0x0F455A64),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 32, 20, 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Congrats!',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Prompt',
                                          fontSize: 32,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Text(
                                    'Total Completion: ${percentage.toStringAsFixed(1)}%',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Prompt',
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Generated code for this Container Widget...
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: Color(0x41FFFFFF),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Color(0x0D000000),
                                offset: Offset(
                                  0,
                                  8,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: Color(0x0F455A64),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'DoQuiz',
                                        queryParameters: {
                                          'quiz': serializeParam(
                                            widget.quizId.toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_back_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 34,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'Quiz',
                                        queryParameters: {
                                          'quiz_id': serializeParam(
                                            widget.quizId.toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 34,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('QuizOne');
                                    },
                                    child: Icon(
                                      Icons.menu_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    );
  }
}
