import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_application_1/flashcards.dart';
import 'package:flutter_application_1/flashhard.dart';
import 'package:flutter_application_1/picture_learning.dart';
import 'homepage.dart';
import 'result_feature.dart';

class PscorePage extends StatefulWidget {
  final int score;
  final int total;
  final List<ResultDetails> results;

  const PscorePage({
    Key? key,
    required this.score,
    required this.total,
    this.results = const [],
  }) : super(key: key);

  @override
  State<PscorePage> createState() => _PscorePageState();
}

class _PscorePageState extends State<PscorePage>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _rabbitController;
  late Animation<double> _rabbitAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();

    _rabbitController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rabbitAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _rabbitController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _rabbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, -50),
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: const [Colors.blue, Colors.lightBlueAccent, Colors.cyan],
              numberOfParticles: 20,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _rabbitAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_rabbitAnimation.value),
                        child: child,
                      );
                    },
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: Image.asset(
                          'assets/owl.png',
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.score}/${widget.total}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A7BE6),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A7BE6),
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Great job! You have done well',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ResultViewer(
                    results: widget.results,
                    onContinue: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PictureLearningPage()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
