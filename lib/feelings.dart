import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';
import 'seeall.dart';

class FeelingsPage extends StatefulWidget {
  const FeelingsPage({super.key});

  @override
  State<FeelingsPage> createState() => _FeelingsPageState();
}

class _FeelingsPageState extends State<FeelingsPage> {
  final List<Phrase> phrases = [
    Phrase(english: 'I am happy', hiligaynon: 'Malipay ako'),
    Phrase(english: 'I am sad', hiligaynon: 'Masubo ako'),
    Phrase(english: 'I am angry', hiligaynon: 'Akig ako'),
    Phrase(english: 'I am excited', hiligaynon: 'Excited ako'),
    Phrase(english: 'I am scared', hiligaynon: 'Nahadlok ako'),
    Phrase(english: 'I am tired', hiligaynon: 'Kapoy ako'),
    Phrase(english: 'I feel sick', hiligaynon: 'Daw Mahilanat ako'),
    Phrase(english: 'I feel good', hiligaynon: 'Nami ang pamatyag ko'),
    Phrase(english: 'I am surprised', hiligaynon: 'Nakibot ako'),
    Phrase(english: 'I am shy', hiligaynon: 'Nahuya ako'),
    Phrase(english: 'I am relaxed', hiligaynon: 'Kalma lang ako'),
    Phrase(english: 'I feel alone', hiligaynon: 'Nabatyagan ko nga nagaisahanon ako'),
    Phrase(english: 'I miss you', hiligaynon: 'Nahidlaw ko sa imo'),
    Phrase(english: 'I love you', hiligaynon: 'Palangga ta ikaw'),
    Phrase(english: 'I am proud', hiligaynon: 'Ipabugal ko'),
    Phrase(english: 'I feel strong', hiligaynon: 'Baskog ako'),
    Phrase(english: 'I feel weak', hiligaynon: 'Maluya ako'),
    Phrase(english: 'I am hopeful', hiligaynon: 'May paglaum ako'),
    Phrase(english: 'I feel love', hiligaynon: 'Ginahigugma ako'),
    Phrase(english: 'I feel hurt', hiligaynon: 'Nasakitan ako'),
    Phrase(english: 'I feel lucky', hiligaynon: 'Swerte ako'),
    Phrase(english: 'I am worried', hiligaynon: 'Gakabalaka ako'),
    Phrase(english: 'I am okay', hiligaynon: 'Okay lang ako'),
    Phrase(english: 'I am content', hiligaynon: 'Kontento ako'),
    Phrase(english: 'I am thankful', hiligaynon: 'Mapinasalamaton ako'),
    Phrase(english: 'I am worried about you', hiligaynon: 'Gakabalaka ako sa imo'),
    Phrase(english: 'I feel peace', hiligaynon: 'May kalinong ako'),
    Phrase(english: 'I feel energized', hiligaynon: 'May kusog ako'),
    Phrase(english: 'I am feeling down', hiligaynon: 'Ginapanubo ko ang akon kaugalingon'),
    Phrase(english: 'I feel brave', hiligaynon: 'Isog ako'),
    Phrase(english: 'I feel inspired', hiligaynon: 'Gina-inspire ako'),
    Phrase(english: 'I feel disappointed', hiligaynon: 'Na disappointed ako'),
    Phrase(english: 'I feel embarrassed', hiligaynon: 'Nahuya ako'),
    Phrase(english: 'I feel respected', hiligaynon: 'Ginarespeto ako'),
    Phrase(english: 'I feel nervous', hiligaynon: 'Naganerbyos ako'),
    Phrase(english: 'I feel jealous', hiligaynon: 'Naga seloso ako'),
    Phrase(english: 'I feel anxious', hiligaynon: 'Naga balaka ako'),
    Phrase(english: 'I feel confused', hiligaynon: 'Nalipat ako'),
    Phrase(english: 'I feel excited and happy', hiligaynon: 'Nalipay kag excited ako'),
    Phrase(english: 'I feel frustrated', hiligaynon: 'Nagasuko ako'),
    Phrase(english: 'I feel overwhelmed', hiligaynon: 'Nabug-atan ako'),
    Phrase(english: 'I feel calm', hiligaynon: 'Kalma ako'),
    Phrase(english: 'I feel proud of you', hiligaynon: 'Ipabugal ko ikaw'),
    Phrase(english: 'I feel guilty', hiligaynon: 'May sala ako'),
    Phrase(english: 'I feel relieved', hiligaynon: 'Nakaluwag ako'),
    Phrase(english: 'I feel lonely', hiligaynon: 'Nagaisahanon ako'),
    Phrase(english: 'I feel excited to see you', hiligaynon: 'Excited ako makita ka'),
    Phrase(english: 'I feel grateful', hiligaynon: 'Mapinasalamaton ako'),
    Phrase(english: 'I feel sad for you', hiligaynon: 'Masubo ako para sa imo'),
    Phrase(english: 'I feel inspired by you', hiligaynon: 'Gina-inspire ako sa imo'),
    Phrase(english: 'I feel embarrassed for what happened', hiligaynon: 'Nahuya ako sa natabo'),
    Phrase(english: 'I feel energetic', hiligaynon: 'May kusog ako'),
    Phrase(english: 'I feel sleepy', hiligaynon: 'Gakapoy ako kag matulog'),
    Phrase(english: 'I feel amazed', hiligaynon: 'Nakahangwow ako'),
    Phrase(english: 'I feel thankful for your help', hiligaynon: 'Mapinasalamaton ako sa imo bulig'),
    Phrase(english: 'I feel worried about the future', hiligaynon: 'Gakabalaka ako sa palaabuton'),
    Phrase(english: 'I feel cheerful', hiligaynon: 'Malipayong ako'),
    Phrase(english: 'I feel disappointed in myself', hiligaynon: 'Na disappointed ako sa akon kaugalingon'),
    Phrase(english: 'I feel hopeful for tomorrow', hiligaynon: 'May paglaum ako para sa buwas'),
    Phrase(english: 'I feel satisfied', hiligaynon: 'Kontento ako'),
    Phrase(english: 'I feel stressed', hiligaynon: 'Naga-stress ako'),
    Phrase(english: 'I feel shocked', hiligaynon: 'Nakahangwow ako'),
    Phrase(english: 'I feel amused', hiligaynon: 'Nalipay kag nagakakatawa ako'),
    Phrase(english: 'I feel annoyed', hiligaynon: 'Nainis ako'),
    Phrase(english: 'I feel relaxed and comfortable', hiligaynon: 'Kalma kag komportable ako'),
    Phrase(english: 'I feel curious', hiligaynon: 'Naga-usisa ako'),
    Phrase(english: 'I feel playful', hiligaynon: 'Naga-bugal ako'),
    Phrase(english: 'I feel embarrassed but happy', hiligaynon: 'Nahuya pero malipay ako'),
    Phrase(english: 'I feel loved', hiligaynon: 'Ginahigugma ako'),
    Phrase(english: 'I feel betrayed', hiligaynon: 'Gin-traydor ako'),
    Phrase(english: 'I feel nervous about speaking', hiligaynon: 'Nakahangawa ako maghambal'),
    Phrase(english: 'I feel proud of my achievement', hiligaynon: 'Ipinabugal ko ang akon naangkon'),
    Phrase(english: 'I feel scared for them', hiligaynon: 'Nahadlok ako para sa ila'),
    Phrase(english: 'I feel motivated', hiligaynon: 'Gina-motivate ako'),
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
        title: const Text('Feelings and Reaction'),
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
