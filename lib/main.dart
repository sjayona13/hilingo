import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'starting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  rive.Artboard? _riveArtboard;
  bool showLogo = false;

  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadRiveAnimation();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoScaleAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack);

    // 🦉 Show owl for 8 seconds, then show logo for 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      setState(() => showLogo = true);
      _logoController.forward();

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const StartingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(seconds: 1),
          ),
        );
      });
    });
  }

  Future<void> _loadRiveAnimation() async {
    try {
      final data = await rootBundle.load('assets/owl_fly.riv');
      print("✅ Rive file loaded successfully.");

      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;

      print("🎬 Available animations:");
      for (var a in artboard.animations) {
        print(" - ${a.name}");
      }

      // ✅ Replace 'Timeline 1' if your animation name is different
      artboard.addController(rive.SimpleAnimation('Timeline 1', autoplay: true));

      setState(() => _riveArtboard = artboard);
    } catch (e) {
      print("❌ Error loading Rive file: $e");
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🦉 Owl animation section
          if (_riveArtboard != null && !showLogo)
            Center(
              child: SizedBox(
                width: 400, // bigger owl size
                height: 400,
                child: rive.Rive(artboard: _riveArtboard!),
              ),
            )
          else if (!showLogo)
            const Center(
              child: Text(
                'Loading owl animation...',
                style: TextStyle(color: Colors.black),
              ),
            ),

          // 🕊️ Hilingo logo + text section
          if (showLogo)
  Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _logoScaleAnimation,
          child: Image.asset(
            'assets/iconh.png',
            width: 150,
            height: 150,
          ),
        ),
        const SizedBox(height: 0), // 👈 closer spacing between logo & text
        const Text(
          'Speak. Understand. Connect.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(221, 63, 62, 62),
            letterSpacing: 0.3,
            height: 0.1, // tighter line height
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
