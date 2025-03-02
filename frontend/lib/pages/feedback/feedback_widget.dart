import 'package:edu_venture/local_storage.dart';

import '/components/back_button_widget.dart';
import '/components/stroke_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'feedback_model.dart';
export 'feedback_model.dart';
import 'package:http/http.dart' as http;
import 'package:edu_venture/config.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  int selectedIndex = -1;
  late FeedbackModel _model;
  String? username;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedbackModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _loadUsername();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  //load username 
  Future<void> _loadUsername() async {
    String? fetchedUsername = await LocalStorage.username;
    setState(() {
      username =
          fetchedUsername; // Set username or default to 'Guest'
    });
  }

  //Check if all required fields are not empty 
  bool _areAllFieldsValid() {
    final isFeedbackValid = _model.textController.text.isNotEmpty;

    // Update validators to reflect errors
    setState(() {
      _model.textControllerValidator = (context, value) =>
          isFeedbackValid ? null : 'Feedback cannot be empty';
      _model.textControllerValidator = (context, value) {
        return null;
      };
    });

    return isFeedbackValid;
  }


  //Send feedback to us 
  void sendFeedback() async {
    if (_areAllFieldsValid()) {
      String user_feedback = _model.textController.text;
      String username = await LocalStorage.username;

      print(username);

      var regBody = {"username": username, "feedback": user_feedback, "index": selectedIndex};

      try {
        var response = await http.post(
          Uri.parse(feedback),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        print('Response status code: ${response.statusCode}');
        print(
            'Response body: ${response.body}'); // Debugging: Print raw response

        if (response.statusCode == 200) {
          // Ensure this is valid JSON
          print('Feedback sent successfully');
          _showThankYouDialog(); // Show the dialog after successful feedback
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sending failed: ${response.body}'),
            ),
          );
          print(response.body);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
          ),
        );
        print(e);
      }
    } else if (selectedIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please fill out all fields correctly.'),
        ),
      );
    } else  {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please fill out all fields correctly and choose the emoji.'),
        ),
      );
    } 
  }

  // Function to show the thank you dialog
  Future<void> _showThankYouDialog() async {
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
                        'Thank you for your feedback!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Prompt',
                              fontSize: 24,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        'Your feedback was sent successfully ',
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
                        context.pushNamed('Settings'); // Close the dialog
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 64.0, 20.0, 18.0),
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 64.0),
                        child: wrapWithModel(
                          model: _model.backButtonModel,
                          updateCallback: () => safeSetState(() {}),
                          child: BackButtonWidget(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 64.0),
                        child: Text(
                          'Here, you can write us a feedback, it can be about anythingmaybe you found a glitch? maybe a game breaking bug?\nMake sure to tell me your issues and wwill do our best to assist your. or if you just want to tell us how you feel about\nour app, then do so! We’d love to read them! Thank you!',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Prompt',
                                    color: Color(0x80263238),
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 32.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Very Bad
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0; // Set selected index
                                });
                              },
                              child: Container(
                                width: 37.0,
                                height: 37.0,
                                child: Image.asset(
                                  'assets/images/very_bad.png',
                                  color: selectedIndex == 0
                                      ? const Color(0xFF9BA1FF)
                                      : null, // Change color if selected
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0), // Spacing between containers
                    
                            // Bad
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1; // Set selected index
                                });
                              },
                              child: Container(
                                width: 37.0,
                                height: 37.0,
                                child: Image.asset(
                                  'assets/images/bad.png',
                                  color: selectedIndex == 1
                                      ? const Color(0xFF9BA1FF)
                                      : null, // Change color if selected
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                    
                            // Good
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 2; // Set selected index
                                });
                              },
                              child: Container(
                                width: 37.0,
                                height: 37.0,
                                child: Image.asset(
                                  'assets/images/good.png',
                                  color: selectedIndex == 2
                                      ? const Color(0xFF9BA1FF)
                                      : null, // Change color if selected
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                    
                            // Very Good
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 3; // Set selected index
                                });
                              },
                              child: Container(
                                width: 37.0,
                                height: 37.0,
                                child: Image.asset(
                                  'assets/images/very_good.png',
                                  color: selectedIndex == 3
                                      ? const Color(0xFF9BA1FF)
                                      : null, // Change color if selected
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 32.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 239.0,
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
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Prompt',
                                    color: Color(0x7C263238),
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Your feedback...',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Prompt',
                                    color: Color(0x80263238),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Prompt',
                                      letterSpacing: 0.0,
                                    ),
                            maxLines: 10,
                            minLines: 6,
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            60.0, 0.0, 60.0, 18.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            sendFeedback();
                          },
                          child: wrapWithModel(
                            model: _model.strokeButtonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: StrokeButtonWidget(
                              buttonLabel: 'Send Feedback',
                            ),
                          ),
                        ),
                      ),
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