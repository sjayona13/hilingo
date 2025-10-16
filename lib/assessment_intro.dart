import 'package:flutter/material.dart';
import 'package:flutter_application_1/timed_quiz.dart' as timed;

class AssessmentIntro extends StatefulWidget {
  final bool timed;
  const AssessmentIntro({super.key, required this.timed});

  @override
  State<AssessmentIntro> createState() => _AssessmentIntroState();
}

class _AssessmentIntroState extends State<AssessmentIntro>
    with SingleTickerProviderStateMixin {
  bool _acknowledged = false;

  late AnimationController _bgController;
  late Animation<double> _bgAnimation;

  @override
  void initState() {
    super.initState();
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..repeat(reverse: true);
    _bgAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _bgController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  void _openInstructions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.lightBlueAccent, width: 2)),
          child: StatefulBuilder(
            builder: (context, setLocalState) {
              return Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.lightBlueAccent, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlueAccent.withOpacity(0.6),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Text(
                        'HILIGAYNON CHALLENGE',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                            letterSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(height: 20),

                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade800.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        '• Start with Easy Mode (25 tasks, 10s each).\n\n'
                        '• Complete it to unlock Intermediate (15 tasks, 8s each).\n\n'
                        '• Hard Mode has 10 tasks, 6s each.\n\n'
                        '• Your performance will be summarized at the end.\n\n'
                        'Prepare yourself and focus on your knowledge!',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    
                    Row(
                      children: [
                        Checkbox(
                          fillColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                          value: _acknowledged,
                          onChanged: (val) {
                            setLocalState(() => _acknowledged = val ?? false);
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'I understand the instructions.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    
                    ElevatedButton(
                      onPressed: _acknowledged
                          ? () {
                              Navigator.of(context).pop();
                              _startAssessment();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 10,
                        shadowColor: Colors.lightBlueAccent.withOpacity(0.7),
                      ),
                      child: const Text(
                        'START QUIZ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _startAssessment() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            timed.TimedQuizPage(difficulty: timed.QuizDifficulty.easy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Assessment',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent,
              fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueGrey.shade900.withOpacity(0.95),
                      Colors.black87.withOpacity(0.85),
                      Colors.blue.shade900.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      _bgAnimation.value,
                      (_bgAnimation.value + 0.3).clamp(0.0, 1.0),
                      (_bgAnimation.value + 0.6).clamp(0.0, 1.0),
                    ],
                  ),
                ),
              );
            },
          ),
          
          Positioned(
            top: 80,
            left: 20,
            child: Icon(Icons.star,
                size: 40, color: Colors.lightBlueAccent.withOpacity(0.2)),
          ),
          Positioned(
            bottom: 120,
            right: 30,
            child: Icon(Icons.star,
                size: 50, color: Colors.white.withOpacity(0.15)),
          ),
          Positioned(
            top: 150,
            right: 50,
            child: Icon(Icons.star,
                size: 30, color: Colors.blue.shade300.withOpacity(0.2)),
          ),
          Positioned(
            bottom: 200,
            left: 50,
            child: Icon(Icons.star,
                size: 25, color: Colors.grey.shade400.withOpacity(0.15)),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Ass.png',
                    width: 160,
                    height: 160,
                    color: Colors.lightBlueAccent,  
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your knowledge, your challenge!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _openInstructions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      shadowColor: Colors.black87,
                    ),
                    child: const Text(
                      'Begin Assessment',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
