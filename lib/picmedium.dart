import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'pscore.dart';
import 'result_feature.dart';

class PicMedium extends StatefulWidget {
  const PicMedium({Key? key}) : super(key: key);

  @override
  State<PicMedium> createState() => _PicMediumState();
}

class _PicMediumState extends State<PicMedium> {
  late ConfettiController _confettiController;
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late List<PicQuestion> questions;

  final List<PicQuestion> mediumPicQuestions = [
    PicQuestion(
      hiligaynon: 'Balay',
      options: [
        PicOption(label: 'House', image: 'assets/house.png', isCorrect: true),
        PicOption(label: 'Car', image: 'assets/car.png'),
        PicOption(label: 'School', image: 'assets/school.png'),
        PicOption(label: 'Tree', image: 'assets/tree.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Eskwelahan',
      options: [
        PicOption(label: 'Hospital', image: 'assets/hospital.png'),
        PicOption(label: 'School', image: 'assets/school.png', isCorrect: true),
        PicOption(label: 'Market', image: 'assets/markets.png'),
        PicOption(label: 'Church', image: 'assets/church.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Pangamuyo',
      options: [
        PicOption(label: 'Run', image: 'assets/run.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
        PicOption(label: 'Pray', image: 'assets/pray.png', isCorrect: true),
        PicOption(label: 'Eat', image: 'assets/eat.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Kaon',
      options: [
        PicOption(label: 'Drink', image: 'assets/drink.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
        PicOption(label: 'Walk', image: 'assets/walk.png'),
        PicOption(label: 'Eat', image: 'assets/eat.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Inom',
      options: [
        PicOption(label: 'Drink', image: 'assets/drink.png', isCorrect: true),
        PicOption(label: 'Eat', image: 'assets/eat.png'),
        PicOption(label: 'Swim', image: 'assets/swim.png'),
        PicOption(label: 'Read', image: 'assets/read.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tulog',
      options: [
        PicOption(label: 'Run', image: 'assets/run.png'),
        PicOption(label: 'Dance', image: 'assets/dance.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png', isCorrect: true),
        PicOption(label: 'Read', image: 'assets/read.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Basa',
      options: [
        PicOption(label: 'Write', image: 'assets/write.png'),
        PicOption(label: 'Draw', image: 'assets/draw.png'),
        PicOption(label: 'Read', image: 'assets/read.png', isCorrect: true),
        PicOption(label: 'Sing', image: 'assets/sing.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Sulat',
      options: [
        PicOption(label: 'Read', image: 'assets/read.png'),
        PicOption(label: 'Draw', image: 'assets/draw.png'),
        PicOption(label: 'Paint', image: 'assets/paint.png'),
        PicOption(label: 'Write', image: 'assets/write.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Kanta',
      options: [
        PicOption(label: 'Dance', image: 'assets/dance.png'),
        PicOption(label: 'Talk', image: 'assets/talk.png'),
        PicOption(label: 'Sing', image: 'assets/sing.png', isCorrect: true),
        PicOption(label: 'Run', image: 'assets/run.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Sayaw',
      options: [
        PicOption(label: 'Dance', image: 'assets/dance.png', isCorrect: true),
        PicOption(label: 'Sing', image: 'assets/sing.png'),
        PicOption(label: 'Run', image: 'assets/run.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Dalagan',
      options: [
        PicOption(label: 'Walk', image: 'assets/walk.png'),
        PicOption(label: 'Jump', image: 'assets/jump.png'),
        PicOption(label: 'Sit', image: 'assets/sit.png'),
        PicOption(label: 'Run', image: 'assets/run.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Lakat',
      options: [
        PicOption(label: 'Run', image: 'assets/run.png'),
        PicOption(label: 'Jump', image: 'assets/jump.png'),
        PicOption(label: 'Sit', image: 'assets/sit.png'),
        PicOption(label: 'Walk', image: 'assets/walk.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Pungko',
      options: [
        PicOption(label: 'Stand', image: 'assets/stand.png'),
        PicOption(label: 'Run', image: 'assets/run.png'),
        PicOption(label: 'Sit', image: 'assets/sit.png', isCorrect: true),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Indi',
      options: [
        PicOption(label: 'No', image: 'assets/no.png', isCorrect: true),
        PicOption(label: 'Yes', image: 'assets/yes.png'),
        PicOption(label: 'Maybe', image: 'assets/maybe.png'),
        PicOption(label: 'Go', image: 'assets/go.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Oo',
      options: [
        PicOption(label: 'No', image: 'assets/no.png'),
        PicOption(label: 'Go', image: 'assets/go.png'),
        PicOption(label: 'Stop', image: 'assets/stop.png'),
        PicOption(label: 'Yes', image: 'assets/yes.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tindog',
      options: [
        PicOption(label: 'Sit', image: 'assets/sit.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
        PicOption(label: 'Walk', image: 'assets/walk.png'),
        PicOption(label: 'Stand', image: 'assets/stand.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Ginhawa',
      options: [
        PicOption(
            label: 'Breathe', image: 'assets/breathe.png', isCorrect: true),
        PicOption(label: 'Eat', image: 'assets/eat.png'),
        PicOption(label: 'Drink', image: 'assets/drink.png'),
        PicOption(label: 'Run', image: 'assets/run.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tubo',
      options: [
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
        PicOption(label: 'Read', image: 'assets/read.png'),
        PicOption(label: 'Grow', image: 'assets/grow.png', isCorrect: true),
        PicOption(label: 'Jump', image: 'assets/jump.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Hilam-os',
      options: [
        PicOption(label: 'Brush teeth', image: 'assets/brush.png'),
        PicOption(label: 'Bathe', image: 'assets/bathe.png'),
        PicOption(label: 'Sleep', image: 'assets/sleep.png'),
        PicOption(
            label: 'Wash face', image: 'assets/washface.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Gatas',
      options: [
        PicOption(label: 'Milk', image: 'assets/milk.png', isCorrect: true),
        PicOption(label: 'Juice', image: 'assets/juice.png'),
        PicOption(label: 'Coffee', image: 'assets/coffee.png'),
        PicOption(label: 'Water', image: 'assets/water.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tubig',
      options: [
        PicOption(label: 'Water', image: 'assets/water.png', isCorrect: true),
        PicOption(label: 'Juice', image: 'assets/juice.png'),
        PicOption(label: 'Coffee', image: 'assets/coffee.png'),
        PicOption(label: 'Soda', image: 'assets/soda.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tinapay',
      options: [
        PicOption(label: 'Rice', image: 'assets/rice.png'),
        PicOption(label: 'Grapes', image: 'assets/grape.png'),
        PicOption(label: 'Soda', image: 'assets/soda.png'),
        PicOption(label: 'Bread', image: 'assets/bread.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Kutsara',
      options: [
        PicOption(label: 'Fork', image: 'assets/fork.png'),
        PicOption(label: 'Plate', image: 'assets/plate.png'),
        PicOption(label: 'Spoon', image: 'assets/spoon.png', isCorrect: true),
        PicOption(label: 'Glass', image: 'assets/glass.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Tinidor',
      options: [
        PicOption(label: 'Spoon', image: 'assets/spoon.png'),
        PicOption(label: 'Knife', image: 'assets/knife.png'),
        PicOption(label: 'Fork', image: 'assets/fork.png', isCorrect: true),
        PicOption(label: 'Plate', image: 'assets/plate.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Pinggan',
      options: [
        PicOption(label: 'Plate', image: 'assets/plate.png', isCorrect: true),
        PicOption(label: 'Spoon', image: 'assets/spoon.png'),
        PicOption(label: 'Cup', image: 'assets/cup.png'),
        PicOption(label: 'Glass', image: 'assets/glass.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Kutsilyo',
      options: [
        PicOption(label: 'Knife', image: 'assets/knife.png', isCorrect: true),
        PicOption(label: 'Fork', image: 'assets/fork.png'),
        PicOption(label: 'Spoon', image: 'assets/spoon.png'),
        PicOption(label: 'Glass', image: 'assets/glass.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Orasan',
      options: [
        PicOption(label: 'Phone', image: 'assets/phone.png'),
        PicOption(label: 'Calendar', image: 'assets/calendar.png'),
        PicOption(label: 'Book', image: 'assets/book.png'),
        PicOption(label: 'Clock', image: 'assets/clock.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Lapis',
      options: [
        PicOption(label: 'Pen', image: 'assets/pen.png'),
        PicOption(label: 'Pencil', image: 'assets/pencil.png', isCorrect: true),
        PicOption(label: 'Eraser', image: 'assets/eraser.png'),
        PicOption(label: 'Book', image: 'assets/book.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Libro',
      options: [
        PicOption(label: 'Paper', image: 'assets/paper.png'),
        PicOption(label: 'Pencil', image: 'assets/pencil.png'),
        PicOption(label: 'Notebook', image: 'assets/notebook.png'),
        PicOption(label: 'Book', image: 'assets/book.png', isCorrect: true),
      ],
    ),
  ];

  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _score = 0;
    questions = _pickRandomQuestions(mediumPicQuestions, 10);

    for (var q in questions) {
      q.options.shuffle(Random());
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  List<PicQuestion> _pickRandomQuestions(List<PicQuestion> source, int count) {
    final random = Random();
    final copy = List<PicQuestion>.from(source);
    copy.shuffle(random);
    return copy.take(count).toList();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      answered = true;
      isCorrect = questions[currentIndex].options[index].isCorrect;
      if (isCorrect) _score++;

      _results.add(ResultDetails(
        phrase: questions[currentIndex].hiligaynon,
        userAnswer: questions[currentIndex].options[index].label,
        correctAnswer: questions[currentIndex]
            .options
            .firstWhere((o) => o.isCorrect)
            .label,
        isCorrect: isCorrect,
      ));
    });
  }

  void nextCard() {
    setState(() {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        selectedIndex = null;
        answered = false;
        questions[currentIndex].options.shuffle(Random());
      } else {
        _confettiController.play();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => PscorePage(
                  score: _score,
                  total: questions.length,
                  results: _results,
                ),
              ),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return WillPopScope(
      onWillPop: () async {
        _confettiController.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _confettiController.stop();
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Medium Level',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '${currentIndex + 1} / ${questions.length}',
                  style:
                      const TextStyle(color: Color(0xFF878282), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Select the correct image',
                style: TextStyle(color: Color(0xFF878282), fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                question.hiligaynon,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildOption(0, question)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildOption(1, question)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildOption(2, question)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildOption(3, question)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 50),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: answered ? nextCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A7BE6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index, PicQuestion question) {
    if (index >= question.options.length) return const SizedBox.shrink();

    final option = question.options[index];
    final isSelected = selectedIndex == index;
    final isRight = option.isCorrect;

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

    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: OutlinedButton(
              onPressed: answered ? null : () => checkAnswer(index),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(option.image, fit: BoxFit.contain),
                    ),
                  ),
                  Text(
                    option.label,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          if (answered && isSelected && isRight)
            Positioned(
              right: 4,
              bottom: 4,
              child: _buildIcon(Icons.check, Colors.green),
            ),
          if (answered && isSelected && !isRight)
            Positioned(
              right: 4,
              bottom: 4,
              child: _buildIcon(Icons.close, Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}

class PicQuestion {
  final String hiligaynon;
  final List<PicOption> options;

  PicQuestion({required this.hiligaynon, required this.options});
}

class PicOption {
  final String label;
  final String image;
  final bool isCorrect;

  PicOption({required this.label, required this.image, this.isCorrect = false});
}
