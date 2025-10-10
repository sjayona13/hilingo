import 'package:flutter/material.dart';
import 'greetings.dart';
import 'numbers.dart';
import 'food_dining.dart';
import 'travel_direction.dart';
import 'shopping.dart';
import 'emergency.dart';
import 'polite.dart';
import 'technology.dart';
import 'weather.dart';
import 'feelings.dart';
import 'homepage.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({super.key});

  final List<String> iconLabels = const [
    'Greetings',
    'Numbers',
    'Food and Dining',
    'Travel and Direction',
    'Shopping',
    'Emergency',
    'Polite Expression',
    'Technology and Online',
    'Weather and Nature',
    'Feelings and Reaction',
  ];

  final List<String> iconImages = const [
    'assets/greet.png',
    'assets/numbers.png',
    'assets/food.png',
    'assets/travel.png',
    'assets/shopping.png',
    'assets/emergency.png',
    'assets/polite.png',
    'assets/techno.png',
    'assets/weather.png',
    'assets/feeling.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Common Phrases',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HilingoApp()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: iconLabels.length,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Greetings2Page()));
                    break;
                  case 1:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const NumbersPage()));
                    break;
                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FoodDiningPage()));
                    break;
                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TravelDirectionPage()));
                    break;
                  case 4:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ShoppingPage()));
                    break;
                  case 5:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EmergencyPage()));
                    break;
                  case 6:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PolitePage()));
                    break;
                  case 7:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const TechnologyPage()));
                    break;
                  case 8:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const WeatherPage()));
                    break;
                  case 9:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const FeelingsPage()));
                    break;
                  default:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Coming soon!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: index <= 9
                        ? const Color(0xFF2A7BE6)
                        : Colors.black12,
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
                      iconImages[index],
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      iconLabels[index],
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
