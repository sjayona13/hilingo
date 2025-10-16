import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'qhard.dart';

class Hcommonwords extends StatefulWidget {
  const Hcommonwords({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String phrase;
  final List<String> options;
  final String correct;

  Question({required this.phrase, required this.options, required this.correct});
}

class _QuizPageState extends State<Hcommonwords> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;

  late ConfettiController _confettiController;

  final List<Question> _allQuestions = [
    Question(phrase: 'Hello', options: ['Kamusta', 'Salamat', 'Indi'], correct: 'Kamusta'),
    Question(phrase: 'Thank you', options: ['Palihog', 'Salamat', 'Kamusta'], correct: 'Salamat'),
    Question(phrase: 'Please', options: ['Palihog', 'Salamat', 'Pasensya'], correct: 'Palihog'),
    Question(phrase: 'Yes', options: ['Indi', 'Oo', 'Siguro'], correct: 'Oo'),
    Question(phrase: 'No', options: ['Oo', 'Siguro', 'Indi'], correct: 'Indi'),
    Question(phrase: 'Good morning', options: ['Maayong aga', 'Maayong hapon', 'Maayong gab-i'], correct: 'Maayong aga'),
    Question(phrase: 'Good afternoon', options: ['Maayong aga', 'Maayong hapon', 'Maayong udto'], correct: 'Maayong hapon'),
    Question(phrase: 'Good evening', options: ['Maayong gab-i', 'Maayong aga', 'Maayong adlaw'], correct: 'Maayong gab-i'),
    Question(phrase: 'How are you?', options: ['Kamusta ka?', 'Ano na?', 'May ara ka?'], correct: 'Kamusta ka?'),
    Question(phrase: 'What is your name?', options: ['Sino imo ngalan?', 'Tag-a diin ka?', 'Pila edad mo?'], correct: 'Sino imo ngalan?'),
    Question(phrase: 'My name is John.', options: ['Ako si John.', 'Ako ya si John.', 'Si John ako.'], correct: 'Ako si John.'),
    Question(phrase: 'Where are you going?', options: ['Diin ka makadto?', 'San‑o ka pa?', 'Diin ka gikan?'], correct: 'Diin ka makadto?'),
    Question(phrase: 'I am going home.', options: ['Pauli na ako.', 'Kadto ako eskwelahan.', 'Lakaw ko mall.'], correct: 'Pauli na ako.'),
    Question(phrase: 'I am hungry.', options: ['Gutom na ako.', 'Uhaw ako.', 'Kapoy na ako.'], correct: 'Gutom na ako.'),
    Question(phrase: 'I am tired.', options: ['Kapoy na ako.', 'Gutom ako.', 'Uhaw ko.'], correct: 'Kapoy na ako.'),
    Question(phrase: 'I love you.', options: ['Palangga ta ikaw.', 'Ginahigugma ta ikaw.', 'Ginahambalan ta ikaw.'], correct: 'Palangga ta ikaw.'),
    Question(phrase: 'Goodbye', options: ['Babayi', 'Halong', 'Palihog'], correct: 'Halong'),
    Question(phrase: 'Take care', options: ['Halong', 'Kamusta', 'Salamat'], correct: 'Halong'),
    Question(phrase: 'Come here', options: ['Dali diri', 'Kadto didto', 'Palihog diri'], correct: 'Dali diri'),
    Question(phrase: 'Sit down', options: ['Pungko', 'Tindog', 'Dali diri'], correct: 'Pungko'),
    Question(phrase: 'Stand up', options: ['Tindog', 'Pungko', 'Dali'], correct: 'Tindog'),
    Question(phrase: 'Stop', options: ['Unta', 'Lakaw', 'Dali'], correct: 'Unta'),
    Question(phrase: 'Wait', options: ['Hulat', 'Lakaw', 'Pungko'], correct: 'Hulat'),
    Question(phrase: 'Eat', options: ['Kaon', 'Inom', 'Tulog'], correct: 'Kaon'),
    Question(phrase: 'Drink', options: ['Inom', 'Kaon', 'Tulog'], correct: 'Inom'),
    Question(phrase: 'Sleep', options: ['Tulog', 'Kaon', 'Hibalo'], correct: 'Tulog'),
    Question(phrase: 'Go', options: ['Kadto', 'Dali', 'Pungko'], correct: 'Kadto'),
    Question(phrase: 'Come', options: ['Dali', 'Lakaw', 'Tindog'], correct: 'Dali'),
    Question(phrase: 'Help', options: ['Bulig', 'Kaon', 'Tulog'], correct: 'Bulig'),
    Question(phrase: 'Hot', options: ['Mainit', 'Matugnaw', 'Maulan'], correct: 'Mainit'),
    Question(phrase: 'Cold', options: ['Matugnaw', 'Mainit', 'Malipayon'], correct: 'Matugnaw'),
    Question(phrase: 'Happy', options: ['Malipayon', 'Masubo', 'Masakit'], correct: 'Malipayon'),
    Question(phrase: 'Sad', options: ['Masubo', 'Malipayon', 'Mainit'], correct: 'Masubo'),
    Question(phrase: 'Beautiful', options: ['Gwapa', 'Pangit', 'Dako'], correct: 'Gwapa'),
    Question(phrase: 'Ugly', options: ['Pangit', 'Gwapa', 'Gamay'], correct: 'Pangit'),
    Question(phrase: 'Big', options: ['Dako', 'Gamay', 'Gwapa'], correct: 'Dako'),
    Question(phrase: 'Small', options: ['Gamay', 'Dako', 'Pangit'], correct: 'Gamay'),
    Question(phrase: 'Fast', options: ['Dasig', 'Hinay', 'Mainit'], correct: 'Dasig'),
    Question(phrase: 'Slow', options: ['Hinay', 'Dasig', 'Tulog'], correct: 'Hinay'),
    Question(phrase: 'Friend', options: ['Abyan', 'Kaaway', 'Palangga'], correct: 'Abyan'),
    Question(phrase: 'Enemy', options: ['Kaaway', 'Abyan', 'Halong'], correct: 'Kaaway'),
    Question(phrase: 'Child', options: ['Bata', 'Tigulang', 'Nanay'], correct: 'Bata'),
    Question(phrase: 'Mother', options: ['Nanay', 'Tatay', 'Bata'], correct: 'Nanay'),
    Question(phrase: 'Father', options: ['Tatay', 'Nanay', 'Bata'], correct: 'Tatay'),
    Question(phrase: 'Dog', options: ['Ido', 'Ilong', 'Ihaw'], correct: 'Ido'),
    Question(phrase: 'Cat', options: ['Kuring', 'Ihaw', 'Ido'], correct: 'Kuring'),
    Question(phrase: 'Fish', options: ['Isda', 'Ihaw', 'Ilong'], correct: 'Isda'),
    Question(phrase: 'Bird', options: ['Langgam', 'Isda', 'Ido'], correct: 'Langgam'),
    Question(phrase: 'Food', options: ['Pagkaon', 'Tubig', 'Hangin'], correct: 'Pagkaon'),
  ];

  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _loadNewSet();
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
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Qhard()));
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
                    '🎉 Your Score: $_score / ${_questions.length}',
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
  icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                const Center(
                  child: Text(
                    'Choose the correct translation',
                    style: TextStyle(
                      fontFamily: 'Kumbh',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xFF878282),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
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
                      width: 153, height: 115,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF878282)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        question.phrase, textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Kumbh', fontWeight: FontWeight.w400,
                          fontSize: 16, color: Color(0xFF878282),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ...List.generate(question.options.length, (index) {
                  final option = question.options[index];
                  Color borderColor = const Color(0xFF878282);
                  Color textColor = const Color(0xFF878282);
                  if (_answered) {
                    if (option == question.correct) {
                      borderColor = Colors.green; textColor = Colors.green;
                    } else if (_selectedIndex == index) {
                      borderColor = Colors.red; textColor = Colors.red;
                    }
                  }
                  return Container(
                    width: 258, height: 46, margin: const EdgeInsets.only(bottom: 12),
                    child: OutlinedButton(
                      onPressed: _answered ? null : () {
                        setState(() {
                          _selectedIndex = index; _answered = true;
                          if (option == question.correct) _score++;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(option,
                        style: TextStyle(color: textColor, fontFamily: 'Kumbh',
                          fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            left: 66, top: 643,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 132, height: 50,
              child: ElevatedButton(
                onPressed: _answered ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A7BE6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continue',
                  style: TextStyle(color: Colors.white,
                    fontFamily: 'Kumbh', fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
