import 'package:flutter/material.dart';
import 'qscore.dart';
import 'result_feature.dart';

class Qintermediate extends StatefulWidget {
  const Qintermediate({Key? key}) : super(key: key);

  @override
  _QintermediateState createState() => _QintermediateState();
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
    shuffled.shuffle();
    return shuffled;
  }
}

class _QintermediateState extends State<Qintermediate>
    with SingleTickerProviderStateMixin {
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
      phrase: "Could you repeat that, please?",
      options: ["Pwede mo balikon?", "Gusto ko ini", "Indi ko maintindihan"],
      correct: "Pwede mo balikon?",
    ),
    Question(
      type: "phrase",
      phrase: "I have a headache",
      options: ["Masakit ang ulo ko", "Gutom ako", "Nawad-an ako sang dalan"],
      correct: "Masakit ang ulo ko",
    ),
    Question(
      type: "phrase",
      phrase: "Where did you go yesterday?",
      options: [
        "Diin ka nagkadto kagapon?",
        "Ano ang imo ngalan?",
        "Gusto ko ini"
      ],
      correct: "Diin ka nagkadto kagapon?",
    ),
    Question(
      type: "phrase",
      phrase: "I don’t know how to say it",
      options: [
        "Indi ko kabalo kon paano ihambal",
        "Gusto ko ini",
        "Okay lang, salamat"
      ],
      correct: "Indi ko kabalo kon paano ihambal",
    ),
    Question(
      type: "phrase",
      phrase: "Can you speak slowly?",
      options: ["Pwede ka maghambal hinay?", "Pila ang imo edad?", "Gutom ako"],
      correct: "Pwede ka maghambal hinay?",
    ),
    Question(
      type: "phrase",
      phrase: "I forgot",
      options: ["Nalimtan ko", "Indi ko maintindihan", "Gusto ko ini"],
      correct: "Nalimtan ko",
    ),
    Question(
      type: "phrase",
      phrase: "What time is it?",
      options: ["Ano oras na?", "Diin ka makadto?", "Gutom ako"],
      correct: "Ano oras na?",
    ),
    Question(
      type: "phrase",
      phrase: "I need a doctor",
      options: ["Kinahanglan ko doktor", "Gusto ko ini", "Okay lang, salamat"],
      correct: "Kinahanglan ko doktor",
    ),
    Question(
      type: "phrase",
      phrase: "I’m allergic to peanuts",
      options: ["Allergic ako sa mani", "Gutom ako", "Pwede mo ako buligan?"],
      correct: "Allergic ako sa mani",
    ),
    Question(
      type: "phrase",
      phrase: "Could you write it down?",
      options: ["Pwede mo isulat?", "Gusto ko ini", "Indi ko maintindihan"],
      correct: "Pwede mo isulat?",
    ),
    Question(
      type: "flashcard",
      phrase: "Window",
      options: ["Bintana", "Pultahan", "Lamesa"],
      correct: "Bintana",
    ),
    Question(
      type: "flashcard",
      phrase: "Door",
      options: ["Puertahan", "Bintana", "Bangko"],
      correct: "Puertahan",
    ),
    Question(
      type: "flashcard",
      phrase: "Pillow",
      options: ["Ulonan", "Bangko", "Libro"],
      correct: "Ulonan",
    ),
    Question(
      type: "flashcard",
      phrase: "Blanket",
      options: ["Habol", "Lamesa", "Bolpen"],
      correct: "Habol",
    ),
    Question(
      type: "flashcard",
      phrase: "Stove",
      options: ["Kalan", "Kahoy", "Bukid"],
      correct: "Kalan",
    ),
    Question(
      type: "flashcard",
      phrase: "Spoon",
      options: ["Kutsara", "Tinidor", "Banga"],
      correct: "Kutsara",
    ),
    Question(
      type: "flashcard",
      phrase: "Fork",
      options: ["Tinidor", "Kutsara", "Banga"],
      correct: "Tinidor",
    ),
    Question(
      type: "flashcard",
      phrase: "Knife",
      options: ["Kutsilyo", "Tinidor", "Kutsara"],
      correct: "Kutsilyo",
    ),
    Question(
      type: "flashcard",
      phrase: "Cup",
      options: ["Tasa", "Banga", "Plato"],
      correct: "Tasa",
    ),
    Question(
      type: "picture",
      phrase: "Elephant",
      options: ["Elepante", "Kanding", "Ibon"],
      correct: "Elepante",
      image: "assets/elephant.png",
    ),
    Question(
      type: "picture",
      phrase: "Goat",
      options: ["Kanding", "Baka", "Kuring"],
      correct: "Kanding",
      image: "assets/goat.png",
    ),
    Question(
      type: "picture",
      phrase: "Cow",
      options: ["Baka", "Kanding", "Ido"],
      correct: "Baka",
      image: "assets/cow.png",
    ),
    Question(
      type: "picture",
      phrase: "Duck",
      options: ["Pato", "Langgam", "Isda"],
      correct: "Pato",
      image: "assets/duck.png",
    ),
    Question(
      type: "picture",
      phrase: "Pineapple",
      options: ["Pinya", "Mangga", "Saging"],
      correct: "Pinya",
      image: "assets/pineapple.png",
    ),
    Question(
      type: "picture",
      phrase: "Tomato",
      options: ["Kamatis", "Saging", "Mansanas"],
      correct: "Kamatis",
      image: "assets/tomato.png",
    ),
    Question(
      type: "picture",
      phrase: "Airplane",
      options: ["Eroplano", "Barko", "Bus"],
      correct: "Eroplano",
      image: "assets/plane.png",
    ),
    Question(
      type: "picture",
      phrase: "Helicopter",
      options: ["Helikopter", "Barko", "Sakyanan"],
      correct: "Helikopter",
      image: "assets/helicopter.png",
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
