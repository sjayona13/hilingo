import 'dart:math';
import 'package:flutter/material.dart';
import 'qscore.dart';
import 'result_feature.dart';

class Qhard extends StatefulWidget {
  const Qhard({Key? key}) : super(key: key);

  @override
  _QhardState createState() => _QhardState();
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

class _QhardState extends State<Qhard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late List<Question> _questions;
  late List<String> _shuffledOptions;
  late AnimationController _timerController;
  final Duration questionDuration = const Duration(seconds: 10);

  final List<Question> allQuestions = [
    Question(
      type: "phrase",
      phrase: "I’m looking for the restroom",
      options: [
        "Nagapangita ako sang kasilyas",
        "Gusto ko magkaon",
        "Diin ang balay?"
      ],
      correct: "Nagapangita ako sang kasilyas",
    ),
    Question(
      type: "phrase",
      phrase: "Can you speak slower?",
      options: [
        "Pwede ka maghambal hinay?",
        "Pwede ka maglakat?",
        "Ano ang imo ngalan?"
      ],
      correct: "Pwede ka maghambal hinay?",
    ),
    Question(
      type: "phrase",
      phrase: "Where is the market?",
      options: ["Diin ang merkado?", "Diin ang simbahan?", "Diin ka makadto?"],
      correct: "Diin ang merkado?",
    ),
    Question(
      type: "phrase",
      phrase: "I will come tomorrow",
      options: ["Makadto ako buwas", "Nagakaon ako subong", "Gusto ko ini"],
      correct: "Makadto ako buwas",
    ),
    Question(
      type: "phrase",
      phrase: "How much is this?",
      options: ["Tagpila ini?", "Tagpila ka kilo?", "Diin ka makadto?"],
      correct: "Tagpila ini?",
    ),
    Question(
      type: "phrase",
      phrase: "Im sick",
      options: ["Gamasakit ako", "Gutom ako", "Indi ko maintindihan"],
      correct: "Gamasakit ako",
    ),
    Question(
      type: "phrase",
      phrase: "I don’t know",
      options: ["Wala ako kabalo", "Gusto ko ini", "Nagakaon ako"],
      correct: "Wala ako kabalo",
    ),
    Question(
      type: "phrase",
      phrase: "Call the police",
      options: ["Tawga ang pulis", "Tawga ang doktor", "Tawga ang kaibigan"],
      correct: "Tawga ang pulis",
    ),
    Question(
      type: "phrase",
      phrase: "I need water",
      options: [
        "Kinahanglan ko tubig",
        "Kinahanglan ko pagkaon",
        "Gusto ko ini"
      ],
      correct: "Kinahanglan ko sang tubig",
    ),
    Question(
      type: "phrase",
      phrase: "I am tired",
      options: ["Kapoy na ako", "Gutom ako", "Masakit ako"],
      correct: "Kapoy na ako",
    ),
    Question(
      type: "flashcard",
      phrase: "Mountain",
      options: ["Bukid", "Suba", "Kahoy"],
      correct: "Bukid",
    ),
    Question(
      type: "flashcard",
      phrase: "Bridge",
      options: ["Taytay", "Dalan", "Balay"],
      correct: "Taytay",
    ),
    Question(
      type: "flashcard",
      phrase: "River",
      options: ["Suba", "Bukid", "Kahoy"],
      correct: "Suba",
    ),
    Question(
      type: "flashcard",
      phrase: "Hospital",
      options: ["Ospital", "Eskwelahan", "Tindahan"],
      correct: "Ospital",
    ),
    Question(
      type: "flashcard",
      phrase: "Garden",
      options: ["Hardin", "Lasang", "Balay"],
      correct: "Hardin",
    ),
    Question(
      type: "flashcard",
      phrase: "Library",
      options: ["Librarya", "Eskwelahan", "Tindahan"],
      correct: "Librarya",
    ),
    Question(
      type: "flashcard",
      phrase: "Clock",
      options: ["Relo", "Libro", "Bolpen"],
      correct: "Relo",
    ),
    Question(
      type: "flashcard",
      phrase: "Window",
      options: ["Bintana", "Pwertahan", "Balay"],
      correct: "Bintana",
    ),
    Question(
      type: "picture",
      phrase: "Monkey",
      options: ["Amo", "Ido", "Kuring"],
      correct: "Amo",
      image: "assets/monkey.png",
    ),
    Question(
      type: "picture",
      phrase: "Tiger",
      options: ["Tigre", "Liyon", "Isda"],
      correct: "Tigre",
      image: "assets/tiger.png",
    ),
    Question(
      type: "picture",
      phrase: "Snake",
      options: ["Man-og", "Langgam", "Ido"],
      correct: "Man-og",
      image: "assets/snake.png",
    ),
    Question(
      type: "picture",
      phrase: "Crocodile",
      options: ["Buwaya", "Isda", "Kuring"],
      correct: "Buwaya",
      image: "assets/crocodile.png",
    ),
    Question(
      type: "picture",
      phrase: "Pineapple",
      options: ["Pinya", "Saging", "Mansanas"],
      correct: "Pinya",
      image: "assets/pineapple.png",
    ),
    Question(
      type: "picture",
      phrase: "Papaya",
      options: ["Kapayas", "Mango", "Saging"],
      correct: "Kapayas",
      image: "assets/papaya.png",
    ),
    Question(
      type: "picture",
      phrase: "Coconut",
      options: ["Lubi", "Mansanas", "Pinya"],
      correct: "Lubi",
      image: "assets/coconut.png",
    ),
    Question(
      type: "picture",
      phrase: "Motor",
      options: ["Motorsiklo", "Sakyanan", "Barko"],
      correct: "Motorsiklo",
      image: "assets/motorbike.png",
    ),
    Question(
      type: "picture",
      phrase: "Tricycle",
      options: ["Traysikel", "Motorsiklo", "Sakyanan"],
      correct: "Traysikel",
      image: "assets/tricycle.png",
    ),
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
    _questions = List.from(allQuestions)..shuffle();
    _questions = _questions.take(10).toList();
    _currentIndex = 0;
    _score = 0;
    _answered = false;
    _selectedIndex = null;
    _results = [];
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
