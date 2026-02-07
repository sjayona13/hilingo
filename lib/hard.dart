import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'score.dart';
import 'result_feature.dart';

class HardPage extends StatefulWidget {
  const HardPage({Key? key}) : super(key: key);

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

class _QuizPageState extends State<HardPage> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late ConfettiController _confettiController;

  final List<Question> _allQuestions = [
    Question(
      phrase: 'Ano ginahimo mo?',
      options: [
        'What are you doing?',
        'Where are you going?',
        'Who are you with?'
      ],
      correct: 'What are you doing?',
    ),
    Question(
      phrase: 'Wala ko kabalo',
      options: ['I am not going', 'I don’t know', 'I am not hungry'],
      correct: 'I don’t know',
    ),
    Question(
      phrase: 'Ginapanilagan ko siya',
      options: [
        'I am waiting for him/her',
        'I am calling him/her',
        'I am watching him/her'
      ],
      correct: 'I am watching him/her',
    ),
    Question(
      phrase: 'Indi ko gusto sina',
      options: [
        'I don’t understand that',
        'I don’t like that',
        'I can’t hear that'
      ],
      correct: 'I don’t like that',
    ),
    Question(
      phrase: 'Nagakadlaw siya.',
      options: [
        'He/She is laughing.',
        'He/She is crying.',
        'He/She is running.'
      ],
      correct: 'He/She is laughing.',
    ),
    Question(
      phrase: 'Ginbutangan ko tubig ang baso',
      options: [
        'I washed the glass',
        'I broke the glass',
        'I put water in the glass'
      ],
      correct: 'I put water in the glass',
    ),
    Question(
      phrase: 'Ginbugno niya ako',
      options: ['He/She greeted me', 'He/She ignored me', 'He/She called me'],
      correct: 'He/She greeted me',
    ),
    Question(
      phrase: 'Palihog ko hugasi ang pinggan',
      options: [
        'Please cook the food',
        'Please wash the dishes',
        'Please open the door'
      ],
      correct: 'Please wash the dishes',
    ),
    Question(
      phrase: 'Nadula ang akon cellphone',
      options: [
        'My cellphone is missing',
        'My cellphone is charging',
        'My cellphone is broken'
      ],
      correct: 'My cellphone is missing',
    ),
    Question(
      phrase: 'Gitawag ka ni Mama mo',
      options: [
        'Your mother is angry',
        'Your mother is calling you',
        'Your mother is cooking'
      ],
      correct: 'Your mother is calling you',
    ),
    Question(
      phrase: 'Tingala ako ngaa wala ka nag-abot',
      options: [
        'I knew you would not come',
        'I forgot you were coming',
        'I wondered why you didn’t arrive'
      ],
      correct: 'I wondered why you didn’t arrive',
    ),
    Question(
      phrase: 'Ginpalangga niya ako pero wala ko kabalo',
      options: [
        'He/She loved me but I didn’t know',
        'He/She ignored me completely',
        'He/She lied to me'
      ],
      correct: 'He/She loved me but I didn’t know',
    ),
    Question(
      phrase: 'Mas nami pa ni kaysa sa sang una',
      options: [
        'This is better than before',
        'This is worse than before',
        'This is the same as before'
      ],
      correct: 'This is better than before',
    ),
    Question(
      phrase: 'Indi mo pag kalimtan ang imo ginhimo',
      options: [
        'Don’t repeat what you did',
        'Don’t forget what you did',
        'Don’t say what you did'
      ],
      correct: 'Don’t forget what you did',
    ),
    Question(
      phrase: 'Ginpabaylo ko ang kwarta sa tindahan',
      options: [
        'I spent the money at the store',
        'I exchanged the money at the store',
        'I borrowed money from the store'
      ],
      correct: 'I exchanged the money at the store',
    ),
    Question(
      phrase: 'Naglakat ako bisan ga-ulan',
      options: [
        'I stayed home because of rain',
        'I walked even though it was raining',
        'I ran to avoid the rain'
      ],
      correct: 'I walked even though it was raining',
    ),
    Question(
      phrase: 'Wala ko naga-uyat sang cellphone ko',
      options: [
        'I lost my cellphone',
        'I am not holding my cellphone',
        'I forgot my cellphone'
      ],
      correct: 'I am not holding my cellphone',
    ),
    Question(
      phrase: 'Gindala ko ang imo libro',
      options: [
        'I borrowed your book',
        'I lost your book',
        'I brought your book'
      ],
      correct: 'I brought your book',
    ),
    Question(
      phrase: 'Gusto ko ini nga bulak',
      options: ['I like this food', 'I like this garden', 'I like this flower'],
      correct: 'I like this flower',
    ),
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
      _selectedIndex = null;
      _results = [];
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
              score: _score, total: _questions.length, results: _results),
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
