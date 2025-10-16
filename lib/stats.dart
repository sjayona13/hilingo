import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'dart:async';

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

class _StatsPageState extends State<StatsPage> with TickerProviderStateMixin {
  int level = 1;
  double xp = 0.0;
  double xpToNextLevel = 100.0;
  double animatedXp = 0.0;

 
  late AnimationController _gradientController;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;
  late Animation<Color?> _color3;

  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _loadLevelAndXp();
    _initGradientAnimation();
    _initPulseAnimation();
  }

  void _initGradientAnimation() {
    _gradientController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _color1 = ColorTween(begin: const Color(0xFF0D47A1), end: const Color(0xFF1565C0))
        .animate(_gradientController);
    _color2 = ColorTween(begin: const Color(0xFF1976D2), end: const Color(0xFF1E88E5))
        .animate(_gradientController);
    _color3 = ColorTween(begin: const Color(0xFF0B3D91), end: const Color(0xFF0D47A1))
        .animate(_gradientController);
  }

  void _initPulseAnimation() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadLevelAndXp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      level = prefs.getInt('level') ?? 1;
      xp = prefs.getDouble('xp') ?? 0.0;
      xpToNextLevel = prefs.getDouble('xpToNextLevel') ?? 100.0;
      animatedXp = xp;
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

    
    double start = animatedXp;
    double end = xp;
    int steps = 20;
    int currentStep = 0;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      currentStep++;
      setState(() {
        animatedXp = start + ((end - start) * currentStep / steps);
      });
      if (currentStep >= steps) {
        animatedXp = end;
        timer.cancel();
      }
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
    double barWidth = MediaQuery.of(context).size.width - 48;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_color1.value!, _color2.value!, _color3.value!, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Your Progress",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "OVERALL SCORE",
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${percent.toStringAsFixed(0)}%",
                            style: const TextStyle(
                              fontSize: 68,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.blueAccent,
                                  blurRadius: 12,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${totalScore.toInt()}/${totalPoints.toInt()} Points",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "LEVEL PROGRESS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: barWidth,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: (animatedXp / xpToNextLevel) * barWidth,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(209, 161, 199, 249),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Positioned(
                          left: ((animatedXp / xpToNextLevel) * barWidth) - 20,
                          child: Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Image.asset(
                              'assets/owl.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Level $level • ${xp.toStringAsFixed(0)}/${xpToNextLevel.toStringAsFixed(0)} XP",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 166, 197, 238),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "PERFORMANCE BY LEVEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                    const SizedBox(height: 20),

                    
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Congratulations!",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "You've completed your assessments and earned XP!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    
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
          );
        },
      ),
    );
  }

  Widget _buildLevelBox(String label, int score, int total) {
    double percent = total > 0 ? (score / total) * 100 : 0;
    return Container(
      width: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
          const SizedBox(height: 6),
          Text("$score/$total",
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white70)),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent / 100,
            minHeight: 5,
            color: const Color(0xFF2A7BE6),
            backgroundColor: Colors.white12,
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
