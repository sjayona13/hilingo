import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'stats.dart';

enum QuizDifficulty { easy, intermediate, hard, assessment }

class TimedQuizPage extends StatefulWidget {
  final QuizDifficulty difficulty;
  final Duration? perQuestionDuration;
  final int? questionCount;
  final void Function(BuildContext context, int score, int total)? onFinished;

  const TimedQuizPage({
    Key? key,
    required this.difficulty,
    this.perQuestionDuration,
    this.questionCount,
    this.onFinished,
  }) : super(key: key);

  @override
  State<TimedQuizPage> createState() => _TimedQuizPageState();
}

class _TimedQuizPageState extends State<TimedQuizPage>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _timerController;

  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;

  int _score = 0;
  static int _easyScore = 0;
  static int _mediumScore = 0;
  static int _hardScore = 0;

  late final Duration questionDuration;
  late List<QuizCard> cards;

  final List<QuizCard> easyCards = [
    QuizCard(
      image: 'assets/sun.png',
      english: 'Sun',
      options: ['Ulan', 'Dagu-ob', 'Adlaw', 'Gab-i'],
      correct: 'Adlaw',
    ),
    QuizCard(
      image: 'assets/moon.png',
      english: 'Moon',
      options: ['Gab-i', 'Dagu-ob', 'Ulan', 'Adlaw'],
      correct: 'Gab-i',
    ),
  ];

  final List<QuizCard> mediumCards = [
    QuizCard(
      image: 'assets/wind.png',
      english: 'Wind',
      options: ['Hangin', 'Ulan', 'Gab-i', 'Adlaw'],
      correct: 'Hangin',
    ),
    QuizCard(
      image: 'assets/tree.png',
      english: 'Tree',
      options: ['Kahoy', 'Adlaw', 'Ulan', 'Dagu-ob'],
      correct: 'Kahoy',
    ),
  ];

  final List<QuizCard> hardCards = [
    QuizCard(
      image: 'assets/river.png',
      english: 'River',
      options: ['Suba', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Suba',
    ),
    QuizCard(
      image: 'assets/mountain.png',
      english: 'Mountain',
      options: ['Bukid', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Bukid',
    ),
  ];

  // Countdown variables
  bool _showCountdown = false;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();

    cards = _getCardsForDifficulty(widget.difficulty);
    questionDuration =
        widget.perQuestionDuration ?? _durationForDifficulty(widget.difficulty);

    _timerController = AnimationController(
      vsync: this,
      duration: questionDuration,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !answered) {
          setState(() {
            answered = true;
            isCorrect = false;
          });
        }
      })
      ..addListener(() {
        if (mounted) setState(() {});
      });
    _timerController.forward(from: 0);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _timerController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  List<QuizCard> _getCardsForDifficulty(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return _pickRandom(easyCards, 25);
      case QuizDifficulty.intermediate:
        return _pickRandom(mediumCards, 15);
      case QuizDifficulty.hard:
        return _pickRandom(hardCards, 10);
      default:
        return [];
    }
  }

  Duration _durationForDifficulty(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return const Duration(seconds: 10);
      case QuizDifficulty.intermediate:
        return const Duration(seconds: 8);
      case QuizDifficulty.hard:
        return const Duration(seconds: 6);
      case QuizDifficulty.assessment:
        return const Duration(seconds: 4);
    }
  }

  List<QuizCard> _pickRandom(List<QuizCard> source, int count) {
    final random = Random();
    final result = <QuizCard>[];
    while (result.length < count) {
      result.add(source[random.nextInt(source.length)]);
    }
    return result;
  }

  void checkAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
      isCorrect =
          cards[currentIndex].options[index] == cards[currentIndex].correct;
      if (isCorrect) _score++;
      _timerController.stop();
    });
  }

  void nextCard() {
    setState(() {
      if (currentIndex < cards.length - 1) {
        currentIndex++;
        selectedIndex = null;
        answered = false;
        _timerController
          ..duration = questionDuration
          ..forward(from: 0);
      } else {
        _handleNextLevel();
      }
    });
  }

  void _startCountdown(VoidCallback onComplete) {
    setState(() {
      _showCountdown = true;
      _countdown = 3;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_countdown > 1) {
        setState(() => _countdown--);
        return true;
      } else {
        setState(() {
          _showCountdown = false;
        });
        onComplete();
        return false;
      }
    });
  }

  void _handleNextLevel() {
    if (widget.difficulty == QuizDifficulty.easy) {
      _easyScore = _score;
      _startCountdown(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TimedQuizPage(difficulty: QuizDifficulty.intermediate),
          ),
        );
      });
    } else if (widget.difficulty == QuizDifficulty.intermediate) {
      _mediumScore = _score;
      _startCountdown(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TimedQuizPage(difficulty: QuizDifficulty.hard),
          ),
        );
      });
    } else if (widget.difficulty == QuizDifficulty.hard) {
      _hardScore = _score;
      _showFinalStats();
    }
  }

  void _showFinalStats() {
    _confettiController.play();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StatsPage(
          easyScore: _easyScore,
          easyTotal: 25,
          mediumScore: _mediumScore,
          mediumTotal: 15,
          hardScore: _hardScore,
          hardTotal: 10,
        ),
      ),
    );
  }

  String _titleForDifficulty() {
    switch (widget.difficulty) {
      case QuizDifficulty.easy:
        return 'Easy';
      case QuizDifficulty.intermediate:
        return 'Intermediate';
      case QuizDifficulty.hard:
        return 'Hard';
      case QuizDifficulty.assessment:
        return 'Assessment';
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_titleForDifficulty()}',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${currentIndex + 1} / ${cards.length}',
                style: const TextStyle(color: Color(0xFF878282), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Choose the correct match for each flashcard within the time limit',
                  style: TextStyle(color: Color(0xFF878282), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 220,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF878282)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(card.image,
                        height: 140, width: 140, fit: BoxFit.contain),
                    const SizedBox(height: 16),
                    Text(
                      card.english,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(card.options.length, (index) {
                  final option = card.options[index];
                  final isSelected = selectedIndex == index;
                  final isRight = option == card.correct;

                  Color borderColor = const Color(0xFF878282);
                  Color textColor = const Color(0xFF878282);

                  if (answered) {
                    if (isRight) {
                      borderColor = Colors.green;
                      textColor = Colors.green;
                    } else if (isSelected) {
                      borderColor = Colors.red;
                      textColor = Colors.red;
                    }
                  }

                  return SizedBox(
                    width: 140,
                    child: OutlinedButton(
                      onPressed: answered ? null : () => checkAnswer(index),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: borderColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(option, style: TextStyle(color: textColor)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _timerController.value,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF2A7BE6)),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: answered ? nextCard : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A7BE6),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
          if (_showCountdown)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Text(
                _countdown > 0 ? '$_countdown' : 'GO!',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QuizCard {
  final String image;
  final String english;
  final List<String> options;
  final String correct;

  QuizCard({
    required this.image,
    required this.english,
    required this.options,
    required this.correct,
  });
}
