import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';
import 'favorites_page.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  final List<Phrase> numbers = [
    Phrase(english: 'One', hiligaynon: 'Isa'),
    Phrase(english: 'Two', hiligaynon: 'Duha'),
    Phrase(english: 'Three', hiligaynon: 'Tatlo'),
    Phrase(english: 'Four', hiligaynon: 'Apat'),
    Phrase(english: 'Five', hiligaynon: 'Lima'),
    Phrase(english: 'Six', hiligaynon: 'Anom'),
    Phrase(english: 'Seven', hiligaynon: 'Pito'),
    Phrase(english: 'Eight', hiligaynon: 'Walo'),
    Phrase(english: 'Nine', hiligaynon: 'Siyam'),
    Phrase(english: 'Ten', hiligaynon: 'Napulo'),
    Phrase(english: 'Eleven', hiligaynon: 'Napulo kag isa'),
    Phrase(english: 'Twelve', hiligaynon: 'Napulo kag duha'),
    Phrase(english: 'Thirteen', hiligaynon: 'Napulo kag tatlo'),
    Phrase(english: 'Fourteen', hiligaynon: 'Napulo kag apat'),
    Phrase(english: 'Fifteen', hiligaynon: 'Napulo kag lima'),
    Phrase(english: 'Twenty', hiligaynon: 'Bainte'),
    Phrase(english: 'Thirty', hiligaynon: 'Trenta'),
    Phrase(english: 'Forty', hiligaynon: 'Kwuarenta'),
    Phrase(english: 'Fifty', hiligaynon: 'Singkwenta'),
    Phrase(english: 'Hundred', hiligaynon: 'Gatos'),
  ];

  List<Phrase> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
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
  final isAlreadyFavorite = favorites.any((p) =>
      p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);

  
  setState(() {
    if (isAlreadyFavorite) {
      favorites.removeWhere((p) =>
          p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);
    } else {
      favorites.add(phrase);
    }
  });

  try {
    if (isAlreadyFavorite) {
      final query = await FirebaseFirestore.instance
          .collection('favorites')
          .where('english', isEqualTo: phrase.english)
          .where('hiligaynon', isEqualTo: phrase.hiligaynon)
          .get();

      for (var doc in query.docs) {
        await FirebaseFirestore.instance.collection('favorites').doc(doc.id).delete();
      }
    } else {
      await FirebaseFirestore.instance.collection('favorites').add({
        'english': phrase.english,
        'hiligaynon': phrase.hiligaynon,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  } catch (e) {
    
    setState(() {
      if (isAlreadyFavorite) {
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
  title: const Text('Numbers'),
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
                itemCount: numbers.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = numbers[index];
                  final isFavorite = favorites.contains(phrase);

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
