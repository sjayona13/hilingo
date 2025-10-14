import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'quizzes.dart'; // Make sure this points to your quizzes.dart file

class Qscore extends StatefulWidget {
  final int score;
  final int total;

  const Qscore({Key? key, required this.score, required this.total}) : super(key: key);

  @override
  State<Qscore> createState() => _QscoreState();
}

class _QscoreState extends State<Qscore> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _rabbitController;
  late Animation<double> _rabbitAnimation;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
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
          // Confetti slightly higher while still centered
          Transform.translate(
            offset: const Offset(0, -50), // move up
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: const [Colors.blue, Colors.lightBlueAccent, Colors.cyan],
              numberOfParticles: 20,
            ),
          ),

          // Owl and score content
          Center(
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
                  child: Container(
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

                // Continue Button → Goes to QuizzesPage()
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const QuizzesPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A7BE6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
