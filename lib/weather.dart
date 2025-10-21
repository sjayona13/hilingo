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
    Phrase(english: "It’s foggy", hiligaynon: "Matun-og"),
    Phrase(english: "It’s pouring", hiligaynon: "Nagabubo"),
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
    Phrase(english: "It’s cloudy", hiligaynon: "Mabudlay ang langit"),
    Phrase(english: "It’s humid", hiligaynon: "Mahumok ang hangin"),
    Phrase(english: "It’s foggy in the morning", hiligaynon: "Mahamog sa aga"),
    Phrase(english: "There’s hail", hiligaynon: "May yelo nga nagahulog"),
    Phrase(english: "It’s drizzling", hiligaynon: "Nagatulo ang ulan"),
    Phrase(english: "The river is flowing", hiligaynon: "Naga-ilig ang suba"),
    Phrase(english: "The sea is calm", hiligaynon: "Kalmado ang baybay"),
    Phrase(english: "The sea is rough", hiligaynon: "Baskog ang baybay"),
    Phrase(english: "The forest is dense", hiligaynon: "Masiksik ang kagubatan"),
    Phrase(english: "The mountains are high", hiligaynon: "Mataas ang kabukiran"),
    Phrase(english: "The valley is green", hiligaynon: "Berde ang walog"),
    Phrase(english: "There’s a landslide", hiligaynon: "May landslide"),
    Phrase(english: "The water is cold", hiligaynon: "Tugnaw ang tubig"),
    Phrase(english: "The water is warm", hiligaynon: "Init ang tubig"),
    Phrase(english: "The air is clean", hiligaynon: "Limpyo ang hangin"),
    Phrase(english: "The sky is overcast", hiligaynon: "Ang kalangitan naga tabon"),
    Phrase(english: "The flowers are blooming", hiligaynon: "Nagabuskag ang mga bulak"),
    Phrase(english: "The leaves are falling", hiligaynon: "Nagahulog ang mga dahon"),
    Phrase(english: "The grass is wet", hiligaynon: "Basa ang hilamon"),
    Phrase(english: "The snow is falling", hiligaynon: "Nagahulog ang niebe"),
    Phrase(english: "There’s a tornado", hiligaynon: "May bagyo nga nagahuyop"),
    Phrase(english: "The weather is changing", hiligaynon: "Nagabago ang tyempo"),
    Phrase(english: "It’s cloudy with a chance of rain", hiligaynon: "Magal-umon kag may tyansa nga mag-ulan"),
    Phrase(english: "The wind is gentle", hiligaynon: "Mahinay ang hangin"),
    Phrase(english: "The sun is setting", hiligaynon: "Nagasalop ang adlaw"),
    Phrase(english: "The sun is rising", hiligaynon: "Nagasubang ang adlaw"),
    Phrase(english: "There’s frost", hiligaynon: "May hamog nga yelo"),
    Phrase(english: "It’s a hot and sunny day", hiligaynon: "Mainit kag masanag ang adlaw"),
    Phrase(english: "The tide is high", hiligaynon: "Mataas ang balod"),
    Phrase(english: "The tide is low", hiligaynon: "Nubo ang balod"),
    Phrase(english: "The volcano is active", hiligaynon: "Aktibo ang bulkan"),
    Phrase(english: "The river is calm", hiligaynon: "Kalmado ang suba"),
    Phrase(english: "The river is muddy", hiligaynon: "Malutak ang suba"),
    Phrase(english: "The lake is deep", hiligaynon: "Madalom ang lanaw"),
    Phrase(english: "The lake is shallow", hiligaynon: "Matanghod ang lanaw"),
    Phrase(english: "The wind is chilly", hiligaynon: "Malamig ang hangin"),
    Phrase(english: "The night is clear", hiligaynon: "Tin-aw ang gab-i"),
    Phrase(english: "The morning is fresh", hiligaynon: "Presko ang aga"),
    Phrase(english: "The evening is cool", hiligaynon: "Tugnaw ang hapon"),
    Phrase(english: "It’s foggy in the evening", hiligaynon: "Mahamog sa hapon"),
    Phrase(english: "The clouds are dark", hiligaynon: "Maitom ang mga panganod"),
    Phrase(english: "The sky is pink", hiligaynon: "Rosado ang langit"),
    Phrase(english: "The sky is orange", hiligaynon: "Kahel ang langit"),
    Phrase(english: "The sky is purple", hiligaynon: "Lila ang langit"),
    Phrase(english: "The horizon is clear", hiligaynon: "Tin-aw ang palibot"),
    Phrase(english: "The forest is quiet", hiligaynon: "Hilom ang kagubatan"),
    Phrase(english: "The forest is noisy", hiligaynon: "Hingilo ang kagubatan"),
    Phrase(english: "It’s a stormy night", hiligaynon: "Madulom kag mabaskog ang gab-i"),
    Phrase(english: "The waves are crashing", hiligaynon: "Nagahampak ang mga balod"),
    Phrase(english: "The tide is rising", hiligaynon: "Nagasaka ang balod"),
    Phrase(english: "The tide is falling", hiligaynon: "Nagapanubo ang balod"),

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
