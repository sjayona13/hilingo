import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ResultDetails {
  final String phrase;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final String? difficulty; // Added difficulty field

  ResultDetails({
    required this.phrase,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    this.difficulty,
  });
}

class ResultViewer extends StatefulWidget {
  final List<ResultDetails> results;
  final VoidCallback? onContinue;
  final double? heightFactor;

  const ResultViewer({
    Key? key,
    required this.results,
    this.onContinue,
    this.heightFactor,
  }) : super(key: key);

  @override
  State<ResultViewer> createState() => _ResultViewerState();
}

class _ResultViewerState extends State<ResultViewer> {
  @override
  Widget build(BuildContext context) {
    // Only show buttons if there are actual results to show
    if (widget.results.isEmpty) {
      if (widget.onContinue != null) {
        return SizedBox(
          width: 140,
          height: 50,
          child: ElevatedButton(
            onPressed: widget.onContinue,
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
                fontFamily: 'Kumbh',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              _showResultModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A7BE6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'See Result',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Kumbh',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        if (widget.onContinue != null)
          SizedBox(
            width: 140,
            height: 50,
            child: ElevatedButton(
              onPressed: widget.onContinue,
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
                  fontFamily: 'Kumbh',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showResultModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white, // White theme for games
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Game Results",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87, // Black text
                                fontFamily: 'Kumbh',
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ResultList(results: widget.results),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale:
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }
}

class ResultList extends StatelessWidget {
  final List<ResultDetails> results;

  const ResultList({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildResultList(),
    );
  }

  List<Widget> _buildResultList() {
    List<Widget> listItems = [];
    String? currentDifficulty;

    for (var result in results) {
      // Check if difficulty changed and add header
      if (result.difficulty != null && result.difficulty != currentDifficulty) {
        currentDifficulty = result.difficulty;
        listItems.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF2196F3)),
              ),
              child: Text(
                currentDifficulty!,
                style: const TextStyle(
                  fontFamily: 'Kumbh',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
            ),
          ),
        );
      }

      listItems.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.phrase,
                style: const TextStyle(
                  fontFamily: 'Kumbh',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Answer: ",
                    style: TextStyle(
                        fontFamily: 'Kumbh', fontSize: 14, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      result.userAnswer,
                      style: TextStyle(
                        fontFamily: 'Kumbh',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: result.isCorrect ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              if (!result.isCorrect) ...[
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Correct Answer: ",
                      style: TextStyle(
                          fontFamily: 'Kumbh',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    Expanded(
                      child: Text(
                        result.correctAnswer,
                        style: const TextStyle(
                          fontFamily: 'Kumbh',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }
    return listItems;
  }
}
