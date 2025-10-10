import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';
import 'seeall.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final List<Phrase> phrases = [
    Phrase(english: "It’s hot today", hiligaynon: "Mainit subong"),
    Phrase(english: "It’s cold", hiligaynon: "Tugnaw"),
    Phrase(english: "It’s raining", hiligaynon: "Naga ulan"),
    Phrase(english: "It’s sunny", hiligaynon: "Masanag ang adlaw"),
    Phrase(english: "It’s windy", hiligaynon: "Mahuyop ang hangin"),
    Phrase(english: "There’s thunder", hiligaynon: "May daguob"),
    Phrase(english: "There’s lightning", hiligaynon: "May kilat"),
    Phrase(english: "There’s a rainbow", hiligaynon: "May balangaw"),
    Phrase(english: "What’s the weather like?", hiligaynon: "Ano ang tyempo?"),
    Phrase(english: "It’s foggy", hiligaynon: "Mahamog"),
    Phrase(english: "It’s pouring", hiligaynon: "Baskog ang ulan"),
    Phrase(english: "There’s a typhoon", hiligaynon: "May bagyo"),
    Phrase(english: "The sun is shining", hiligaynon: "Nagasidlaw ang adlaw"),
    Phrase(english: "It’s stormy", hiligaynon: "Madulom ang kalangitan"),
    Phrase(english: "The wind is strong", hiligaynon: "Mabaskog ang hangin"),
    Phrase(english: "There’s a breeze", hiligaynon: "May mahinay nga hangin"),
    Phrase(english: "It’s a beautiful day", hiligaynon: "Nami ang adlaw"),
    Phrase(english: "It’s freezing", hiligaynon: "Naga tugnaw"),
    Phrase(english: "It’s hot", hiligaynon: "Grabe ang kainit"),
    Phrase(english: "The ground is wet", hiligaynon: "Basa ang duta"),
    Phrase(english: "The river is rising", hiligaynon: "Nagasaka ang suba"),
    Phrase(english: "There’s a flood", hiligaynon: "May baha"),
    Phrase(english: "A storm is coming", hiligaynon: "May nagapalapit nga bagyo"),
    Phrase(english: "The moon is beautiful", hiligaynon: "Nami ang bulan"),
    Phrase(english: "The stars are bright", hiligaynon: "Masanag ang mga bituon"),
    Phrase(english: "Watch out for lightning", hiligaynon: "Maghalong sa kilat"),
    Phrase(english: "Close the windows", hiligaynon: "Isirado ang mga bintana"),
    Phrase(english: "Bring an umbrella", hiligaynon: "Magdala sang payong"),
    Phrase(english: "The waves are strong", hiligaynon: "Mabaskog ang mga balod"),
    Phrase(english: "It’s dry season", hiligaynon: "Tion sang ting-init"),
    Phrase(english: "It’s wet season", hiligaynon: "Tion sang ting-ulan"),
    Phrase(english: "The sky is clear", hiligaynon: "Tin-aw ang langit"),
    Phrase(english: "The air is fresh", hiligaynon: "Presko ang hangin"),
    Phrase(english: "It’s dusty", hiligaynon: "Mayab-ok"),
    Phrase(english: "It’s muddy", hiligaynon: "Malutak"),
    Phrase(english: "It’s slippery", hiligaynon: "Madanlog"),
    Phrase(english: "Be careful, it’s wet", hiligaynon: "Maghalong kay basa"),
    Phrase(english: "Sunset is beautiful", hiligaynon: "Nami ang pagsalop sang adlaw"),
    Phrase(english: "Sunrise is beautiful", hiligaynon: "Nami ang pagsubang sang adlaw"),
    Phrase(english: "What a nice breeze", hiligaynon: "Nami ang huyop sang hangin"),
    Phrase(english: "The rain has stopped", hiligaynon: "Untat na ang ulan"),
    Phrase(english: "It’s chilly", hiligaynon: "Malamig"),
  ];

  List<Phrase> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavoritesFromFirebase();
  }

  void loadFavoritesFromFirebase() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('favorites').get();
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
    final docRef =
        FirebaseFirestore.instance.collection('favorites').doc(docId);

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
              p.english == phrase.english &&
              p.hiligaynon == phrase.hiligaynon);
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
        title: const Text('Weather and Nature'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SeeAllPage()),
            );
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
                itemCount: phrases.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = phrases[index];
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
                        color: isFavorite ? Colors.red: Colors.grey,
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
