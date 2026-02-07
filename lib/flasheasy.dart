import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'escore.dart';
import 'result_feature.dart';

class FlashEasy extends StatefulWidget {
  const FlashEasy({Key? key}) : super(key: key);

  @override
  State<FlashEasy> createState() => _FlashNavEasyState();
}

class _FlashNavEasyState extends State<FlashEasy> {
  late ConfettiController _confettiController;

  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;
  List<ResultDetails> _results = [];

  final List<FlashCard> allFlashCards = [
    FlashCard(
      image: 'assets/sun.png',
      english: 'Sun',
      options: ['Ulan', 'Dagu-ob', 'Adlaw', 'Gab-i'],
      correct: 'Adlaw',
    ),
    FlashCard(
      image: 'assets/moon.png',
      english: 'Moon',
      options: ['Bulan', 'Dagu-ob', 'Ulan', 'Adlaw'],
      correct: 'Bulan',
    ),
    FlashCard(
      image: 'assets/rain.png',
      english: 'Rain',
      options: ['Dagu-ob', 'Adlaw', 'Gab-i', 'Ulan'],
      correct: 'Ulan',
    ),
    FlashCard(
      image: 'assets/cloud.png',
      english: 'Cloud',
      options: ['Ulan', 'Panganod', 'Adlaw', 'Gab-i'],
      correct: 'Panganod',
    ),
    FlashCard(
      image: 'assets/star.png',
      english: 'Star',
      options: ['Adlaw', 'Gab-i', 'Bituon', 'Ulan'],
      correct: 'Bituon',
    ),
    FlashCard(
      image: 'assets/wind.png',
      english: 'Wind',
      options: ['Ulan', 'Hangin', 'Gab-i', 'Adlaw'],
      correct: 'Hangin',
    ),
    FlashCard(
      image: 'assets/tree.png',
      english: 'Tree',
      options: ['Kahoy', 'Adlaw', 'Ulan', 'Dagu-ob'],
      correct: 'Kahoy',
    ),
    FlashCard(
      image: 'assets/flower.png',
      english: 'Flower',
      options: ['Gab-i', 'Bulak', 'Adlaw', 'Ulan'],
      correct: 'Bulak',
    ),
    FlashCard(
      image: 'assets/river.png',
      english: 'River',
      options: ['Suba', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Suba',
    ),
    FlashCard(
      image: 'assets/mountain.png',
      english: 'Mountain',
      options: ['Gab-i', 'Bukid', 'Adlaw', 'Ulan'],
      correct: 'Bukid',
    ),
    FlashCard(
      image: 'assets/fish.png',
      english: 'Fish',
      options: ['Isda', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Isda',
    ),
    FlashCard(
      image: 'assets/bird.png',
      english: 'Bird',
      options: ['Gab-i', 'Adlaw', 'Pispis', 'Ulan'],
      correct: 'Pispis',
    ),
    FlashCard(
      image: 'assets/dog.png',
      english: 'Dog',
      options: ['Gab-i', 'Adlaw', 'Ido', 'Ulan'],
      correct: 'Ido',
    ),
    FlashCard(
      image: 'assets/cat.png',
      english: 'Cat',
      options: ['Gab-i', 'Kuring', 'Adlaw', 'Ulan'],
      correct: 'Kuring',
    ),
    FlashCard(
      image: 'assets/house.png',
      english: 'House',
      options: ['Gab-i', 'Adlaw', 'Ulan', 'Balay'],
      correct: 'Balay',
    ),
    FlashCard(
      image: 'assets/car.png',
      english: 'Car',
      options: ['Gab-i', 'Salakyan', 'Adlaw', 'Ulan'],
      correct: 'Salakyan',
    ),
    FlashCard(
      image: 'assets/book.png',
      english: 'Book',
      options: ['Libro', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Libro',
    ),
    FlashCard(
      image: 'assets/phone.png',
      english: 'Phone',
      options: ['Gab-i', 'Telepono', 'Adlaw', 'Ulan'],
      correct: 'Telepono',
    ),
    FlashCard(
      image: 'assets/clock.png',
      english: 'Clock',
      options: ['Gab-i', 'Adlaw', 'Ulan', 'Orasan'],
      correct: 'Orasan',
    ),
    FlashCard(
      image: 'assets/food.png',
      english: 'Food',
      options: ['Gab-i', 'Pagkaon', 'Adlaw', 'Ulan'],
      correct: 'Pagkaon',
    ),
  ];

  late List<FlashCard> flashCards;

  @override
  void initState() {
    super.initState();
    flashCards = _pickRandomFlashCards(allFlashCards, 10);
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _score = 0;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  List<FlashCard> _pickRandomFlashCards(List<FlashCard> source, int count) {
    final random = Random();
    final copy = List<FlashCard>.from(source);
    copy.shuffle(random);
    return copy.take(count).toList();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedIndex = index;
      answered = true;
      isCorrect = flashCards[currentIndex].options[index] ==
          flashCards[currentIndex].correct;
      if (isCorrect) {
        _score++;
      }

      _results.add(ResultDetails(
        phrase: flashCards[currentIndex].english,
        userAnswer: flashCards[currentIndex].options[index],
        correctAnswer: flashCards[currentIndex].correct,
        isCorrect: isCorrect,
      ));
    });
  }

  void nextCard() {
    setState(() {
      if (currentIndex < flashCards.length - 1) {
        currentIndex++;
        selectedIndex = null;
        answered = false;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EscorePage(
              score: _score,
              total: flashCards.length,
              results: _results,
            ),
          ),
        );
      }
    });
  }

  Widget _buildOptionButton(int index, FlashCard card) {
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
      height: 50,
      child: OutlinedButton(
        onPressed: answered ? null : () => checkAnswer(index),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          option,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = flashCards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Easy Level',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildOptionButton(0, card)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildOptionButton(1, card)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildOptionButton(2, card)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildOptionButton(3, card)),
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
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
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
