import 'package:flutter/material.dart';
import 'qeasy.dart';     // ✅ Easy
import 'qintermediate.dart';  // ✅ Intermediate
import 'qhard.dart';    // ✅ Hard
import 'assessment_intro.dart';
import 'homepage.dart'; // ✅ Import your homepage (HilingoApp)

class Quizzess extends StatelessWidget {
  const Quizzess({super.key});

  final List<String> difficultyLabels = const [
    'Easy',
    'Intermediate',
    'Hard',
    'Assessment'
  ];

  final List<String> difficultyImages = const [
    'assets/easy.png',
    'assets/intermediate.png',
    'assets/hard.png',
    'assets/assessments.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // ✅ Always go back to Homepage
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HilingoApp()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: difficultyLabels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  // ✅ Easy → Qeasy.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Qeasy()),
                  );
                } else if (index == 1) {
                  // ✅ Intermediate → Qintermediate.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Qintermediate()),
                  );
                } else if (index == 2) {
                  // ✅ Hard → Qhard.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Qhard()),
                  );
                } else if (index == 3) {
                  // ✅ Assessment → AssessmentIntro
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AssessmentIntro(timed: false)),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF2A7BE6),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      difficultyImages[index],
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      difficultyLabels[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
