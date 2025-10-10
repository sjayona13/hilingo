import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'quizzes.dart';
import 'quiz_page.dart';

class Qhard extends StatefulWidget {
  const Qhard({Key? key}) : super(key: key);

  @override
  _QeasyState createState() => _QeasyState();
}

// ✅ Question model
class Question {
  final String type; // "phrase", "picture", "flashcard"
  final String phrase;
  final List<String> options;
  final String correct;
  final String? image;

  Question({
    required this.type,
    required this.phrase,
    required this.options,
    required this.correct,
    this.image,
  });
}

class _QeasyState extends State<Qhard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;

  late ConfettiController _confettiController;
  late List<Question> _questions;

  // 🔹 Timer controller
  late AnimationController _timerController;
  final Duration questionDuration = const Duration(seconds: 10);

  // ✅ Sample Questions
  final List<Question> _allQuestions = [
    // 🔹 Guess the Phrase
    Question(
      type: "phrase",
      phrase: "Hello",
      options: ["Kamusta", "Salamat", "Indi"],
      correct: "Kamusta",
    ),
    Question(
      type: "phrase",
      phrase: "Thank you",
      options: ["Palihog", "Salamat", "Kamusta"],
      correct: "Salamat",
    ),

    // 🔹 Picture Learning
    Question(
      type: "picture",
      phrase: "DOG",
      options: ["Ido", "Kuring", "Isda"],
      correct: "Ido",
      image: "assets/dog.png",
    ),
    Question(
      type: "picture",
      phrase: "BIRD",
      options: ["Langgam", "Isda", "Kuring"],
      correct: "Langgam",
      image: "assets/bird.png",
    ),

    // 🔹 Flashcards
    Question(
      type: "flashcard",
      phrase: "Water",
      options: ["Tubig", "Pagkaon", "Hangin"],
      correct: "Tubig",
    ),
    Question(
      type: "flashcard",
      phrase: "Food",
      options: ["Pagkaon", "Tubig", "Hangin"],
      correct: "Pagkaon",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));

    _timerController = AnimationController(
      vsync: this,
      duration: questionDuration,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_answered) {
          setState(() {
            _answered = true;
            _selectedIndex = null; // no answer selected
          });
          // ⏳ wait 1 second, then go to next question
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) _nextQuestion();
          });
        }
      })
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _loadNewSet();
    _startTimer();
  }

  void _startTimer() {
    _timerController.forward(from: 0);
  }

  void _loadNewSet() {
    setState(() {
      _questions = List.from(_allQuestions)..shuffle();
      _questions = _questions.take(10).toList();
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _selectedIndex = null;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
      _startTimer();
    } else {
      _showQuizCompletedDialog();
    }
  }

  void _showQuizCompletedDialog() {
    _confettiController.play();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, __) {
        return GestureDetector(
          onTap: () {
            _confettiController.stop();
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);
          },
          child: Material(
            color: Colors.black54,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Color(0xFF2A7BE6), Colors.lightBlue, Colors.cyan],
                  numberOfParticles: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Your Score: $_score / ${_questions.length}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A7BE6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF2A7BE6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 12),
            child: Text(
              '${_currentIndex + 1}/${_questions.length}',
              style: const TextStyle(
                color: Color(0xFF878282),
                fontFamily: 'Kumbh',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    question.type == "phrase"
                        ? "Choose the correct answer within 10 seconds"
                        : question.type == "picture"
                            ? "Choose the correct answer within 10 seconds"
                            : "Choose the correct answer within 10 seconds",
                    style: const TextStyle(
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF878282),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Picture Learning UI
                if (question.type == "picture")
                  Column(
                    children: [
                      if (question.image != null)
                        SizedBox(
                          width: 155,
                          height: 155,
                          child: Image.asset(question.image!, fit: BoxFit.contain),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        question.phrase,
                        style: const TextStyle(
                          fontFamily: 'Kumbh',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF878282),
                        ),
                      ),
                    ],
                  )
                else
                  // 🔹 Guess & Flashcards UI
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 155,
                        height: 188,
                        child: Image.asset('assets/boy.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 153,
                        height: 115,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF878282)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          question.phrase,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Kumbh',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFF878282),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),

                // 🔹 Answer Options
                ...List.generate(question.options.length, (index) {
                  final option = question.options[index];
                  Color borderColor = const Color(0xFF878282);
                  Color textColor = const Color(0xFF878282);

                  if (_answered) {
                    if (option == question.correct) {
                      borderColor = Colors.green;
                      textColor = Colors.green;
                    } else if (_selectedIndex == index) {
                      borderColor = Colors.red;
                      textColor = Colors.red;
                    }
                  }

                  return Container(
                    width: 258,
                    height: 46,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: OutlinedButton(
                      onPressed: _answered
                          ? null
                          : () {
                              setState(() {
                                _selectedIndex = index;
                                _answered = true;
                                if (option == question.correct) _score++;
                                _timerController.stop();
                              });
                            },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'Kumbh',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),

                // 🔹 Blue Timer Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: _timerController.value,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        const AlwaysStoppedAnimation(Color(0xFF2A7BE6)),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Continue Button
          Positioned(
            left: 66,
            bottom: 40,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 132,
              height: 50,
              child: ElevatedButton(
                onPressed: _answered ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A7BE6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Kumbh',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
