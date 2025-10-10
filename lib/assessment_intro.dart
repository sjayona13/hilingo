import 'package:flutter/material.dart';
import 'timed_quiz.dart' as timed;

class AssessmentIntro extends StatefulWidget {
  final bool timed;
  const AssessmentIntro({super.key, required this.timed});

  @override
  State<AssessmentIntro> createState() => _AssessmentIntroState();
}

class _AssessmentIntroState extends State<AssessmentIntro> {
  bool _acknowledged = false;

  // Show instructions dialog
  void _openInstructions() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          content: StatefulBuilder(
            builder: (context, setLocalState) {
              return SizedBox(
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to the Hiligaynon Challenge!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Start with Easy Mode, which includes 25 challenging tasks.\n\n'
  'You will have 10 seconds to answer each question in Easy Mode.\n\n'
  'Complete Easy Mode to unlock Intermediate Mode, which has 15 questions with 8 seconds each.\n\n'
  'After that, move on to Hard Mode with 10 questions and 6 seconds per question.\n\n'
  "Once you finish all levels, you will see how much you have learned. Let’s go!",
                      style: TextStyle(height: 1.3),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: _acknowledged,
                          onChanged: (val) {
                            setLocalState(() => _acknowledged = val ?? false);
                          },
                        ),
                        const Expanded(child: Text('Okay, I understand.')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _acknowledged
                            ? () {
                                Navigator.of(context).pop(); // close instructions
                                _startAssessment();          // go directly to quiz
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2A7BE6),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('CONTINUE'),
                      ),
                    ),
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
    if (!widget.timed) return;

    // Directly go to TimedQuizPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => timed.TimedQuizPage(
          difficulty: timed.QuizDifficulty.easy,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Assessment',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: 40, right: 24, child: Icon(Icons.cloud, size: 80, color: Colors.blue.shade50)),
          Positioned(top: 120, left: 16, child: Icon(Icons.cloud, size: 60, color: Colors.blue.shade50)),
          Positioned(bottom: 140, right: 32, child: Icon(Icons.cloud, size: 70, color: Colors.blue.shade50)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/iconh.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 12),
              const Text(
                "You've learned it, now earn it!",
                style: TextStyle(color: Color(0xFF878282)),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _openInstructions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A7BE6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    child: const Text('START'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
