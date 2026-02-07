import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'pscore.dart';
import 'result_feature.dart';

class PicHard extends StatefulWidget {
  const PicHard({Key? key}) : super(key: key);

  @override
  State<PicHard> createState() => _PicHardState();
}

class _PicHardState extends State<PicHard> {
  late ConfettiController _confettiController;
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  late List<PicQuestion> questions;

  final List<PicQuestion> hardPicQuestions = [
    PicQuestion(
      hiligaynon: 'Manugtudlo',
      options: [
        PicOption(
            label: 'Teacher', image: 'assets/teacher.png', isCorrect: true),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
        PicOption(label: 'Carpenter', image: 'assets/carpenter.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Doktor',
      options: [
        PicOption(label: 'Teacher', image: 'assets/teacher.png'),
        PicOption(label: 'Nurse', image: 'assets/nurse.png'),
        PicOption(label: 'Police', image: 'assets/police.png'),
        PicOption(label: 'Doctor', image: 'assets/doctor.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Pulis',
      options: [
        PicOption(label: 'Police', image: 'assets/police.png', isCorrect: true),
        PicOption(label: 'Soldier', image: 'assets/soldier.png'),
        PicOption(label: 'Fireman', image: 'assets/fireman.png'),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Mangunguma',
      options: [
        PicOption(label: 'Fisherman', image: 'assets/fisherman.png'),
        PicOption(label: 'Carpenter', image: 'assets/carpenter.png'),
        PicOption(label: 'Driver', image: 'assets/driver.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Mangingisda',
      options: [
        PicOption(
            label: 'Fisherman', image: 'assets/fisherman.png', isCorrect: true),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Drayber',
      options: [
        PicOption(label: 'Driver', image: 'assets/driver.png', isCorrect: true),
        PicOption(label: 'Police', image: 'assets/police.png'),
        PicOption(label: 'Carpenter', image: 'assets/carpenter.png'),
        PicOption(label: 'Teacher', image: 'assets/teacher.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugtahi',
      options: [
        PicOption(label: 'Carpenter', image: 'assets/carpenter.png'),
        PicOption(label: 'Tailor', image: 'assets/tailor.png', isCorrect: true),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Painter', image: 'assets/painter.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manunulat',
      options: [
        PicOption(label: 'Reader', image: 'assets/read.png'),
        PicOption(label: 'Painter', image: 'assets/painter.png'),
        PicOption(label: 'Writer', image: 'assets/writer.png', isCorrect: true),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manganganta',
      options: [
        PicOption(label: 'Dancer', image: 'assets/dancer.png'),
        PicOption(label: 'Singer', image: 'assets/singer.png', isCorrect: true),
        PicOption(label: 'Actor', image: 'assets/actor.png'),
        PicOption(label: 'Writer', image: 'assets/writer.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugpinta',
      options: [
        PicOption(
            label: 'Painter', image: 'assets/painter.png', isCorrect: true),
        PicOption(label: 'Writer', image: 'assets/writer.png'),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Kusinero',
      options: [
        PicOption(label: 'Painter', image: 'assets/painter.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png', isCorrect: true),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Sundalo',
      options: [
        PicOption(label: 'Police', image: 'assets/police.png'),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
        PicOption(label: 'Teacher', image: 'assets/teacher.png'),
        PicOption(
            label: 'Soldier', image: 'assets/soldier.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Bumbero',
      options: [
        PicOption(label: 'Police', image: 'assets/police.png'),
        PicOption(
            label: 'Fireman', image: 'assets/fireman.png', isCorrect: true),
        PicOption(label: 'Driver', image: 'assets/driver.png'),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugtanom',
      options: [
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
        PicOption(
            label: 'Gardener', image: 'assets/gardener.png', isCorrect: true),
        PicOption(label: 'Painter', image: 'assets/painter.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manug-gunting',
      options: [
        PicOption(label: 'Barber', image: 'assets/barber.png', isCorrect: true),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Teacher', image: 'assets/teacher.png'),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugbaligya',
      options: [
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Police', image: 'assets/police.png'),
        PicOption(label: 'Vendor', image: 'assets/vendor.png', isCorrect: true),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manuglimpyo',
      options: [
        PicOption(label: 'Painter', image: 'assets/painter.png'),
        PicOption(
            label: 'Cleaner', image: 'assets/cleaner.png', isCorrect: true),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugdul-ong',
      options: [
        PicOption(
            label: 'Deliverer', image: 'assets/deliverer.png', isCorrect: true),
        PicOption(label: 'Vendor', image: 'assets/vendor.png'),
        PicOption(label: 'Driver', image: 'assets/driver.png'),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugpanday',
      options: [
        PicOption(
            label: 'Carpenter', image: 'assets/carpenter.png', isCorrect: true),
        PicOption(label: 'Painter', image: 'assets/painter.png'),
        PicOption(label: 'Driver', image: 'assets/driver.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manughugas',
      options: [
        PicOption(label: 'Cleaner', image: 'assets/cleaner.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Washer', image: 'assets/washer.png', isCorrect: true),
        PicOption(label: 'Painter', image: 'assets/painter.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Gapaligo',
      options: [
        PicOption(
            label: 'Showering', image: 'assets/bather.png', isCorrect: true),
        PicOption(label: 'Swimming', image: 'assets/swim.png'),
        PicOption(label: 'Washing', image: 'assets/washer.png'),
        PicOption(label: 'Cooking', image: 'assets/cook.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugpinta sang balay',
      options: [
        PicOption(
            label: 'House Painter',
            image: 'assets/housepainter.png',
            isCorrect: true),
        PicOption(label: 'Tailor', image: 'assets/tailor.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Manugpuyo',
      options: [
        PicOption(
            label: 'Resident', image: 'assets/resident.png', isCorrect: true),
        PicOption(label: 'Visitor', image: 'assets/visitor.png'),
        PicOption(label: 'Traveler', image: 'assets/traveler.png'),
        PicOption(label: 'Vendor', image: 'assets/vendor.png'),
      ],
    ),
    PicQuestion(
      hiligaynon: 'Estudyante',
      options: [
        PicOption(
            label: 'Student', image: 'assets/students.png', isCorrect: true),
        PicOption(label: 'Doctor', image: 'assets/doctor.png'),
        PicOption(label: 'Cook', image: 'assets/cook.png'),
        PicOption(label: 'Farmer', image: 'assets/farmer.png'),
      ],
    ),
  ];

  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _score = 0;
    questions = _pickRandomQuestions(hardPicQuestions, 10);

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
            'Hard Level',
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
