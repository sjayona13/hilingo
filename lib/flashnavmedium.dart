import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class FlashNavMedium extends StatefulWidget {
  const FlashNavMedium({Key? key}) : super(key: key);

  @override
  State<FlashNavMedium> createState() => _FlashNavMediumState();
}

class _FlashNavMediumState extends State<FlashNavMedium> {
  late ConfettiController _confettiController;
  
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;

  final List<FlashCard> flashCards = [
    FlashCard(
      image: 'assets/cloud.png',
      english: 'Cloud',
      options: ['Panganod', 'Adlaw', 'Uwan', 'Gab-i'],
      correct: 'Panganod',
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
      options: ['Langgam', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Langgam',
    ),
    FlashCard(
      image: 'assets/dog.png',
      english: 'Dog',
      options: ['Iro', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Iro',
    ),
    FlashCard(
      image: 'assets/cat.png',
      english: 'Cat',
      options: ['Iro', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Iro',
    ),
    FlashCard(
      image: 'assets/house.png',
      english: 'House',
      options: ['Balay', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Balay',
    ),
    FlashCard(
      image: 'assets/car.png',
      english: 'Car',
      options: ['Sakyanan', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Sakyanan',
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
      options: ['Telepono', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Telepono',
    ),
    FlashCard(
      image: 'assets/clock.png',
      english: 'Clock',
      options: ['Orasan', 'Gab-i', 'Adlaw', 'Ulan'],
      correct: 'Orasan',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _score = 0;
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
        showCongratulationsDialog();
      }
    });
  }

  void showCongratulationsDialog() {
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
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);
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
                    'Your Score: $_score / ${flashCards.length}',
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
          'Medium Level',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Center(
                child: Text(
                  '${currentIndex + 1} / ${flashCards.length}',
                  style: const TextStyle(color: Color(0xFF878282), fontSize: 16),
                ),
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
              'Choose the correct match for each flashcard within 10 seconds',
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
