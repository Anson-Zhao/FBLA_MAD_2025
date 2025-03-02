import 'package:edu_venture/config.dart';
import 'package:edu_venture/flutter_flow/flutter_flow_theme.dart';
import 'package:edu_venture/flutter_flow/flutter_flow_util.dart';
import 'package:edu_venture/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashCardPage(),
    );
  }
}

class FlashCardPage extends StatefulWidget {
  const FlashCardPage({super.key});

  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  final List<Map<String, String>> _flashcards = [];

  @override
  void initState() {
    super.initState();
    _fetchFlashcards(); // Fetch flashcards when the page is initialized
  }

  

  Future<void> _addFlashCard(String topic, String description) async {
    final url = Uri.parse(add_flashcard);

    try {
      // 1. Get the userId and convert it to a String
      String userId = (await LocalStorage.userId)?.toString() ?? '';

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId, // Now a String
          'topic': topic,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        final newFlashcard = jsonDecode(response.body);
        setState(() {
          _flashcards.add({
            'id': newFlashcard['flashcard_id'].toString(),
            'topic': topic,
            'description': description,
          });
        });
      } else {
        print('Failed to add flashcard: ${response.body}');
      }
    } catch (e) {
      print('Error adding flashcard: $e');
    }
  }

  Future<void> _deleteFlashCard(int index) async {
    final flashcardId = _flashcards[index]['id']; // Use the ID from the list
    final url = Uri.parse(
        delete_flashcard + flashcardId!); // Replace with your backend URL

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        setState(() {
          _flashcards.removeAt(index);
        });
      } else {
        print('Failed to delete flashcard: ${response.body}');
      }
    } catch (e) {
      print('Error deleting flashcard: $e');
    }
  }

  Future<String> fetchUsername() async {
    String? username = await LocalStorage.username;
    return username; // Return 'Guest' if username is null
  }

  Future<void> _fetchFlashcards() async {
  try {
    String userId = (await LocalStorage.userId)?.toString() ?? '';
    final url = Uri.parse('$get_flashcard/$userId');


    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> flashcards = jsonDecode(response.body);
      setState(() {
        _flashcards.clear(); // Clear existing flashcards
        for (var flashcard in flashcards) {
          _flashcards.add({
            'id': flashcard['id'].toString(),
            'topic': flashcard['topic'],
            'description': flashcard['description'],
          });
        }
      });
    } else {
      print('Failed to fetch flashcards: ${response.body}');
      // Handle errors appropriately (e.g., show a Snackbar)
    }
  } catch (e) {
    print('Error fetching flashcards: $e');
    // Handle errors (e.g., show a Snackbar)
  }
}

  void _showAddFlashCardDialog() {
    final TextEditingController topicController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Add flashcards',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Prompt',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: topicController,
                    decoration: InputDecoration(
                      hintText: 'Topic',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Prompt',
                                color: Color(0x40263238),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x40263238),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9BA1FF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 14,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Prompt',
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Prompt',
                                color: Color(0x40263238),
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x40263238),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9BA1FF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 14,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Prompt',
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      final topic = topicController.text.trim();
                      final description = descriptionController.text.trim();
                      if (topic.isNotEmpty && description.isNotEmpty) {
                        _addFlashCard(topic, description);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 37,
                      decoration: BoxDecoration(
                        color: Color(0xFF9BA1FF),
                        borderRadius: BorderRadius.circular(70),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Add',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Prompt',
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Prompt',
                          color: Color(0xFF9BA1FF),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background_image.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 64, 20, 16),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 51,
                decoration: BoxDecoration(
                  color: const Color(0xFF263238), // Updated color
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 12,
                      color: Color(0x40000000), // Black with 25% opacity
                      offset: Offset(0, 8),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 3, 0),
                            child: Container(
                              width: 41,
                              height: 41,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BA1FF), // Purple color
                                borderRadius: BorderRadius.circular(70),
                              ),
                            ),
                          ),
                          FutureBuilder<String>(
                            future: fetchUsername(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'Loading...',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Prompt',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Prompt',
                                        color: Colors.red,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                );
                              } else {
                                return Text(
                                  snapshot.data ?? 'Guest',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Prompt',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                      ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('HomePage');
                      },
                      child: Container(
                        width: 51,
                        height: 51,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9BA1FF), // Purple color
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Theme.of(context).colorScheme.onSecondary,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Flashcards or empty message
            Expanded(
              child: _flashcards.isEmpty
                  ? const Center(
                      child: Text(
                        'No flashcards yet. Tap "+" to add one!',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _flashcards.length,
                      itemBuilder: (context, index) {
                        final flashcard = _flashcards[index];
                        return Dismissible(
                          key: Key(flashcard['topic']!),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => _deleteFlashCard(index),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: FlashCard(
                            topic: flashcard['topic']!,
                            description: flashcard['description']!,
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: AlignmentDirectional(1, 1),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 20),
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF263238),
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: InkWell(
                onTap: _showAddFlashCardDialog,
                child: Icon(
                  Icons.add_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 34,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlashCard extends StatefulWidget {
  final String topic;
  final String description;

  const FlashCard({Key? key, required this.topic, required this.description})
      : super(key: key);

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard>
    with SingleTickerProviderStateMixin {
  bool _showDescription = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  

  void _toggleCard() {
    if (_showDescription) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _showDescription = !_showDescription;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFront = _animation.value < 0.5;
          final rotationAngle = _animation.value * 3.14159; // Pi for 180°

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateX(rotationAngle), // Flip on X-axis
            alignment: Alignment.center,
            child: isFront
                ? _buildCard(widget.topic)
                : Transform(
                    transform: Matrix4.identity()..rotateX(3.14159),
                    alignment: Alignment.center,
                    child: _buildCard(widget.description),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String text) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(24.0), // Increased padding
        height: 200.0, // Increased height
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
