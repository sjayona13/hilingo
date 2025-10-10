import 'package:flutter/material.dart';
import 'seeall.dart';
import 'greetings.dart';
import 'numbers.dart';
import 'food_dining.dart';
import 'travel_direction.dart';
import 'guess_phrase.dart';
import 'flashcards.dart';
import 'picture_learning.dart';
import 'quizzes.dart';
import 'history.dart';
import 'culture.dart';
import 'tourist_attractions.dart';
import 'food_cuisines.dart';
import 'speechrecognition.dart';
import 'flashcards_page.dart';
import 'voice_page.dart';
import 'quiz_page.dart';
import 'favorites_page.dart';
import 'phrase.dart';

void main() => runApp(const HilingoApp());

class HilingoApp extends StatelessWidget {
  const HilingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hilingo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'Sans',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  List<Phrase> _favorites = [];

  void _updateFavorites(List<Phrase> updatedFavorites) {
    setState(() {
      _favorites = updatedFavorites;
    });
  }

  late final List<Widget> _pages = [
    const HomePage(),
    const FlashcardsPages(),
    const VoicePage(),
    const Quizzess(),
    FavoritePage(),
  ];

  final List<String> iconPaths = [
    'assets/home.png',
    'assets/card.png',
    'assets/mic.png',
    'assets/quiz.png',
    'assets/fav.png',
  ];

  final List<String> labels = [
    'Home',
    'Flashcards',
    'Voice',
    'Quiz',
    'Favorites',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: List.generate(5, (index) {
          final isSelected = _selectedIndex == index;
          final isHovered = _hoveredIndex == index;

          return BottomNavigationBarItem(
            icon: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _hoveredIndex = index;
                });
              },
              onExit: (_) {
                setState(() {
                  _hoveredIndex = -1;
                });
              },
              child: ImageIcon(
                AssetImage(iconPaths[index]),
                size: 24,
                color: isSelected
                    ? Colors.blue
                    : isHovered
                        ? Colors.blue.withOpacity(0.6)
                        : Colors.black,
              ),
            ),
            label: labels[index],
          );
        }),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, String title) {
    Widget page;

    switch (title) {
      case 'Speech Recognition':
        page = const SpeechPage(); 
        break;
      case 'Greetings':
        page = const Greetings2Page();
        break;
      case 'Numbers':
        page = const NumbersPage();
        break;
      case 'Food and Dining':
        page = const FoodDiningPage();
        break;
      case 'Travel and Direction':
        page = const TravelDirectionPage();
        break;
      case 'Guess the Phrase':
        page = const GuessPage();
        break;
      case 'Flashcards':
        page = const FlashCards();
        break;
      case 'Picture Learning':
        page = const PictureLearningPage();
        break;
      case 'Quizzes':
        page = const QuizzesPage();
        break;
      case 'History':
        page = const HistoryPage();
        break;
      case 'Culture':
        page = const CulturePage();
        break;
      case 'Tourist Attractions':
        page = const TouristAttractionsPage();
        break;
      case 'Food & Cuisines':
        page = const FoodCuisinesPage();
        break;
      default:
        page = Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: Text('This is the $title page')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget buildImageTile(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () => navigateTo(context, title),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 40, height: 40),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('WELCOME TO HILINGO!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Discover the beauty of Hiligaynon',
                      style: TextStyle(fontSize: 14)),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => navigateTo(context, 'Speech Recognition'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.mic, size: 50, color: Colors.blue),
                      SizedBox(height: 10),
                      Text('Speech Recognition',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Speech–to–text Translation'),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Common Phrases',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SeeAllPage()),
                    );
                  },
                  child: const Text('See All',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 19,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Learn common phrases for everyday situations.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF878282),
              ),
            ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildImageTile(context, 'Greetings', 'assets/greet.png'),
                buildImageTile(context, 'Numbers', 'assets/numbers.png'),
                buildImageTile(context, 'Food and Dining', 'assets/food.png'),
                buildImageTile(
                    context, 'Travel and Direction', 'assets/travel.png'),
              ],
            ),

            const Text('Hiligaynon Challenges',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            const SizedBox(height: 4),
            const Text(
              'Magtuon sa Malipayong Paagi! (Learn in a fun way!)',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF878282),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildImageTile(
                    context, 'Guess the Phrase', 'assets/guess.png'),
                buildImageTile(context, 'Flashcards', 'assets/flash-card.png'),
                buildImageTile(
                    context, 'Picture Learning', 'assets/picture-learning.png'),
                buildImageTile(context, 'Quizzes', 'assets/quizzes.png'),
              ],
            ),

            const Text('About Iloilo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            const SizedBox(height: 4),
            const Text(
              'Discover Iloilo—its culture, history, and people!',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF878282),
              ),
            ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildImageTile(context, 'History', 'assets/history.png'),
                buildImageTile(context, 'Culture', 'assets/culture.png'),
                buildImageTile(
                    context, 'Tourist Attractions', 'assets/tour.png'),
                buildImageTile(
                    context, 'Food & Cuisines', 'assets/food-c.png'),
              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('This is the $title page',
            style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
