import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';

class FoodDiningPage extends StatefulWidget {
  const FoodDiningPage({super.key});

  @override
  _FoodDiningPageState createState() => _FoodDiningPageState();
}

class _FoodDiningPageState extends State<FoodDiningPage> {
  final List<Phrase> foodPhrases = [
    Phrase(english: "I'm hungry", hiligaynon: "Gutom ako"),
    Phrase(english: "I'm thirsty", hiligaynon: "Uhaw ako"),
    Phrase(english: "Let's eat", hiligaynon: "Kaon ta"),
    Phrase(english: "Delicious!", hiligaynon: "Namit gid!"),
    Phrase(english: "I'm full", hiligaynon: "Busog ko"),
    Phrase(english: "I like this food", hiligaynon: "Gusto ko ini nga pagkaon"),
    Phrase(english: "Do you want to eat?", hiligaynon: "Gusto mo magkaon?"),
    Phrase(english: "Where is the restaurant?", hiligaynon: "Diin ang kalan-an?"),
    Phrase(english: "I want water", hiligaynon: "Gusto ko tubig"),
    Phrase(english: "More rice, please", hiligaynon: "Dugang nga kan-on, palihog"),
    Phrase(english: "Can I have a spoon?", hiligaynon: "Pwede ko makahulam kutsara?"),
    Phrase(english: "Can I have a fork?", hiligaynon: "Pwede ko makahulam tinidor?"),
    Phrase(english: "Can I have a plate?", hiligaynon: "Pwede ko makahulam pinggan?"),
    Phrase(english: "This is spicy", hiligaynon: "Makahang ini"),
    Phrase(english: "This is sweet", hiligaynon: "Matam-is ini"),
    Phrase(english: "This is salty", hiligaynon: "Maalat ini"),
    Phrase(english: "This is bitter", hiligaynon: "Mapait ini"),
    Phrase(english: "This is sour", hiligaynon: "Maaslum ini"),
    Phrase(english: "Can I see the menu?", hiligaynon: "Pwede ko makita ang menu?"),
    Phrase(english: "I want to order", hiligaynon: "Gusto ko mag order"),
    Phrase(english: "Do you have vegetarian food?", hiligaynon: "May vegetarian nga pagkaon kamo?"),
    Phrase(english: "No meat, please", hiligaynon: "Wala karne, palihog"),
    Phrase(english: "No pork, please", hiligaynon: "Wala baboy, palihog"),
    Phrase(english: "Can I take this home?", hiligaynon: "Pwede ko ini dal-on pauli?"),
    Phrase(english: "I'm allergic to...", hiligaynon: "May allergy ako sa ____"),
    Phrase(english: "I like chicken", hiligaynon: "Gusto ko manok"),
    Phrase(english: "I like fish", hiligaynon: "Gusto ko isda"),
    Phrase(english: "I like vegetables", hiligaynon: "Gusto ko utan"),
    Phrase(english: "No sugar, please", hiligaynon: "Wala kalamay, palihog"),
    Phrase(english: "More, please", hiligaynon: "Dugang pa, palihog"),
    Phrase(english: "Less salt, please", hiligaynon: "Gamay lang nga asin, palihog"),
    Phrase(english: "It's too hot", hiligaynon: "Init ini kaayo"),
    Phrase(english: "It's cold", hiligaynon: "Tugnaw ini"),
    Phrase(english: "Let's have a snack", hiligaynon: "Mamahaw ta"),
    Phrase(english: "Breakfast", hiligaynon: "Pamahaw"),
    Phrase(english: "Lunch", hiligaynon: "Panyaga"),
    Phrase(english: "Dinner", hiligaynon: "Panyapon"),
    Phrase(english: "Table for two", hiligaynon: "Lamesa para sa duha"),
    Phrase(english: "I'm cooking", hiligaynon: "Nagaluto ako"),
    Phrase(english: "This is my favorite dish", hiligaynon: "Paborito ko ini nga sud-an"),
    Phrase(english: "Where can I buy food?", hiligaynon: "Diin ko pwede mabakal pagkaon?"),
    Phrase(english: "Thank you for the food", hiligaynon: "Salamat sa pagkaon"),
    Phrase(english: "I'm not hungry", hiligaynon: "Indi ako gutom"),
    Phrase(english: "What is this dish?", hiligaynon: "Ano ini nga putahe?"),
    Phrase(english: "Do you want dessert?", hiligaynon: "Gusto mo panghimagas?"),
    Phrase(english: "That smells good", hiligaynon: "Nami ang baho sini"),
    Phrase(english: "Let's drink", hiligaynon: "Inom ta"),
    Phrase(english: "Can I have some water?", hiligaynon: "Pwede ko kapangayo tubig?"),
    Phrase(english: "I want coffee", hiligaynon: "Gusto ko kape"),
    Phrase(english: "I want tea", hiligaynon: "Gusto ko tsa"),
    Phrase(english: "I want juice", hiligaynon: "Gusto ko juice"),
    Phrase(english: "Do you have snacks?", hiligaynon: "May snacks kamo?"),
    Phrase(english: "Can I have a napkin?", hiligaynon: "Pwede ko kapangayo napkin?"),
    Phrase(english: "Can I have salt?", hiligaynon: "Pwede ko kapangayo asin?"),
    Phrase(english: "Can I have pepper?", hiligaynon: "Pwede ko kapangayo paminta?"),
    Phrase(english: "The food is cold", hiligaynon: "Tugnaw ang pagkaon"),
    Phrase(english: "The food is hot", hiligaynon: "Init ang pagkaon"),
    Phrase(english: "Can I have a drink?", hiligaynon: "Pwede ko kapangayo ilimnon?"),
    Phrase(english: "I want dessert", hiligaynon: "Gusto ko panghimagas"),
    Phrase(english: "The food is tasty", hiligaynon: "Namit ang pagkaon"),
    Phrase(english: "I don't like this food", hiligaynon: "Indi ko gusto ini nga pagkaon"),
    Phrase(english: "Can you cook this for me?", hiligaynon: "Pwede mo lutuon ini para sa akon?"),
    Phrase(english: "I want more rice", hiligaynon: "Gusto ko magdugang kan-on"),
  ];

  List<Phrase> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavoritesFromFirebase();
  }

  void loadFavoritesFromFirebase() async {
    final snapshot = await FirebaseFirestore.instance.collection('favorites').get();
    setState(() {
      favorites = snapshot.docs.map((doc) {
        return Phrase(
          english: doc['english'],
          hiligaynon: doc['hiligaynon'],
        );
      }).toList();
    });
  }

  Future<void> toggleFavorite(Phrase phrase) async {
    final docId = '${phrase.english}_${phrase.hiligaynon}';
    final docRef = FirebaseFirestore.instance.collection('favorites').doc(docId);

    final isFavorite = favorites.any((p) =>
        p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);

    setState(() {
      if (isFavorite) {
        favorites.removeWhere((p) =>
            p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);
      } else {
        favorites.add(phrase);
      }
    });

    try {
      if (isFavorite) {
        await docRef.delete();
      } else {
        await docRef.set({
          'english': phrase.english,
          'hiligaynon': phrase.hiligaynon,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      
      setState(() {
        if (isFavorite) {
          favorites.add(phrase);
        } else {
          favorites.removeWhere((p) =>
              p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update favorite')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food and Dining'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'ENGLISH',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'HILIGAYNON',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: foodPhrases.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = foodPhrases[index];
                  final isFavorite = favorites.any((p) =>
                      p.english == phrase.english &&
                      p.hiligaynon == phrase.hiligaynon);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          phrase.english,
                          style: const TextStyle(
                            fontFamily: 'KumbhSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          phrase.hiligaynon,
                          style: const TextStyle(
                            fontFamily: 'KumbhSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(phrase),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
