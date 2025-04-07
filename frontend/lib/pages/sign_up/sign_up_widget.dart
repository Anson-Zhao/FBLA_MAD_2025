import 'package:edu_venture/local_storage.dart';

import '/components/button_widget.dart';
import '/components/text_input_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'sign_up_model.dart';
import 'package:http/http.dart' as http;
import 'package:edu_venture/config.dart';
export 'sign_up_model.dart';
import 'package:twitter_login/twitter_login.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late SignUpModel _model;
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  //validate email format 
  bool _isEmailValidFormat(String email) {
    // Regular expression for validating email format
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  //validate inputs 
  bool _areAllFieldsValid() {
    final username = _model.textInputModel1.textController.text;
    final email = _model.textInputModel2.textController.text;
    final password = _model.textController1?.text ?? '';
    final confirmPassword = _model.textController2?.text ?? '';

    final isUsernameValid = username.isNotEmpty;
    final isEmailValid = email.isNotEmpty && _isEmailValidFormat(email);
    final isPasswordValid = password.isNotEmpty;
    final isConfirmPasswordValid = confirmPassword.isNotEmpty;
    final doPasswordsMatch = password == confirmPassword;

    // Update validators to reflect errors and update border states
    setState(() {
      _model.textInputModel1.textControllerValidator =
          (context, value) => isUsernameValid ? null : 'Username is required';

      _model.textInputModel2.textControllerValidator = (context, value) {
        if (email.isEmpty) return 'Email is required';
        if (!_isEmailValidFormat(email)) return 'Invalid email format';
        return null;
      };

      _model.textController1Validator =
          (context, value) => isPasswordValid ? null : 'Password is required';

      _model.textController2Validator = (context, value) {
        if (!isConfirmPasswordValid) {
          return 'Confirm password is required';
        } else if (!doPasswordsMatch) {
          return 'Passwords do not match';
        }
        return null;
      };
    });

    return isUsernameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        doPasswordsMatch;
  }

  //Api call that register the user 
  void registerUser() async {
    if (_areAllFieldsValid()) {
      String username = _model.textInputModel1.textController.text;
      String email = _model.textInputModel2.textController.text;
      String password = _model.textController1?.text ?? '';

      print(username);
      print(email);
      print(password);

      var regBody = {
        "username": username,
        "email": email,
        "password": password,
      };

      try {
        var response = await http.post(
          Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 201) {
          // Parse the response body
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
              content: Text('Log in failed: ${response.body}'),
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
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 160.0, 0.0, 0.0),
                    child: Text(
                      'Let\'s get you started!',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Text(
                      'Write down your credentials and\nyour learning can begin!',
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
                      model: _model.textInputModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: TextInputWidget(
                        hint: 'Username',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 18.0),
                    child: wrapWithModel(
                      model: _model.textInputModel2,
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
                        controller: _model.textController1,
                        focusNode: _model.textFieldFocusNode1,
                        autofocus: false,
                        obscureText: !_model.passwordVisibility1,
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
                              () => _model.passwordVisibility1 =
                                  !_model.passwordVisibility1,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              _model.passwordVisibility1
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
                          } else if (_model.textController1?.text !=
                              _model.textController2?.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(54.0, 0.0, 54.0, 32.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      child: TextFormField(
                        controller: _model.textController2,
                        focusNode: _model.textFieldFocusNode2,
                        autofocus: false,
                        obscureText: !_model.passwordVisibility2,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Prompt',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Confirm password',
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
                              () => _model.passwordVisibility2 =
                                  !_model.passwordVisibility2,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              _model.passwordVisibility2
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
                            return 'Confirm password is required';
                          }else if (_model.textController1?.text !=
                              _model.textController2?.text) {
                            return 'Confirm password does not match';
                          }
                          return null;
                        },
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
                          registerUser();
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
                          buttonLabel: 'Sign up',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: Text(
                      'or Sign up with ',
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
                          'Already have an account?',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                            context.pushNamed('SignIn');
                          },
                          child: Text(
                            ' Sign in!',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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

class TwitterAuthService {
  final twitterLogin = TwitterLogin(
    apiKey: 'o96RagBx7zvnUJ03wtOc7it6j',
    apiSecretKey: 'jwTtpU1qpdsA9THEHSTDHZfernjC11ueRebyl4gm8VJ0EjIonh',
    redirectURI: 'YOUR_REDIRECT_URI',
  );

  Future<void> login(BuildContext context) async {
    final authResult = await twitterLogin.login();

    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final user = authResult.user;

      // Send user data to your backend
      final response = await http.post(
        Uri.parse('https://yourbackend.com/api/twitter-login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "twitter_id": user!.id,
          "username": user.screenName,
          "email": user.email, // Twitter might not provide this
        }),
      );


      if (response.statusCode == 200) {
        print('User data saved to MySQL');
      } else {
        print('Error saving user data');
      }
    } else {
      print('Twitter login failed');
    }
  }
}
