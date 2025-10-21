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
    Phrase(english: 'Six', hiligaynon: 'Anum'),
    Phrase(english: 'Seven', hiligaynon: 'Pito'),
    Phrase(english: 'Eight', hiligaynon: 'Walo'),
    Phrase(english: 'Nine', hiligaynon: 'Siyam'),
    Phrase(english: 'Ten', hiligaynon: 'Napulo'),
    Phrase(english: 'Eleven', hiligaynon: 'Onse'),
    Phrase(english: 'Twelve', hiligaynon: 'Dose'),
    Phrase(english: 'Thirteen', hiligaynon: 'Trese'),
    Phrase(english: 'Fourteen', hiligaynon: 'Katorse'),
    Phrase(english: 'Fifteen', hiligaynon: 'Kinse'),
    Phrase(english: 'Sixteen', hiligaynon: 'Disesais'),
    Phrase(english: 'Seventeen', hiligaynon: 'Disesyete'),
    Phrase(english: 'Eighteen', hiligaynon: 'Diseotso'),
    Phrase(english: 'Nineteen', hiligaynon: 'Disenwebe'),
    Phrase(english: 'Twenty', hiligaynon: 'Baynte'),
    Phrase(english: 'Twenty-one', hiligaynon: 'Baynte uno'),
    Phrase(english: 'Twenty-two', hiligaynon: 'Baynte dos'),
    Phrase(english: 'Twenty-three', hiligaynon: 'Baynte tres'),
    Phrase(english: 'Twenty-four', hiligaynon: 'Baynte kwatro'),
    Phrase(english: 'Twenty-five', hiligaynon: 'Baynte singko'),
    Phrase(english: 'Twenty-six', hiligaynon: 'Baynte sais'),
    Phrase(english: 'Twenty-seven', hiligaynon: 'Baynte syete'),
    Phrase(english: 'Twenty-eight', hiligaynon: 'Baynte otso'),
    Phrase(english: 'Twenty-nine', hiligaynon: 'Baynte nwebe'),
    Phrase(english: 'Thirty', hiligaynon: 'Traynta'),
    Phrase(english: 'Thirty-one', hiligaynon: 'Trayntay uno'),
    Phrase(english: 'Thirty-two', hiligaynon: 'Trayntay dos'),
    Phrase(english: 'Thirty-three', hiligaynon: 'Trayntay tres'),
    Phrase(english: 'Thirty-four', hiligaynon: 'Trayntay kwatro'),
    Phrase(english: 'Thirty-five', hiligaynon: 'Trayntay singko'),
    Phrase(english: 'Thirty-six', hiligaynon: 'Trayntay sais'),
    Phrase(english: 'Thirty-seven', hiligaynon: 'Trayntay syete'),
    Phrase(english: 'Thirty-eight', hiligaynon: 'Trayntay otso'),
    Phrase(english: 'Thirty-nine', hiligaynon: 'Trayntay nwebe'),
    Phrase(english: 'Forty', hiligaynon: 'Kwarenta'),
    Phrase(english: 'Forty-one', hiligaynon: 'Kwarentay uno'),
    Phrase(english: 'Forty-two', hiligaynon: 'Kwarentay dos'),
    Phrase(english: 'Forty-three', hiligaynon: 'Kwarentay tres'),
    Phrase(english: 'Forty-four', hiligaynon: 'Kwarentay kwatro'),
    Phrase(english: 'Forty-five', hiligaynon: 'Kwarentay singko'),
    Phrase(english: 'Forty-six', hiligaynon: 'Kwarentay sais'),
    Phrase(english: 'Forty-seven', hiligaynon: 'Kwarentay syete'),
    Phrase(english: 'Forty-eight', hiligaynon: 'Kwarentay otso'),
    Phrase(english: 'Forty-nine', hiligaynon: 'Kwarentay nwebe'),
    Phrase(english: 'Fifty', hiligaynon: 'Singkwenta'),
    Phrase(english: 'Fifty-one', hiligaynon: 'Singkwentay uno'),
    Phrase(english: 'Fifty-two', hiligaynon: 'Singkwentay dos'),
    Phrase(english: 'Fifty-three', hiligaynon: 'Singkwentay tres'),
    Phrase(english: 'Fifty-four', hiligaynon: 'Singkwentay kwatro'),
    Phrase(english: 'Fifty-five', hiligaynon: 'Singkwentay singko'),
    Phrase(english: 'Fifty-six', hiligaynon: 'Singkwentay sais'),
    Phrase(english: 'Fifty-seven', hiligaynon: 'Singkwentay syete'),
    Phrase(english: 'Fifty-eight', hiligaynon: 'Singkwentay otso'),
    Phrase(english: 'Fifty-nine', hiligaynon: 'Singkwentay nwebe'),
    Phrase(english: 'Sixty', hiligaynon: 'Sais sienta'),
    Phrase(english: 'Sixty-one', hiligaynon: 'Sais sientay uno'),
    Phrase(english: 'Sixty-two', hiligaynon: 'Sais sientay dos'),
    Phrase(english: 'Sixty-three', hiligaynon: 'Sais sientay tres'),
    Phrase(english: 'Sixty-four', hiligaynon: 'Sais sientay kwatro'),
    Phrase(english: 'Sixty-five', hiligaynon: 'Sais sientay singko'),
    Phrase(english: 'Sixty-six', hiligaynon: 'Sais sienta sais'),
    Phrase(english: 'Sixty-seven', hiligaynon: 'Sais sientay syete'),
    Phrase(english: 'Sixty-eight', hiligaynon: 'Sais sientay otso'),
    Phrase(english: 'Sixty-nine', hiligaynon: 'Sais sientay nwebe'),
    Phrase(english: 'Seventy', hiligaynon: 'Setenta'),
    Phrase(english: 'Seventy-one', hiligaynon: 'Setentay uno'),
    Phrase(english: 'Seventy-two', hiligaynon: 'Setentay dos'),
    Phrase(english: 'Seventy-three', hiligaynon: 'Setentay tres'),
    Phrase(english: 'Seventy-four', hiligaynon: 'Setentay kwatro'),
    Phrase(english: 'Seventy-five', hiligaynon: 'Setentay singko'),
    Phrase(english: 'Seventy-six', hiligaynon: 'Setentay sais'),
    Phrase(english: 'Seventy-seven', hiligaynon: 'Setentay syete'),
    Phrase(english: 'Seventy-eight', hiligaynon: 'Setentay otso'),
    Phrase(english: 'Seventy-nine', hiligaynon: 'Setentay nwebe'),
    Phrase(english: 'Eighty', hiligaynon: 'Otsenta'),
    Phrase(english: 'Eighty-one', hiligaynon: 'Otsentay uno'),
    Phrase(english: 'Eighty-two', hiligaynon: 'Otsentay dos'),
    Phrase(english: 'Eighty-three', hiligaynon: 'Otsentay tres'),
    Phrase(english: 'Eighty-four', hiligaynon: 'Otsentay kwatro'),
    Phrase(english: 'Eighty-five', hiligaynon: 'Otsentay singko'),
    Phrase(english: 'Eighty-six', hiligaynon: 'Otsentay sais'),
    Phrase(english: 'Eighty-seven', hiligaynon: 'Otsentay syete'),
    Phrase(english: 'Eighty-eight', hiligaynon: 'Otsentay otso'),
    Phrase(english: 'Eighty-nine', hiligaynon: 'Otsentay nwebe'),
    Phrase(english: 'Ninety', hiligaynon: 'Nobenta'),
    Phrase(english: 'Ninety-one', hiligaynon: 'Nobentay uno'),
    Phrase(english: 'Ninety-two', hiligaynon: 'Nobentay dos'),
    Phrase(english: 'Ninety-three', hiligaynon: 'Nobentay tres'),
    Phrase(english: 'Ninety-four', hiligaynon: 'Nobentay kwatro'),
    Phrase(english: 'Ninety-five', hiligaynon: 'Nobentay singko'),
    Phrase(english: 'Ninety-six', hiligaynon: 'Nobentay sais'),
    Phrase(english: 'Ninety-seven', hiligaynon: 'Nobentay syete'),
    Phrase(english: 'Ninety-eight', hiligaynon: 'Nobentay otso'),
    Phrase(english: 'Ninety-nine', hiligaynon: 'Nobentay nwebe'),
    Phrase(english: 'One hundred', hiligaynon: 'Isa ka gatos'),
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
