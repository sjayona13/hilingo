import 'package:flutter/material.dart';
import 'flashnaveasy.dart';
import 'flashnavmedium.dart';
import 'flashnavhard.dart';
import 'homepage.dart'; // ⬅️ Import where HilingoApp() is defined

class FlashcardsPages extends StatelessWidget {
  const FlashcardsPages({super.key});

  final List<String> flashcardLabels = const [
    'Easy',
    'Medium',
    'Hard',
  ];

  final List<String> flashcardImages = const [
    'assets/easy.png',
    'assets/intermediate.png',
    'assets/hard.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flashcard Levels',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // ⬅️ Go back directly to HilingoApp()
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HilingoApp()),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: flashcardLabels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FlashNavEasy()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FlashNavMedium()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FlashNavHard()),
                    );
                    break;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF2A7BE6)),
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
                      flashcardImages[index],
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      flashcardLabels[index],
                      textAlign: TextAlign.center,
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
