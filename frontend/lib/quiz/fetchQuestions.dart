import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  final String quiz_id;
  // final String baseUrl = 'http://localhost:3000';
  final String baseUrl = 'http://mad2025.northernhorizon.org:9094';
  // final String baseUrl = Platform.isAndroid ? "http://10.0.2.2:3000" : "http://10.11.20.195:3000";

  QuizService({required this.quiz_id}); // Replace with your actual API URL

  //fetch questions from api
  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/quiz/questions/$quiz_id'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) {
          return {
            'question': item['question'],
            'answers': item['answers']
                .map<String>((answer) => answer['text'].toString())
                .toList(),
            'correctIndex': item['answers']
                .indexWhere((answer) => answer['isCorrect'] == 1),
          };
        }).toList();
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
                                         