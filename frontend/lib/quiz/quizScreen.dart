import 'package:edu_venture/config.dart';
import 'package:edu_venture/flutter_flow/flutter_flow_util.dart';
import 'package:edu_venture/quiz/answerButton.dart';
import 'package:edu_venture/quiz/fetchQuestions.dart';
import 'package:edu_venture/quiz/progressBar.dart';
import 'package:edu_venture/quiz/resultScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  final String quiz_id;
  const QuizScreen({super.key, required this.quiz_id});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool isAnswerSelected = false;
  bool isNextButtonEnabled = false;
  int remainingTime = 30;
  Timer? timer;

  int? selectedAnswerIndex;
  List<Map<String, dynamic>> questions = []; // To hold the fetched questions
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final fetchedQuestions =
          await QuizService(quiz_id: widget.quiz_id).fetchQuestions();
      setState(() {
        questions = fetchedQuestions;
        isLoading = false; // Stop loading after fetching questions
        startTimer();
      });
    } catch (e) {
      // Handle errors (e.g., show a snackbar or error message)
      print('Error fetching questions: $e');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        goToNextQuestion();
      }
    });
  }

  void restartTimer() {
    timer?.cancel();
    setState(() {
      remainingTime = 30;
      isAnswerSelected = false;
      isNextButtonEnabled = false;
      selectedAnswerIndex = null;
    });
    startTimer();
  }

  void selectAnswer(int selectedIndex) {
    setState(() {
      isAnswerSelected = true;
      isNextButtonEnabled = true;
      selectedAnswerIndex = selectedIndex;
    });
  }

  void goToNextQuestion() {
    if (selectedAnswerIndex ==
        questions[currentQuestionIndex]['correctIndex']) {
      correctAnswers++;
    }

    // Check if questions is empty or null
    int totalQuestions =
        questions?.length ?? 0; // Use 0 if questions is null or empty

    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      restartTimer();
    } else {
      timer?.cancel();
      // Navigate using GoRouter and pass data with extra
      context.goNamed(
        'ResultPage', // The name of the route defined in GoRouter
        extra: {
          'correctAnswers': correctAnswers,
          'totalQuestions':
              totalQuestions, // Use the default value if questions is empty
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while fetching questions
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_image.png', // Replace with your actual image path
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          Column(
            children: [
              // Progress Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 64.0),
                child: CustomProgressBar(
                  progress: remainingTime / 30,
                  timerText: '00:${remainingTime.toString().padLeft(2, '0')}',
                ),
              ),

              // Display the question
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    constraints: const BoxConstraints(
                      minHeight: 50,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF263238),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Question tracking
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  'Question ',
                                  style: TextStyle(
                                    fontFamily: 'Prompt',
                                    color: Color(0x7FFFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '${currentQuestionIndex + 1}/${questions.length}',
                                  style: const TextStyle(
                                    fontFamily: 'Prompt',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Display the question text
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    question['question'],
                                    style: const TextStyle(
                                      fontFamily: 'Prompt',
                                      color: Colors.white,
                                      fontSize: 24,
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

              // Answer Buttons
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 32),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: const Color(0xFF263238),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < question['answers'].length; i++)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: AnswerButton(
                              answer: question['answers'][i],
                              isSelected: selectedAnswerIndex == i,
                              onTap: () {
                                selectAnswer(i);
                              },
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: isNextButtonEnabled ? goToNextQuestion : null,
                          child: Container(
                            width: 320,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: isNextButtonEnabled
                                  ? const Color(0xFF9BA1FF)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isNextButtonEnabled
                                    ? const Color(0xFF9BA1FF)
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Next Question',
                                style: TextStyle(
                                  fontFamily: 'Prompt',
                                  color: Colors.white,
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
            ],
          ),
        ],
      ),
    );
  }
}
