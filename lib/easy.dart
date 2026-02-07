import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'score.dart';

import 'result_feature.dart';

class EasyPage extends StatefulWidget {
  const EasyPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String phrase;
  final List<String> options;
  final String correct;

  Question(
      {required this.phrase, required this.options, required this.correct});
}

class _QuizPageState extends State<EasyPage> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late ConfettiController _confettiController;

  final List<Question> _allQuestions = [
    Question(
        phrase: 'Thank you',
        options: ['Palihog', 'Salamat', 'Kamusta'],
        correct: 'Salamat'),
    Question(
        phrase: 'Please',
        options: ['Pasensya', 'Salamat', 'Palihog'],
        correct: 'Palihog'),
    Question(phrase: 'Yes', options: ['Indi', 'Oo', 'Siguro'], correct: 'Oo'),
    Question(phrase: 'No', options: ['Oo', 'Siguro', 'Indi'], correct: 'Indi'),
    Question(
        phrase: 'Good morning',
        options: ['Maayong aga', 'Maayong hapon', 'Maayong gab-i'],
        correct: 'Maayong aga'),
    Question(
        phrase: 'Good afternoon',
        options: ['Maayong aga', 'Maayong hapon', 'Maayong udto'],
        correct: 'Maayong hapon'),
    Question(
        phrase: 'Good evening',
        options: ['Maayong gab-i', 'Maayong aga', 'Maayong adlaw'],
        correct: 'Maayong gab-i'),
    Question(
        phrase: 'How are you?',
        options: ['Kamusta ka?', 'Ano na?', 'May ara ka?'],
        correct: 'Kamusta ka?'),
    Question(
        phrase: 'What is your name?',
        options: ['Pila imo edad?', 'Tag-a diin ka?', 'Ano imo ngalan?'],
        correct: 'Ano imo ngalan?'),
    Question(
        phrase: 'My name is John',
        options: ['Ako si John', 'Edad ko si John', 'Barkada ko si John'],
        correct: 'Ako si John'),
    Question(
        phrase: 'Where are you going?',
        options: ['Diin ka halin?', 'San‑o ka pa?', 'Diin ka makadto?'],
        correct: 'Diin ka makadto?'),
    Question(
        phrase: 'I am going home',
        options: ['Kadto ako eskwelahan', 'Pauli na ako', 'Lakaw ko mall'],
        correct: 'Pauli na ako'),
    Question(
        phrase: 'I am hungry',
        options: ['Gutom na ako', 'Uhaw ako', 'Kapoy na ako'],
        correct: 'Gutom na ako'),
    Question(
        phrase: 'I am tired',
        options: ['Gutom ako', 'Kapoy na ako', 'Uhaw ko'],
        correct: 'Kapoy na ako'),
    Question(
        phrase: 'I love you',
        options: ['Palangga taka', 'Ginapasalamatan taka', 'Ginahambalan taka'],
        correct: 'Palangga taka'),
    Question(
        phrase: 'Take care',
        options: ['Halong', 'Kamusta', 'Salamat'],
        correct: 'Halong'),
    Question(
        phrase: 'Come here',
        options: ['Kadto didto', 'Dali diri', 'Palihog diri'],
        correct: 'Dali diri'),
    Question(
        phrase: 'Sit down',
        options: ['Pungko', 'Tindog', 'Dali diri'],
        correct: 'Pungko'),
    Question(
        phrase: 'Stand up',
        options: ['Pungko', 'Dali', 'Tindog'],
        correct: 'Tindog'),
    Question(
        phrase: 'Stop', options: ['Untat', 'Lakaw', 'Dali'], correct: 'Untat'),
    Question(
        phrase: 'Wait',
        options: ['Hulat', 'Lakaw', 'Pungko'],
        correct: 'Hulat'),
    Question(
        phrase: 'Eat', options: ['Inom', 'Kaon', 'Tulog'], correct: 'Kaon'),
    Question(
        phrase: 'Drink', options: ['Inom', 'Kaon', 'Tulog'], correct: 'Inom'),
    Question(
        phrase: 'Sleep',
        options: ['Kaon', 'Tulog', 'Hibalo'],
        correct: 'Tulog'),
    Question(
        phrase: 'Come', options: ['Dali', 'Lagaw', 'Tindog'], correct: 'Dali'),
    Question(
        phrase: 'Help', options: ['Kaon', 'Tulog', 'Bulig'], correct: 'Bulig'),
    Question(
        phrase: 'Hot',
        options: ['Mainit', 'Matugnaw', 'Maulan'],
        correct: 'Mainit'),
    Question(
        phrase: 'Cold',
        options: ['Mainit', 'Matugnaw', 'Malipayon'],
        correct: 'Matugnaw'),
    Question(
        phrase: 'Happy',
        options: ['Malipayon', 'Masubo', 'Masakit'],
        correct: 'Malipayon'),
    Question(
        phrase: 'Sad',
        options: ['Masubo', 'Malipayon', 'Mainit'],
        correct: 'Masubo'),
    Question(
        phrase: 'Beautiful',
        options: ['Pangit', 'Gwapa', 'Dako'],
        correct: 'Gwapa'),
    Question(
        phrase: 'Ugly',
        options: ['Law-ay', 'Gwapa', 'Gamay'],
        correct: 'Law-ay'),
    Question(
        phrase: 'Big', options: ['Gamay', 'Dako', 'Gwapa'], correct: 'Dako'),
    Question(
        phrase: 'Small',
        options: ['Dako', 'Gamay', 'Pangit'],
        correct: 'Gamay'),
    Question(
        phrase: 'Fast',
        options: ['Hinay', 'Mainit', 'Dasig'],
        correct: 'Dasig'),
    Question(
        phrase: 'Slow', options: ['Hinay', 'Dasig', 'Tulog'], correct: 'Hinay'),
    Question(
        phrase: 'Friend',
        options: ['Abyan', 'Kaaway', 'Palangga'],
        correct: 'Abyan'),
    Question(
        phrase: 'Enemy',
        options: ['Abyan', 'Kaaway', 'Halong'],
        correct: 'Kaaway'),
    Question(
        phrase: 'Child',
        options: ['Bata', 'Tigulang', 'Nanay'],
        correct: 'Bata'),
    Question(
        phrase: 'Mother',
        options: ['Tatay', 'Nanay', 'Bata'],
        correct: 'Nanay'),
    Question(
        phrase: 'Father',
        options: ['Tatay', 'Nanay', 'Bata'],
        correct: 'Tatay'),
    Question(phrase: 'Dog', options: ['Ilong', 'Ido', 'Ihaw'], correct: 'Ido'),
    Question(
        phrase: 'Cat', options: ['Ihaw', 'Ido', 'Kuring'], correct: 'Kuring'),
    Question(
        phrase: 'Fish', options: ['Isda', 'Ihaw', 'Ilong'], correct: 'Isda'),
    Question(
        phrase: 'Bird',
        options: ['Langgam', 'Isda', 'Pispis'],
        correct: 'Pispis'),
    Question(
        phrase: 'Food',
        options: ['Pagkaon', 'Tubig', 'Hangin'],
        correct: 'Pagkaon'),
  ];

  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _loadNewSet();
  }

  void _loadNewSet() {
    setState(() {
      _questions = List.from(_allQuestions)..shuffle();
      _questions = _questions.take(10).toList();
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _results = []; // Reset results
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScorePage(
            score: _score,
            total: _questions.length,
            results: _results,
          ),
        ),
      );
    }
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
      body: Padding(
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
                            bool isCorrect = option == question.correct;
                            if (isCorrect) _score++;

                            _results.add(ResultDetails(
                              phrase: question.phrase,
                              userAnswer: option,
                              correctAnswer: question.correct,
                              isCorrect: isCorrect,
                            ));
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: SizedBox(
                width: 300,
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
