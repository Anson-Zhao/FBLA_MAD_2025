import 'package:edu_venture/local_storage.dart';

import '/components/button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:edu_venture/config.dart';
import 'sign_in_model.dart';
export 'sign_in_model.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late SignInModel _model;
  final _formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  //validate inputs 
  bool _areAllFieldsValid() {
    final isEmailValid =
        _model.textInputModel.textController.text.isNotEmpty;
    final isPasswordValid = _model.textController?.text.isNotEmpty ?? false;

    setState(() {
      _model.textInputModel.textControllerValidator =
          (context, value) => isEmailValid ? null : 'Email is required';
      _model.textControllerValidator =
          (context, value) => isPasswordValid ? null : 'Password is required';
    });

    return isPasswordValid && isEmailValid;
  }

  //Call api the will login the user
  void loginUser() async {
    if (_areAllFieldsValid()) {
      String email = _model.textInputModel.textController.text;
      String password = _model.textController?.text ?? ''; // Corrected

      print(email);
      print(password);

      var regBody = {
        "email": email,
        "password": password,
      };

      try {
        var response = await http.post(
          Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          // Successfully registered
          var data = jsonDecode(response.body);

          // Extract the required fields
          String token = data['token'];
          int userId = data['user']['id'];
          String username = data['user']['username'];
          String email = data['user']['email'];

          // Save the data to local storage
          await LocalStorage.saveUserData(token, userId, username, email);

          print('User data saved successfully!');
          context.pushNamed('HomePage');
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(response.body),
            ),
          );
          print(response.body);
        }
      } catch (e) {
        // Handle exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please fill out all fields correctly.'),
        ),
      );
    }
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 200.0, 0.0, 0.0),
                    child: Text(
                      'Welcome back',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Text(
                      'Let\'s continue where we left off',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            color: Color(0x7F000000),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 18.0),
                    child: wrapWithModel(
                      model: _model.textInputModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TextInputWidget(
                        hint: 'Email',
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 18.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: !_model.passwordVisibility,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Prompt',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Password',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Prompt',
                                    color: Color(0x80263238),
                                    letterSpacing: 0.0,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x40263238),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 14.0, 14.0, 14.0),
                          suffixIcon: InkWell(
                            onTap: () => safeSetState(
                              () => _model.passwordVisibility =
                                  !_model.passwordVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              _model.passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20.0,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Prompt',
                              letterSpacing: 0.0,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 54.0, 18.0),
                      child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('ForgotPassword');
                            },
                        child: Text(
                          'Forgot password',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Prompt',
                                color: Color(0x80000000),
                                letterSpacing: 0.0,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 32.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            loginUser();
                        } else {
                          // Optionally show a message or highlight the missing fields
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content:
                                  Text('Please fill out all fields correctly.'),
                            ),
                          );
                        }
                            },
                      child: wrapWithModel(
                        model: _model.buttonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          buttonLabel: 'Sign in',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Text(
                      'or Sign in with ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            color: Color(0x41263238),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 32.0),
                      child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final twitterLogin = TwitterLogin(
                          apiKey: 'STM9WZuhScDCBX1uaQxFruSuK',
                          apiSecretKey: 'mE6YPFUc4ujdZZfSs8pVwM4uoUunUMnqX913L0CitqcxQ5iR36',
                          redirectURI: 'yourapp://callback',
                        );

                        final authResult = await twitterLogin.login();
                        final user = authResult.user;

                        switch (authResult.status) {
                          case TwitterLoginStatus.loggedIn:



                            print('Login successful!');
                            print('Username: ${user?.screenName}');
                            print('User ID: ${user?.id}');

                            final response = await http.post(
                              Uri.parse(twitter_login),
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "twitter_id": user!.id,
                                "username": user.screenName,
                              }),
                            );

                            if (response.statusCode == 200) {
                              var data = jsonDecode(response.body);
                              if (data.containsKey('token')) {
                                String token = data['token'];
                                int userId = data['user']['id'];
                                String username = data['user']['username'];
                                String email = "twitter";

                                // Save user data
                                await LocalStorage.saveUserData(token, userId, username, email);

                                print('User data saved successfully!');
                                context.pushNamed('HomePage');
                              } else {
                                print('Error: Invalid response format');
                              }
                            } else {
                              print('Login failed with status: ${response.statusCode}');
                            }

                            break;

                          case TwitterLoginStatus.cancelledByUser:
                            print('Login cancelled by user.');
                            break;

                          case TwitterLoginStatus.error:
                            print('Error logging in: ${authResult.errorMessage}');
                            break;

                          default:
                            print('Unexpected status');
                        }
                      },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 37.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 2.0,
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 20.58,
                              height: 21.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/twitter_logo.png',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Prompt',
                                color: Color(0x41263238),
                                letterSpacing: 0.0,
                              ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('SignUp');
                          },
                          child: Text(
                            ' Sign up!',
                            style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Prompt',
                                      color: FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
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
      ),
    );
  }
}
