// flash_medium.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_application_1/score.dart';
import 'score.dart'; // Make sure you have ScorePage implemented

class FlashMedium extends StatefulWidget {
  const FlashMedium({Key? key}) : super(key: key);

  @override
  State<FlashMedium> createState() => _FlashMediumState();
}

class _FlashMediumState extends State<FlashMedium> {
  late ConfettiController _confettiController;

  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;

  late List<FlashCard> flashCards;

  final List<FlashCard> allFlashCards = [
    FlashCard(
      image: 'assets/shadow.png',
      english: 'Shadow',
      options: ['Landong', 'Kalayo', 'Panganod', 'Asu'],
      correct: 'Landong',
    ),
    FlashCard(
      image: 'assets/noise.png',
      english: 'Noise',
      options: ['Gahod', 'Hilom', 'Tingog', 'Tingog sang Iro'],
      correct: 'Gahod',
    ),
    FlashCard(
      image: 'assets/fire.png',
      english: 'Fire',
      options: ['Kalayo', 'Tubig', 'Hangin', 'Bato'],
      correct: 'Kalayo',
    ),
    FlashCard(
      image: 'assets/water.png',
      english: 'Water',
      options: ['Tubig', 'Adlaw', 'Bituon', 'Balay'],
      correct: 'Tubig',
    ),
    FlashCard(
      image: 'assets/tree2.png',
      english: 'Tree',
      options: ['Puno', 'Sanga', 'Dahon', 'Bulak'],
      correct: 'Puno',
    ),
    FlashCard(
      image: 'assets/flower2.png',
      english: 'Flower',
      options: ['Bulak', 'Buyog', 'Hilamon', 'Saging'],
      correct: 'Bulak',
    ),
    FlashCard(
      image: 'assets/mountain2.png',
      english: 'Mountain',
      options: ['Bukid', 'Suba', 'Balay', 'Tinapay'],
      correct: 'Bukid',
    ),
    FlashCard(
      image: 'assets/river2.png',
      english: 'River',
      options: ['Suba', 'Bay-Bay', 'Kamote', 'Ulan'],
      correct: 'Suba',
    ),
    FlashCard(
      image: 'assets/bird2.png',
      english: 'Bird',
      options: ['PisPis', 'Manok', 'Dahon', 'Ulan'],
      correct: 'PisPis',
    ),
    FlashCard(
      image: 'assets/dog2.png',
      english: 'Dog',
      options: ['Iro', 'Kuring', 'Kamote', 'Ulan'],
      correct: 'Iro',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _score = 0;

    allFlashCards.shuffle();
    flashCards = allFlashCards.take(10).toList();
    for (var card in flashCards) {
      card.options.shuffle();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      answered = true;
      isCorrect =
          flashCards[currentIndex].options[index] == flashCards[currentIndex].correct;
      if (isCorrect) {
        _score++;
      }
    });
  }

  void nextCard() {
    setState(() {
      if (currentIndex < flashCards.length - 1) {
        currentIndex++;
        selectedIndex = null;
        answered = false;
        flashCards[currentIndex].options.shuffle();
      } else {
        // Show ScorePage with confetti
        _confettiController.play();

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ScorePage(
                  score: _score,
                  total: flashCards.length,
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
    final card = flashCards[currentIndex];

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
                  '${currentIndex + 1} / ${flashCards.length}',
                  style: const TextStyle(color: Color(0xFF878282), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Choose the correct match for each flashcard',
                style: TextStyle(color: Color(0xFF878282), fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 180,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF878282)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(card.image, height: 100, width: 100, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(
                    card.english,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 16),
            if (answered && !isCorrect)
              const Text(
                'Try again',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

class FlashCard {
  final String image;
  final String english;
  final List<String> options;
  final String correct;

  FlashCard({
    required this.image,
    required this.english,
    required this.options,
    required this.correct,
  });
}
