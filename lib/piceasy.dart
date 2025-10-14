import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'pscore.dart'; // ⬅️ Use your PscorePage here

class PicEasy extends StatefulWidget {
  const PicEasy({Key? key}) : super(key: key);

  @override
  State<PicEasy> createState() => _PicEasyState();
}

class _PicEasyState extends State<PicEasy> {
  late ConfettiController _confettiController;
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  bool isCorrect = false;
  int _score = 0;

  late List<PicQuestion> questions;

final List<PicQuestion> allQuestions = [

  PicQuestion(
    hiligaynon: 'Bulan',
    options: [
      PicOption(label: 'Moon', image: 'assets/moon.png', isCorrect: true),
      PicOption(label: 'Sun', image: 'assets/sun.png'),
      PicOption(label: 'Star', image: 'assets/star.png'),
      PicOption(label: 'Cloud', image: 'assets/cloud.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Ulan',
    options: [
      PicOption(label: 'Thunder', image: 'assets/thunder.png'),
      PicOption(label: 'Cloud', image: 'assets/cloud.png'),
      PicOption(label: 'Rain', image: 'assets/rain.png', isCorrect: true),
      PicOption(label: 'Wind', image: 'assets/wind.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Dagu-ob',
    options: [
      PicOption(label: 'Thunder', image: 'assets/thunder.png', isCorrect: true),
      PicOption(label: 'Rain', image: 'assets/rain.png'),
      PicOption(label: 'Cloud', image: 'assets/cloud.png'),
      PicOption(label: 'Star', image: 'assets/star.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Bituon',
    options: [
      PicOption(label: 'Sun', image: 'assets/sun.png'),
      PicOption(label: 'Moon', image: 'assets/moon.png'),
      PicOption(label: 'Star', image: 'assets/star.png', isCorrect: true),
      PicOption(label: 'Cloud', image: 'assets/cloud.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Hangin',
    options: [
      PicOption(label: 'Rain', image: 'assets/rain.png'),
      PicOption(label: 'Sun', image: 'assets/sun.png'),
      PicOption(label: 'Wind', image: 'assets/wind.png', isCorrect: true),
      PicOption(label: 'Thunder', image: 'assets/thunder.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Ido',
    options: [
      PicOption(label: 'Cat', image: 'assets/cat.png'),
      PicOption(label: 'Bird', image: 'assets/bird.png'),
      PicOption(label: 'Fish', image: 'assets/fish.png'),
      PicOption(label: 'Dog', image: 'assets/dog.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Kuring',
    options: [
      PicOption(label: 'Cat', image: 'assets/cat.png', isCorrect: true),
      PicOption(label: 'Dog', image: 'assets/dog.png'),
      PicOption(label: 'Bird', image: 'assets/bird.png'),
      PicOption(label: 'Fish', image: 'assets/fish.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Pispis',
    options: [
      PicOption(label: 'Dog', image: 'assets/dog.png'),
      PicOption(label: 'Fish', image: 'assets/fish.png'),
      PicOption(label: 'Cat', image: 'assets/cat.png'),
      PicOption(label: 'Bird', image: 'assets/bird.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Isda',
    options: [
      PicOption(label: 'Dog', image: 'assets/dog.png'),
      PicOption(label: 'Cat', image: 'assets/cat.png'),
      PicOption(label: 'Fish', image: 'assets/fish.png', isCorrect: true),
      PicOption(label: 'Bird', image: 'assets/bird.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Bulak',
    options: [
      PicOption(label: 'Tree', image: 'assets/tree.png'),
      PicOption(label: 'Grass', image: 'assets/grass.png'),
      PicOption(label: 'Leaf', image: 'assets/leaf.png'),
      PicOption(label: 'Flower', image: 'assets/flower.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Dahon',
    options: [
      PicOption(label: 'Tree', image: 'assets/tree.png'),
      PicOption(label: 'Leaf', image: 'assets/leaf.png', isCorrect: true),
      PicOption(label: 'Flower', image: 'assets/flower.png'),
      PicOption(label: 'Grass', image: 'assets/grass.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Puno',
    options: [
      PicOption(label: 'Flower', image: 'assets/flower.png'),
      PicOption(label: 'Leaf', image: 'assets/leaf.png'),
      PicOption(label: 'Tree', image: 'assets/tree.png', isCorrect: true),
      PicOption(label: 'Grass', image: 'assets/grass.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Hilamon',
    options: [
      PicOption(label: 'Grass', image: 'assets/grass.png', isCorrect: true),
      PicOption(label: 'Tree', image: 'assets/tree.png'),
      PicOption(label: 'Flower', image: 'assets/flower.png'),
      PicOption(label: 'Leaf', image: 'assets/leaf.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Salakyan',
    options: [
      PicOption(label: 'House', image: 'assets/house.png'),
      PicOption(label: 'Phone', image: 'assets/phone.png'),
      PicOption(label: 'Car', image: 'assets/car.png', isCorrect: true),
      PicOption(label: 'Clock', image: 'assets/clock.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Balay',
    options: [
      PicOption(label: 'Car', image: 'assets/car.png'),
      PicOption(label: 'Chair', image: 'assets/chair.png'),
      PicOption(label: 'Table', image: 'assets/table.png'),
      PicOption(label: 'House', image: 'assets/house.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Lamesa',
    options: [
      PicOption(label: 'Chair', image: 'assets/chair.png'),
      PicOption(label: 'Table', image: 'assets/table.png', isCorrect: true),
      PicOption(label: 'Clock', image: 'assets/clock.png'),
      PicOption(label: 'Phone', image: 'assets/phone.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Pulongkoan',
    options: [
      PicOption(label: 'Chair', image: 'assets/chair.png', isCorrect: true),
      PicOption(label: 'Table', image: 'assets/table.png'),
      PicOption(label: 'House', image: 'assets/house.png'),
      PicOption(label: 'Car', image: 'assets/car.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Relo',
    options: [
      PicOption(label: 'Watch', image: 'assets/watch.png', isCorrect: true),
      PicOption(label: 'Phone', image: 'assets/phone.png'),
      PicOption(label: 'Car', image: 'assets/car.png'),
      PicOption(label: 'Tree', image: 'assets/tree.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Telepono',
    options: [
      PicOption(label: 'Clock', image: 'assets/clock.png'),
      PicOption(label: 'Car', image: 'assets/car.png'),
      PicOption(label: 'Phone', image: 'assets/phone.png', isCorrect: true),
      PicOption(label: 'Chair', image: 'assets/chair.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Libro',
    options: [
      PicOption(label: 'Bag', image: 'assets/bag.png'),
      PicOption(label: 'Pen', image: 'assets/pen.png'),
      PicOption(label: 'Paper', image: 'assets/paper.png'),
      PicOption(label: 'Book', image: 'assets/book.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Bolpen',
    options: [
      PicOption(label: 'Book', image: 'assets/book.png'),
      PicOption(label: 'Pen', image: 'assets/pen.png', isCorrect: true),
      PicOption(label: 'Bag', image: 'assets/bag.png'),
      PicOption(label: 'Paper', image: 'assets/paper.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Tubig',
    options: [
      PicOption(label: 'Water', image: 'assets/water.png', isCorrect: true),
      PicOption(label: 'Juice', image: 'assets/juice.png'),
      PicOption(label: 'Milk', image: 'assets/milk.png'),
      PicOption(label: 'Coffee', image: 'assets/coffee.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Kape',
    options: [
      PicOption(label: 'Coffee', image: 'assets/coffee.png', isCorrect: true),
      PicOption(label: 'Milk', image: 'assets/milk.png'),
      PicOption(label: 'Water', image: 'assets/water.png'),
      PicOption(label: 'Juice', image: 'assets/juice.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Gatas',
    options: [
      PicOption(label: 'Water', image: 'assets/water.png'),
      PicOption(label: 'Juice', image: 'assets/juice.png'),
      PicOption(label: 'Coffee', image: 'assets/coffee.png'),
      PicOption(label: 'Milk', image: 'assets/milk.png', isCorrect: true),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Kalan-on',
    options: [
      PicOption(label: 'Drink', image: 'assets/water.png'),
      PicOption(label: 'Food', image: 'assets/food1.png', isCorrect: true),
      PicOption(label: 'Book', image: 'assets/book.png'),
      PicOption(label: 'Car', image: 'assets/car.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Saging',
    options: [
      PicOption(label: 'Banana', image: 'assets/banana.png', isCorrect: true),
      PicOption(label: 'Apple', image: 'assets/apple.png'),
      PicOption(label: 'Mango', image: 'assets/mango.png'),
      PicOption(label: 'Grapes', image: 'assets/grape.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Mansanas',
    options: [
      PicOption(label: 'Apple', image: 'assets/apple.png', isCorrect: true),
      PicOption(label: 'Banana', image: 'assets/banana.png'),
      PicOption(label: 'Mango', image: 'assets/mango.png'),
      PicOption(label: 'Grapes', image: 'assets/grape.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Paho',
    options: [
      PicOption(label: 'Mango', image: 'assets/mango.png', isCorrect: true),
      PicOption(label: 'Banana', image: 'assets/banana.png'),
      PicOption(label: 'Apple', image: 'assets/apple.png'),
      PicOption(label: 'Grapes', image: 'assets/grape.png'),
    ],
  ),
  PicQuestion(
    hiligaynon: 'Ubas',
    options: [
      PicOption(label: 'Mango', image: 'assets/mango.png'),
      PicOption(label: 'Banana', image: 'assets/banana.png'),
      PicOption(label: 'Apple', image: 'assets/apple.png'),
      PicOption(label: 'Grapes', image: 'assets/grape.png', isCorrect: true),
    ],
  ),
];

  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _score = 0;
    questions = _pickRandomQuestions(allQuestions, 10);

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
                builder: (_) => PscorePage( // ✅ updated destination
                  score: _score,
                  total: questions.length,
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
            'Easy Level',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  '${currentIndex + 1} / ${questions.length}',
                  style: const TextStyle(color: Color(0xFF878282), fontSize: 16),
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
            Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: List.generate(question.options.length, (index) {
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

                  return SizedBox(
                    width: 140,
                    height: 160,
                    child: Stack(
                      children: [
                        OutlinedButton(
                          onPressed: answered ? null : () => checkAnswer(index),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.asset(option.image, fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 6),
                              Text(option.label, style: TextStyle(color: textColor)),
                            ],
                          ),
                        ),
                        if (answered && isSelected && isRight)
                          Positioned(
                            right: -6,
                            bottom: -6,
                            child: _buildIcon(Icons.check, Colors.green),
                          ),
                        if (answered && isSelected && !isRight)
                          Positioned(
                            right: -6,
                            bottom: -6,
                            child: _buildIcon(Icons.close, Colors.red),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            if (answered && isCorrect)
              const Center(
                child: Text(
                  'Correct!',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 16, color: Colors.white),
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
