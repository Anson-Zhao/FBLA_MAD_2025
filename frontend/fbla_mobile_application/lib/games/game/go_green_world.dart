import 'dart:async';
import 'dart:math';


import 'package:edu_venture/games/background_elements/background.dart';
import 'package:edu_venture/games/background_elements/finish.dart';
import 'package:edu_venture/games/background_elements/road.dart';
import 'package:edu_venture/games/cars/ai_car.dart';
import 'package:edu_venture/games/cars/car.dart';
import 'package:edu_venture/games/game/go_green_game.dart';
import 'package:edu_venture/games/ui/progress_bar.dart';
import 'package:edu_venture/games/ui/questions.dart';
import 'package:flame/components.dart';



class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  final Random _random = Random();
  final List<int> numbers; //[Random().nextInt(10), Random().nextInt(10)]
  final String action;

  Car? playerCar;
  AiCar? aiCar;
  Finish? finish;
  Background? background;
  Road? road;
  late ProgressBar progressBar;

  bool correctness = false;
  bool newQuestion = false;
  bool isPaused = false;

  GoGreenWorld(this.numbers, this.action);

  List<int> generateUniqueAnswers(
      int correctAnswer, int numAnswers, int min, int max) {
    final Set<int> answers = {correctAnswer};

    while (answers.length < numAnswers) {
      final int randomNum = min + _random.nextInt(max - min);
      answers.add(randomNum);
    }

    return answers.toList();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _initializeCars();
    _generateAndShuffleAnswers();
    _initializeBackgroundElements();

    final Sprite playerIcon = await Sprite.load('player_car_progress_bar.png');
    final Sprite aiIcon = await Sprite.load('ai_car_progress_bar.png');
    final Sprite finishIcon = await Sprite.load('racing-flag.png');

    // Initialize the progress bar after sprites are loaded
    progressBar = ProgressBar(
      barHeight: 60,
      playerProgress: 0.0,
      aiProgress: 0.0,
      playerIcon: playerIcon,
      aiIcon: aiIcon,
      finishIcon: finishIcon,
    );

    add(background!);
    add(road!);
    add(finish!);
    if (playerCar != null) add(playerCar!);
    if (aiCar != null) add(aiCar!);
    add(Question(numbers: numbers, action: action));
    add(progressBar);
  }

  void _initializeCars() {
    playerCar = Car(115, "player_car.png", 700);
    aiCar = AiCar(-120, "ai_car.png", 700);
  }

  void _generateAndShuffleAnswers() {
  final int correctAnswer;

  if (action == '+') {
    correctAnswer = numbers[0] + numbers[1];
  } else if (action == '*') {
    correctAnswer = numbers[0] * numbers[1];
  } else if (action == '/') {
    // Generate valid numbers for division
    numbers[1] = _random.nextInt(9) + 1; // numbers[1] is between 1 and 9 (non-zero)

    // Ensure numbers[0] is divisible by numbers[1]
    int multiplier = _random.nextInt(10) + 1; // Random multiplier (between 1 and 10)
    numbers[0] = numbers[1] * multiplier; // numbers[0] is guaranteed to be a multiple of numbers[1]

    // Correct answer: integer division
    correctAnswer = numbers[0] ~/ numbers[1]; // Use integer division to ensure an integer result
  } else { // Default to subtraction case
    correctAnswer = numbers[0] - numbers[1];
  }

  // Generate a list of unique answers
  final List<int> allAnswers = generateUniqueAnswers(correctAnswer, 4, 0, 20);
  allAnswers.shuffle(_random);
}




  void _initializeBackgroundElements() {
    finish = Finish()
      ..playerCar = playerCar
      ..aiCar = aiCar;

    background = Background();
    road = Road();
  }

  void setAnswerCorrect(bool isCorrect) {
    print('setAnswerCorrect called with: $isCorrect');
    if (isCorrect) {
      print('Triggering car position update');
      playerCar?.triggerPositionUpdate();
    }
  }

  void setNewQuestion(bool isCorrect) {
    if (isCorrect) {
      newQuestion = true;
      _updateNumbersForNewQuestion();
    }
  }

  void _updateNumbersForNewQuestion() {
    numbers[0] = _random.nextInt(10);
    numbers[1] = _random.nextInt(10);
  }

  void stopAllMovement() {
    if (isPaused) return;

    isPaused = true;
    background?.stopBackground();
    road?.stopRoad();

    print("Game has ended, all movement stopped.");
  }

  @override
  void update(double dt) {
    progressBar.playerProgress = playerCar!.calculateRoadPercentage();
    progressBar.aiProgress = aiCar!.calculateRoadPercentage();

    if (isPaused) return;
    super.update(dt);

    if (newQuestion) {
      print("New Question just set");
      newQuestion = false;
    }
  }
}
