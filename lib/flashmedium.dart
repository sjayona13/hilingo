import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'escore.dart';
import 'result_feature.dart';

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
  List<ResultDetails> _results = [];

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
      options: ['Hilom', 'Tingog', 'Gahod', 'Tingog sang Ido'],
      correct: 'Gahod',
    ),
    FlashCard(
      image: 'assets/fire.png',
      english: 'Fire',
      options: ['Tubig', 'Kalayo', 'Hangin', 'Bato'],
      correct: 'Kalayo',
    ),
    FlashCard(
      image: 'assets/water-drop.png',
      english: 'Water',
      options: ['Tubig', 'Adlaw', 'Bituon', 'Balay'],
      correct: 'Tubig',
    ),
    FlashCard(
      image: 'assets/tree.png',
      english: 'Tree',
      options: ['Puno', 'Sanga', 'Dahon', 'Bulak'],
      correct: 'Puno',
    ),
    FlashCard(
      image: 'assets/flower.png',
      english: 'Flower',
      options: ['Bulak', 'Buyog', 'Hilamon', 'Saging'],
      correct: 'Bulak',
    ),
    FlashCard(
      image: 'assets/mountain.png',
      english: 'Mountain',
      options: ['Suba', 'Balay', 'Bukid', 'Tinapay'],
      correct: 'Bukid',
    ),
    FlashCard(
      image: 'assets/river.png',
      english: 'River',
      options: ['Suba', 'Bay-Bay', 'Kamote', 'Ulan'],
      correct: 'Suba',
    ),
    FlashCard(
      image: 'assets/bird.png',
      english: 'Bird',
      options: ['Manok', 'PisPis', 'Dahon', 'Ulan'],
      correct: 'PisPis',
    ),
    FlashCard(
      image: 'assets/candle.png',
      english: 'Candle',
      options: ['Kandila', 'Kalayo', 'Adlaw', 'Lampara'],
      correct: 'Kandila',
    ),
    FlashCard(
      image: 'assets/mirror.png',
      english: 'Mirror',
      options: ['Esmirra', 'Espiyo', 'Bintana', 'Pintuan'],
      correct: 'Espiyo',
    ),
    FlashCard(
      image: 'assets/bridge.png',
      english: 'Bridge',
      options: ['Dal-an', 'Suba', 'Taytay', 'Balay'],
      correct: 'Taytay',
    ),
    FlashCard(
      image: 'assets/boat.png',
      english: 'Boat',
      options: ['Baruto', 'Sakayan', 'Barko', 'Salakyan'],
      correct: 'Baruto',
    ),
    FlashCard(
      image: 'assets/road.png',
      english: 'Road',
      options: ['Dalan', 'Balay', 'Suba', 'Bukid'],
      correct: 'Dalan',
    ),
    FlashCard(
      image: 'assets/leaf.png',
      english: 'Leaf',
      options: ['Dahon', 'Bulak', 'Sanga', 'Hilamon'],
      correct: 'Dahon',
    ),
    FlashCard(
      image: 'assets/storm.png',
      english: 'Storm',
      options: ['Ulan', 'Dagu-ob', 'Bagyo', 'Hangin'],
      correct: 'Bagyo',
    ),
    FlashCard(
      image: 'assets/lightning.png',
      english: 'Lightning',
      options: ['Kilat', 'Bagyo', 'Dagu-ob', 'Kalayo'],
      correct: 'Kilat',
    ),
    FlashCard(
      image: 'assets/rainbow.png',
      english: 'Rainbow',
      options: ['Bituon', 'Balangaw', 'Panganod', 'Adlaw'],
      correct: 'Balangaw',
    ),
    FlashCard(
      image: 'assets/earth.png',
      english: 'Earth',
      options: ['Kalibutan', 'Langit', 'Tubig', 'Hangin'],
      correct: 'Kalibutan',
    ),
    FlashCard(
      image: 'assets/sky.png',
      english: 'Sky',
      options: ['Langit', 'Panganod', 'Adlaw', 'Bulan'],
      correct: 'Langit',
    ),
    FlashCard(
      image: 'assets/beach.png',
      english: 'Beach',
      options: ['Baybay', 'Suba', 'Bukid', 'Balay'],
      correct: 'Baybay',
    ),
    FlashCard(
      image: 'assets/stone.png',
      english: 'Stone',
      options: ['Balas', 'Bato', 'Duta', 'Suga'],
      correct: 'Bato',
    ),
    FlashCard(
      image: 'assets/smoke.png',
      english: 'Smoke',
      options: ['Asu', 'Kalayo', 'Hangin', 'Tubig'],
      correct: 'Asu',
    ),
    FlashCard(
      image: 'assets/rope.png',
      english: 'Rope',
      options: ['Lansang', 'Bato', 'Pisi', 'Kawayan'],
      correct: 'Pisi',
    ),
    FlashCard(
      image: 'assets/basket.png',
      english: 'Basket',
      options: ['Balaon', 'Bakol', 'Balde', 'Sako'],
      correct: 'Bakol',
    ),
    FlashCard(
      image: 'assets/hammer.png',
      english: 'Hammer',
      options: ['Martilyo', 'Lagari', 'Pisi', 'Bato'],
      correct: 'Martilyo',
    ),
    FlashCard(
      image: 'assets/fan2.png',
      english: 'Fan',
      options: ['Hangin', 'Suga', 'Pamaypay', 'Lampara'],
      correct: 'Pamaypay',
    ),
    FlashCard(
      image: 'assets/milk.png',
      english: 'Milk',
      options: ['Tubig', 'Gatas', 'Pagkaon', 'Kalamay'],
      correct: 'Gatas',
    ),
    FlashCard(
      image: 'assets/shirt.png',
      english: 'Shirt',
      options: ['Sando', 'Pantalon', 'Bayo', 'Bisti'],
      correct: 'Bayo',
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
        flashCards[currentIndex].options.shuffle();
      } else {
        _confettiController.play();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => EscorePage(
                  score: _score,
                  total: flashCards.length,
                  results: _results,
                ),
              ),
            );
          }
        });
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
                  style:
                      const TextStyle(color: Color(0xFF878282), fontSize: 16),
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
                  Image.asset(card.image,
                      height: 100, width: 100, fit: BoxFit.contain),
                  const SizedBox(height: 16),
                  Text(
                    card.english,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
