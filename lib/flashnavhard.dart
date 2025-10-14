import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_application_1/escore.dart'; // ✅ Change this to escore.dart

class FlashNavHard extends StatefulWidget {
  const FlashNavHard({Key? key}) : super(key: key);

  @override
  State<FlashNavHard> createState() => _FlashHardState();
}

class _FlashHardState extends State<FlashNavHard> {
  late ConfettiController _confettiController;

  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;

  late List<FlashCard> flashCards;

  final List<FlashCard> allFlashCards = [
    FlashCard(
      image: 'assets/truth.png',
      english: 'Truth',
      options: ['Kamatuoran', 'Limbong', 'Kalayo', 'Pagtuo'],
      correct: 'Kamatuoran',
    ),
    FlashCard(
      image: 'assets/freedom.png',
      english: 'Freedom',
      options: ['Pagpugong', 'Kagawasan', 'Kahadlok', 'Katarungan'],
      correct: 'Kagawasan',
    ),
    FlashCard(
      image: 'assets/courage.png',
      english: 'Courage',
      options: ['Pagpalangga', 'Pag-isog', 'Pagtuo', 'Pagpangamuyo'],
      correct: 'Pag-isog',
    ),
    FlashCard(
      image: 'assets/justice.png',
      english: 'Justice',
      options: ['Katarungan', 'Kalipay', 'Kagamo', 'Kasubo'],
      correct: 'Katarungan',
    ),
    FlashCard(
      image: 'assets/hope.png',
      english: 'Hope',
      options: ['Paglaum', 'Kahadlok', 'Pagduda', 'Kasubo'],
      correct: 'Paglaum',
    ),
    FlashCard(
      image: 'assets/faith.png',
      english: 'Faith',
      options: ['Pagpangamuyo', 'Pagtuo', 'Pagpati', 'Pagpahuway'],
      correct: 'Pagtuo',
    ),
    FlashCard(
      image: 'assets/wisdom.png',
      english: 'Wisdom',
      options: ['Kaalam', 'Katingalahan', 'Paglibog', 'Kasubo'],
      correct: 'Kaalam',
    ),
    FlashCard(
      image: 'assets/destiny.png',
      english: 'Destiny',
      options: ['Kapalaran', 'Pagpangabuhi', 'Paghandum', 'Pagpangita'],
      correct: 'Kapalaran',
    ),
    FlashCard(
      image: 'assets/dream.png',
      english: 'Dream',
      options: ['Pagtuon', 'Paghidlaw', 'Handum', 'Pagpangamuyo'],
      correct: 'Handum',
    ),
    FlashCard(
      image: 'assets/sacrifice.png',
      english: 'Sacrifice',
      options: ['Paghalad', 'Pagbato', 'Pagpangayo', 'Pagpangabuhi'],
      correct: 'Paghalad',
    ),
    FlashCard(
      image: 'assets/forgiveness.png',
      english: 'Forgiveness',
      options: ['Pagpatawad', 'Pagdumot', 'Pagtuo', 'Pagpangayo'],
      correct: 'Pagpatawad',
    ),
    FlashCard(
      image: 'assets/silence.png',
      english: 'Silence',
      options: ['Kahipos', 'Gahod', 'Tingog', 'Pagpamati'],
      correct: 'Kahipos',
    ),
    FlashCard(
      image: 'assets/peace.png',
      english: 'Peace',
      options: ['Kagamo', 'Kalinong', 'Kalisod', 'Pagbato'],
      correct: 'Kalinong',
    ),
    FlashCard(
      image: 'assets/fear.png',
      english: 'Fear',
      options: ['Kalipay', 'Pagtuo', 'Kahadlok', 'Pagpahuway'],
      correct: 'Kahadlok',
    ),
    FlashCard(
      image: 'assets/anger.png',
      english: 'Anger',
      options: ['Kainit', 'Kalinong', 'Kahadlok', 'Katarungan'],
      correct: 'Kainit',
    ),
    FlashCard(
      image: 'assets/love.png',
      english: 'Love',
      options: ['Pagpalangga', 'Kahadlok', 'Pagdumot', 'Kagamo'],
      correct: 'Pagpalangga',
    ),
    FlashCard(
      image: 'assets/gratitude.png',
      english: 'Gratitude',
      options: ['Pagtuo', 'Paghandum', 'Pagpangamuyo', 'Pagpasalamat'],
      correct: 'Pagpasalamat',
    ),
    FlashCard(
      image: 'assets/promise.png',
      english: 'Promise',
      options: ['Promiso', 'Tuman', 'Limbong', 'Paghidlaw'],
      correct: 'Promiso',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
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
      if (isCorrect) _score++;
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
        _confettiController.play();

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EscorePage( // ✅ Use EScorePage instead of ScorePage
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
            'Hard Level',
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
