import 'package:flutter/material.dart';
import 'homepage.dart'; // Make sure this file exists

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<Offset> _slide;
  late Animation<double> _fade;
  bool _isPressed = false; // Track button press state

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _fade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _textController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _onStartPressed() async {
    setState(() => _isPressed = true);

    // Wait for the button to "press down"
    await Future.delayed(const Duration(milliseconds: 120));

    setState(() => _isPressed = false);

    // Wait for it to return to normal, then navigate
    await Future.delayed(const Duration(milliseconds: 100));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HilingoApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight + 100,
          child: Stack(
            children: [
              // Top cloud
              Positioned(
                left: 75,
                top: -66,
                child: Image.asset(
                  'assets/cloud_top.png',
                  width: 470,
                  height: 430,
                  fit: BoxFit.contain,
                ),
              ),

              // Bottom cloud
              Positioned(
                left: -130,
                top: 475,
                child: Image.asset(
                  'assets/cloud_bottom.png',
                  width: 470,
                  height: 430,
                  fit: BoxFit.fill,
                ),
              ),

              // Text
              Positioned(
                left: 36,
                top: 420,
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'LEARN HILIGAYNON',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'KumbhSans',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '—every word you learn\nopens new doors!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'KumbhSans',
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Start Learning Button
              Positioned(
                left: 80,
                top: 693,
                child: AnimatedScale(
                  scale: _isPressed ? 0.93 : 1.0, // Press effect
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  child: SizedBox(
                    width: 239,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _onStartPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A7BE6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: _isPressed ? 2 : 6,
                      ),
                      child: const Text(
                        'START LEARNING',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                          color: Colors.white,
                          fontFamily: 'KumbhSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
