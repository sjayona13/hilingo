import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/score.dart';
import 'flashcards.dart'; // Import your FlashCards page
import 'score.dart'; // Import the new ScorePage

class FlashEasy extends StatefulWidget {
  const FlashEasy({Key? key}) : super(key: key);

  @override
  State<FlashEasy> createState() => _FlashEasyState();
}

class _FlashEasyState extends State<FlashEasy> {
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;

  // Full flashcard pool
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
      options: ['Gab-i', 'Bulan', 'Bituon', 'Bola'],
      correct: 'Bulan',
    ),
    FlashCard(
      image: 'assets/rain.png',
      english: 'Rain',
      options: ['Dagu-ob', 'Kilat', 'Tubig', 'Ulan'],
      correct: 'Ulan',
    ),
    FlashCard(
      image: 'assets/cloud.png',
      english: 'Cloud',
      options: ['Panganod', 'Dagu-ob', 'Gal-um', 'Kilat'],
      correct: 'Panganod',
    ),
    FlashCard(
      image: 'assets/star.png',
      english: 'Star',
      options: ['Adlaw', 'Dahon', 'Bituon', 'Ulan'],
      correct: 'Bituon',
    ),
    FlashCard(
      image: 'assets/wind.png',
      english: 'Wind',
      options: ['Subay', 'Hangin', 'Gab-i', 'Bato'],
      correct: 'Hangin',
    ),
    FlashCard(
      image: 'assets/tree.png',
      english: 'Tree',
      options: ['Sanga', 'Tinapay', 'Puno', 'Balay'],
      correct: 'Puno',
    ),
    FlashCard(
      image: 'assets/flower.png',
      english: 'Flower',
      options: ['Bulak', 'Buyog', 'Hilamon', 'Saging'],
      correct: 'Bulak',
    ),
    FlashCard(
      image: 'assets/river.png',
      english: 'River',
      options: ['Baras', 'Bay-Bay', 'Kamote', 'Suba'],
      correct: 'Suba',
    ),
    FlashCard(
      image: 'assets/mountain.png',
      english: 'Mountain',
      options: ['Bukid', 'Saging', 'Tinapay', 'Balay'],
      correct: 'Bukid',
    ),
    FlashCard(
      image: 'assets/fish.png',
      english: 'Fish',
      options: ['Bato', 'Ipot-Ipot', 'Isda', 'Ulan'],
      correct: 'Isda',
    ),
    FlashCard(
      image: 'assets/bird.png',
      english: 'Bird',
      options: ['Dahon', 'Manok', 'Hangin', 'PisPis'],
      correct: 'PisPis',
    ),
    FlashCard(
      image: 'assets/dog.png',
      english: 'Dog',
      options: ['Kuring', 'Kamote', 'Iro', 'Ulan'],
      correct: 'Iro',
    ),
    FlashCard(
      image: 'assets/cat.png',
      english: 'Cat',
      options: ['Iro', 'Man-og', 'Kuring', 'Tuko'],
      correct: 'Kuring',
    ),
    FlashCard(
      image: 'assets/house.png',
      english: 'House',
      options: ['Bangrus', 'Gab-i', 'Suba', 'Balay'],
      correct: 'Balay',
    ),
    FlashCard(
      image: 'assets/car.png',
      english: 'Car',
      options: ['Salakyan', 'Sikad', 'Iro', 'Ulan'],
      correct: 'Salakyan',
    ),
    FlashCard(
      image: 'assets/book.png',
      english: 'Book',
      options: ['Libro', 'Buyog', 'PisPis', 'Dahon'],
      correct: 'Libro',
    ),
    FlashCard(
      image: 'assets/phone.png',
      english: 'Telephone',
      options: ['Telepono', 'Bukid', 'kuring', 'Bangros'],
      correct: 'Telepono',
    ),
    FlashCard(
      image: 'assets/clock.png',
      english: 'Clock',
      options: ['Orasan', 'Panganod', 'Iro', 'Kalamay'],
      correct: 'Orasan',
    ),
    FlashCard(
      image: 'assets/food1.png',
      english: 'Food',
      options: ['Pagkaon', 'Subay', 'Tinapay', 'Adlaw'],
      correct: 'Pagkaon',
    ),
  ];

  late List<FlashCard> flashCards;

  @override
  void initState() {
    super.initState();
    flashCards = _pickRandomFlashCards(allFlashCards, 10);
    _score = 0;
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
      isCorrect = flashCards[currentIndex].options[index] == flashCards[currentIndex].correct;
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
      } else {
        // Navigate to ScorePage when finished
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScorePage(
              score: _score,
              total: flashCards.length,
            ),
          ),
        );
      }
    });
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
          onPressed: () {
            Navigator.pop(context); // Go back to previous page
          },
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
                Image.asset(card.image, height: 140, width: 140, fit: BoxFit.contain),
                const SizedBox(height: 16),
                Text(
                  card.english,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(option, style: TextStyle(color: textColor)),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          if (answered && !isCorrect)
            const Text(
              'Try again',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answered ? nextCard : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A7BE6),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
