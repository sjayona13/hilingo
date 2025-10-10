import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class StatsPage extends StatefulWidget {
  final int easyScore;
  final int easyTotal;
  final int mediumScore;
  final int mediumTotal;
  final int hardScore;
  final int hardTotal;

  const StatsPage({
    Key? key,
    required this.easyScore,
    required this.easyTotal,
    required this.mediumScore,
    required this.mediumTotal,
    required this.hardScore,
    required this.hardTotal,
  }) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with SingleTickerProviderStateMixin {
  int level = 1;
  double xp = 0.0;
  double xpToNextLevel = 100.0;
  double animatedXp = 0.0; // For smooth animation

  @override
  void initState() {
    super.initState();
    _loadLevelAndXp();
  }

  Future<void> _loadLevelAndXp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      level = prefs.getInt('level') ?? 1;
      xp = prefs.getDouble('xp') ?? 0.0;
      xpToNextLevel = prefs.getDouble('xpToNextLevel') ?? 100.0;
      animatedXp = xp; // Initialize animated value
    });
    _addXpFromAssessment();
  }

  Future<void> _addXpFromAssessment() async {
    double totalScore = widget.easyScore.toDouble() +
        widget.mediumScore.toDouble() +
        widget.hardScore.toDouble();
    double totalPoints = widget.easyTotal.toDouble() +
        widget.mediumTotal.toDouble() +
        widget.hardTotal.toDouble();
    double earnedXp = totalPoints > 0 ? (totalScore / totalPoints) * 50 : 0.0;

    xp += earnedXp;

    while (xp >= xpToNextLevel) {
      xp -= xpToNextLevel;
      level += 1;
      xpToNextLevel *= 1.2;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level', level);
    await prefs.setDouble('xp', xp);
    await prefs.setDouble('xpToNextLevel', xpToNextLevel);

    // Animate the XP bar and owl together
    setState(() {
      animatedXp = xp;
    });
  }

  Future<void> _resetLevelXp() async {
    xp = 0.0;
    level = 1;
    xpToNextLevel = 100.0;
    animatedXp = 0.0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('level', level);
    await prefs.setDouble('xp', xp);
    await prefs.setDouble('xpToNextLevel', xpToNextLevel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double totalScore = widget.easyScore.toDouble() +
        widget.mediumScore.toDouble() +
        widget.hardScore.toDouble();
    double totalPoints = widget.easyTotal.toDouble() +
        widget.mediumTotal.toDouble() +
        widget.hardTotal.toDouble();
    double percent = totalPoints > 0 ? (totalScore / totalPoints) * 100 : 0;
    double barWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Overall Score Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "OVERALL SCORE",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${percent.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A7BE6),
                        ),
                      ),
                      Text(
                        "${totalScore.toInt()}/${totalPoints.toInt()} Points",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Level Progress Section with Reset Button
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "LEVEL PROGRESS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _resetLevelXp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A7BE6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFEAF2FF),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    Container(
                      width: barWidth,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: (animatedXp / xpToNextLevel) * barWidth,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A7BE6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      left: (animatedXp / xpToNextLevel) * barWidth - 24,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/owl.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Level $level • ${xp.toStringAsFixed(0)}/${xpToNextLevel.toStringAsFixed(0)} XP",
                  style: const TextStyle(
                    color: Color(0xFF2A7BE6),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // Performance by Level
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PERFORMANCE BY LEVEL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLevelBox("EASY", widget.easyScore, widget.easyTotal),
                    _buildLevelBox("MEDIUM", widget.mediumScore, widget.mediumTotal),
                    _buildLevelBox("HARD", widget.hardScore, widget.hardTotal),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF2A7BE6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Great job! You have done well",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HilingoApp()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A7BE6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Back to Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelBox(String label, int score, int total) {
    double percent = total > 0 ? (score / total) * 100 : 0;
    return Container(
      width: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Text("$score/$total", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent / 100,
            minHeight: 5,
            color: const Color(0xFF2A7BE6),
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 6),
          Text("${percent.toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Color(0xFF2A7BE6),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              )),
        ],
      ),
    );
  }
}
