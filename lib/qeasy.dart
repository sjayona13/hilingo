import 'dart:math';
import 'package:flutter/material.dart';
import 'qscore.dart';

import 'result_feature.dart';

class Qeasy extends StatefulWidget {
  const Qeasy({Key? key}) : super(key: key);

  @override
  _QeasyState createState() => _QeasyState();
}

class Question {
  final String type;
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

  List<String> shuffledOptions() {
    List<String> shuffled = List.from(options);
    shuffled.shuffle(Random());
    return shuffled;
  }
}

class _QeasyState extends State<Qeasy> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late List<Question> _questions;
  late AnimationController _timerController;
  final Duration questionDuration = const Duration(seconds: 10);

  late List<String> _shuffledOptions;

  final List<Question> _allQuestions = [
    Question(
        type: "phrase",
        phrase: "Good morning",
        options: ["Maayong aga", "Maayong hapon", "Maayong gab-i"],
        correct: "Maayong aga"),
    Question(
        type: "phrase",
        phrase: "How are you?",
        options: ["Kamusta ka?", "Salamat", "Palihog"],
        correct: "Kamusta ka?"),
    Question(
        type: "phrase",
        phrase: "Thank you",
        options: ["Salamat", "Indi", "Palihog"],
        correct: "Salamat"),
    Question(
        type: "phrase",
        phrase: "Please",
        options: ["Palihog", "Salamat", "Kamusta"],
        correct: "Palihog"),
    Question(
        type: "phrase",
        phrase: "Sorry",
        options: ["Pasensya", "Salamat", "Indi"],
        correct: "Pasensya"),
    Question(
        type: "phrase",
        phrase: "Yes",
        options: ["Oo", "Indi", "Sigurado"],
        correct: "Oo"),
    Question(
        type: "phrase",
        phrase: "No",
        options: ["Indi", "Oo", "Palihog"],
        correct: "Indi"),
    Question(
        type: "flashcard",
        phrase: "Water",
        options: ["Tubig", "Hangin", "Pagkaon"],
        correct: "Tubig"),
    Question(
        type: "flashcard",
        phrase: "Food",
        options: ["Pagkaon", "Tubig", "Hangin"],
        correct: "Pagkaon"),
    Question(
        type: "flashcard",
        phrase: "Air",
        options: ["Hangin", "Tubig", "Kalayo"],
        correct: "Hangin"),
    Question(
        type: "flashcard",
        phrase: "Fire",
        options: ["Kalayo", "Tubig", "Hangin"],
        correct: "Kalayo"),
    Question(
        type: "flashcard",
        phrase: "House",
        options: ["Balay", "Dalan", "Kalan"],
        correct: "Balay"),
    Question(
        type: "flashcard",
        phrase: "Road",
        options: ["Dalan", "Balay", "Kalsada"],
        correct: "Dalan"),
    Question(
        type: "flashcard",
        phrase: "School",
        options: ["Eskwelahan", "Balay", "Tindahan"],
        correct: "Eskwelahan"),
    Question(
        type: "picture",
        phrase: "Dog",
        options: ["Ido", "Kuring", "Isda"],
        correct: "Ido",
        image: "assets/dog.png"),
    Question(
        type: "picture",
        phrase: "Cat",
        options: ["Kuring", "Ido", "Isda"],
        correct: "Kuring",
        image: "assets/cat.png"),
    Question(
        type: "picture",
        phrase: "Bird",
        options: ["Pispis", "Isda", "Kuring"],
        correct: "Pispis",
        image: "assets/bird.png"),
    Question(
        type: "picture",
        phrase: "Fish",
        options: ["Isda", "Kuring", "Ido"],
        correct: "Isda",
        image: "assets/fish.png"),
    Question(
        type: "picture",
        phrase: "Apple",
        options: ["Mansanas", "Saging", "Mangga"],
        correct: "Mansanas",
        image: "assets/apple.png"),
    Question(
        type: "picture",
        phrase: "Banana",
        options: ["Saging", "Mansanas", "Mangga"],
        correct: "Saging",
        image: "assets/banana.png"),
    Question(
        type: "picture",
        phrase: "Mango",
        options: ["Paho", "Saging", "Mansanas"],
        correct: "Paho",
        image: "assets/mango.png"),
    Question(
        type: "picture",
        phrase: "Car",
        options: ["Salakyan", "Barko", "Bus"],
        correct: "Salakyan",
        image: "assets/car.png"),
    Question(
        type: "picture",
        phrase: "Boat",
        options: ["Barko", "Sakyanan", "Bus"],
        correct: "Barko",
        image: "assets/boat.png"),
  ];

  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(
      vsync: this,
      duration: questionDuration,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_answered) {
          setState(() {
            _answered = true;
            _selectedIndex = null;
          });
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

  void _startTimer() => _timerController.forward(from: 0);

  void _loadNewSet() {
    _questions = List.from(_allQuestions)..shuffle();
    _questions = _questions.take(10).toList();
    _currentIndex = 0;
    _score = 0;
    _answered = false;
    _selectedIndex = null;
    _results = []; // Reset results
    _shuffledOptions = _questions[_currentIndex].shuffledOptions();
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
        _shuffledOptions = _questions[_currentIndex].shuffledOptions();
      });
      _startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Qscore(
              score: _score, total: _questions.length, results: _results),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    Color cardColor;
    IconData cardIcon;

    switch (question.type) {
      case "phrase":
        cardColor = Colors.blue.shade50;
        cardIcon = Icons.chat_bubble_outline;
        break;
      case "flashcard":
        cardColor = Colors.orange.shade50;
        cardIcon = Icons.menu_book_outlined;
        break;
      case "picture":
        cardColor = Colors.purple.shade50;
        cardIcon = Icons.image;
        break;
      default:
        cardColor = Colors.grey.shade100;
        cardIcon = Icons.help_outline;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF2A7BE6)),
          onPressed: () => Navigator.pop(context),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Choose the correct answer within 10 seconds",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Kumbh',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF878282),
              ),
            ),
            const SizedBox(height: 32),
            if (question.type == "picture" && question.image != null)
              SizedBox(
                width: 155,
                height: 155,
                child: Image.asset(question.image!, fit: BoxFit.contain),
              ),
            if (question.type != "picture" || question.image == null)
              Column(
                children: [
                  Icon(
                    cardIcon,
                    size: 40,
                    color: question.type == "phrase"
                        ? Colors.blue
                        : question.type == "flashcard"
                            ? Colors.orange
                            : Colors.purple,
                  ),
                  const SizedBox(height: 12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        question.phrase,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Kumbh',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 32),
            ...List.generate(_shuffledOptions.length, (index) {
              final option = _shuffledOptions[index];
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
                            bool isCorrect = option == question.correct;
                            if (isCorrect) _score++;

                            _results.add(ResultDetails(
                              phrase: question.phrase,
                              userAnswer: option,
                              correctAnswer: question.correct,
                              isCorrect: isCorrect,
                            ));

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                value: _timerController.value,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2A7BE6)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
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
          ],
        ),
      ),
    );
  }
}
