import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';

class TravelDirectionPage extends StatefulWidget {
  const TravelDirectionPage({super.key});

  @override
  State<TravelDirectionPage> createState() => _TravelDirectionPageState();
}

class _TravelDirectionPageState extends State<TravelDirectionPage> {
  final List<Phrase> travelPhrases = [
    Phrase(english: "Where is the bus stop?", hiligaynon: "Diin ang sakayan?"),
    Phrase(english: "I need a taxi", hiligaynon: "Kinahanglan ko sang taxi"),
    Phrase(english: "How much is the fare?", hiligaynon: "Tagpila ang plite?"),
    Phrase(english: "Where is the airport?", hiligaynon: "Diin ang airport?"),
    Phrase(english: "Left", hiligaynon: "Wala"),
    Phrase(english: "Right", hiligaynon: "Tu-o"),
    Phrase(english: "Straight ahead", hiligaynon: "Deretso lang"),
    Phrase(english: "Stop here", hiligaynon: "Pundo diri"),
    Phrase(english: "Go faster", hiligaynon: "Dasiga gamay"),
    Phrase(english: "Go slower", hiligaynon: "Hinay gamay"),
    Phrase(english: "Where are we going?", hiligaynon: "Diin kita pakadto?"),
    Phrase(english: "This way", hiligaynon: "Paagi diri"),
    Phrase(english: "That way", hiligaynon: "Paagi didto"),
    Phrase(english: "Turn left", hiligaynon: "Liko sa wala"),
    Phrase(english: "Turn right", hiligaynon: "Liko sa tu-o"),
    Phrase(english: "Is it far?", hiligaynon: "Layo pa?"),
    Phrase(english: "Is it near?", hiligaynon: "Lapit lang?"),
    Phrase(english: "I’m lost", hiligaynon: "Natalang ako"),
    Phrase(english: "Can you help me?", hiligaynon: "Pwede ka bulig sa akon?"),
    Phrase(english: "Where is the hotel?", hiligaynon: "Diin ang hotel?"),
    Phrase(english: "I want to go here", hiligaynon: "Gusto ko magadto diri"),
    Phrase(english: "I need directions", hiligaynon: "Kinahanglan ko sang direksyon"),
    Phrase(english: "Near the market", hiligaynon: "Lapit sa tinda"),
    Phrase(english: "By the church", hiligaynon: "Kilid sang simbahan"),
    Phrase(english: "Next to the bank", hiligaynon: "Tupad sang bangko"),
    Phrase(english: "Opposite the mall", hiligaynon: "Atubang sang mall"),
    Phrase(english: "How long will it take?", hiligaynon: "Tugay pa ni?"),
    Phrase(english: "Is there parking?", hiligaynon: "May parking dira?"),
    Phrase(english: "Which road?", hiligaynon: "Ano nga dalan?"),
    Phrase(english: "I will walk", hiligaynon: "Malakat lang ko"),
    Phrase(english: "I will ride", hiligaynon: "Masakay ako"),
    Phrase(english: "Take me to this address", hiligaynon: "Dal-a ko diri nga lugaw"),
    Phrase(english: "It's on the left side", hiligaynon: "Ara sa wala nga bahin"),
    Phrase(english: "It's on the right side", hiligaynon: "Ara sa tu-o nga bahin"),
    Phrase(english: "At the corner", hiligaynon: "Sa kanto"),
    Phrase(english: "Go down here", hiligaynon: "Naug ka diri"),
    Phrase(english: "Get on there", hiligaynon: "Sakay ka didto"),
    Phrase(english: "Where is the port?", hiligaynon: "Diin ang pantalan?"),
    Phrase(english: "What time is the trip?", hiligaynon: "Anong oras ang byahe?"),
    Phrase(english: "Do I need a ticket?", hiligaynon: "Kinahanglan ko ticket?"),
    Phrase(english: "Can I book online?", hiligaynon: "Pwede online mag-book?"),
    Phrase(english: "Is it safe?", hiligaynon: "Indi delikado?"),
    Phrase(english: "Is it open?", hiligaynon: "Bukas pa?"),
    Phrase(english: "We are here", hiligaynon: "Ari na kita"),
    Phrase(english: "You're going the wrong way", hiligaynon: "Sala imo ginapanaw"),
    Phrase(english: "Let’s go", hiligaynon: "Tara na"),
    Phrase(english: "I'm on my way", hiligaynon: "Paadto na ko"),
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
        title: const Text('Travel and Direction'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), 
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
                itemCount: travelPhrases.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = travelPhrases[index];
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
