import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class FlashcardGame extends StatefulWidget {
  const FlashcardGame({Key? key}) : super(key: key);

  @override
  _FlashcardGameState createState() => _FlashcardGameState();
}

class Flashcard {
  final String englishWord;
  final String correctAnswer;
  final List<String> options;
  final String imagePath;

  Flashcard({
    required this.englishWord,
    required this.correctAnswer,
    required this.options,
    required this.imagePath,
  });
}

class _FlashcardGameState extends State<FlashcardGame> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;
  int _timeLeft = 10;
  Timer? _timer;
  bool _isCorrect = false;

  late List<Flashcard> _flashcards;

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
    _startTimer();
  }

  void _loadFlashcards() {
    _flashcards = [
    
     
     
    
      Flashcard(
        englishWord: 'Water',
        correctAnswer: 'Tubig',
        options: ['Tubig', 'Hangin', 'Lupa', 'Bato'],
        imagePath: 'assets/water.png',
      ),
    ];
    _flashcards.shuffle();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        if (!_answered) {
          _handleTimeout();
        }
      }
    });
  }

  void _handleTimeout() {
    setState(() {
      _answered = true;
      _isCorrect = false;
    });
  }

  void _selectAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      _timer?.cancel();

      final currentFlashcard = _flashcards[_currentIndex];
      final selectedAnswer = currentFlashcard.options[index];
      
      if (selectedAnswer == currentFlashcard.correctAnswer) {
        _score++;
        _isCorrect = true;
      } else {
        _isCorrect = false;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
        _timeLeft = 10;
        _isCorrect = false;
      });
      _startTimer();
    } else {
      _showGameCompletedDialog();
    }
  }

  void _showGameCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Completed!'),
        content: Text('Your final score: $_score / ${_flashcards.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFlashcard = _flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Time: $_timeLeft',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Choose the correct match for each flashcard within 10 seconds',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: _buildFlashcardImage(currentFlashcard.englishWord),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          currentFlashcard.englishWord,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                itemCount: currentFlashcard.options.length,
                itemBuilder: (context, index) {
                  final option = currentFlashcard.options[index];
                  final isSelected = _selectedIndex == index;
                  final isCorrect = option == currentFlashcard.correctAnswer;
                  
                  Color borderColor = Colors.grey.shade300;
                  Color textColor = Colors.grey;
                  
                  if (_answered) {
                    if (isCorrect) {
                      borderColor = Colors.green;
                      textColor = Colors.green;
                    } else if (isSelected) {
                      borderColor = Colors.red;
                      textColor = Colors.red;
                    }
                  }
                  
                  return OutlinedButton(
                    onPressed: _answered ? null : () => _selectAnswer(index),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            
            if (_answered)
              Text(
                _isCorrect ? 'Correct!' : 'Try again',
                style: TextStyle(
                  color: _isCorrect ? Colors.green : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            
            const SizedBox(height: 20),
            
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _answered ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A7BE6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashcardImage(String word) {
    
    switch (word.toLowerCase()) {
      case 'sun':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.yellow,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.wb_sunny,
            color: Colors.orange,
            size: 50,
          ),
        );
      case 'rain':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.water_drop,
            color: Colors.blue,
            size: 50,
          ),
        );
      case 'cloud':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.cloud,
            color: Colors.grey,
            size: 50,
          ),
        );
      case 'night':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.nightlight_round,
            color: Colors.yellow,
            size: 50,
          ),
        );
      case 'water':
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.water,
            color: Colors.blue,
            size: 50,
          ),
        );
      default:
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.image,
            color: Colors.grey,
            size: 50,
          ),
        );
    }
  }
}

