import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  final String baseUrl = 'http://10.0.2.2:3306'; // Replace with your actual API URL

  Future<List<Map<String, dynamic>>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/questions'));

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
