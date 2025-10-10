import 'package:flutter/material.dart';
import 'phrase.dart';
import 'seeall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final List<Phrase> phrases = [
    Phrase(english: 'How much is this?', hiligaynon: 'Tagpila ini?'),
    Phrase(english: 'Can I get a discount?', hiligaynon: 'Pwede makadiscount?'),
    Phrase(english: 'That’s too expensive.', hiligaynon: 'Mahal kaayo na.'),
    Phrase(english: 'I’m just looking.', hiligaynon: 'Nagatan-aw lang ko.'),
    Phrase(english: 'I’ll buy it.', hiligaynon: 'Baklon ko ni.'),
    Phrase(english: 'Do you accept cards?', hiligaynon: 'Ga-accept kamo card?'),
    Phrase(english: 'Cash only.', hiligaynon: 'Cash lang.'),
    Phrase(english: 'Where is the cashier?', hiligaynon: 'Diin ang cashier?'),
    Phrase(english: 'Can I return this?', hiligaynon: 'Pwede ko ni ibalik?'),
    Phrase(english: 'I need a bag.', hiligaynon: 'Kinahanglan ko sang bag.'),
    Phrase(english: 'Receipt, please.', hiligaynon: 'Resibo, palihog.'),
    Phrase(english: 'I’m looking for clothes.', hiligaynon: 'Nangita ko bayo.'),
    Phrase(english: 'This is too small.', hiligaynon: 'Gamay ini para sa akon.'),
    Phrase(english: 'This is too big.', hiligaynon: 'Dako ini para sa akon.'),
    Phrase(english: 'Do you have other colors?', hiligaynon: 'May lain pa kamo nga kolor?'),
    Phrase(english: 'I want this in black.', hiligaynon: 'Gusto ko ini nga itom.'),
    Phrase(english: 'Is this on sale?', hiligaynon: 'Sale ni siya?'),
    Phrase(english: 'I’ll think about it.', hiligaynon: 'Panumdoman ko anay.'),
    Phrase(english: 'What size is this?', hiligaynon: 'Ano nga size sini?'),
    Phrase(english: 'Can I try this?', hiligaynon: 'Pwede ko ni masul-ob?'),
    Phrase(english: 'Is this fresh?', hiligaynon: 'Presko ni siya?'),
    Phrase(english: 'I want 1 kilo.', hiligaynon: 'Isa ka kilo palihog.'),
    Phrase(english: 'Do you have change?', hiligaynon: 'May sinsilyo kamo?'),
    Phrase(english: 'Too cheap!', hiligaynon: 'Barato gid!'),
    Phrase(english: 'Where is the fitting room?', hiligaynon: 'Diin ang sul-ubanan?'),
    Phrase(english: 'Do you sell shoes?', hiligaynon: 'Nagabaligya kamo sapatos?'),
    Phrase(english: 'I’m not interested.', hiligaynon: 'Wala ako sang interes.'),
    Phrase(english: 'Do you have a bigger one?', hiligaynon: 'May mas dako kamo sini?'),
    Phrase(english: 'Where is the grocery?', hiligaynon: 'Diin ang grocery?'),
    Phrase(english: 'I want to buy fruits.', hiligaynon: 'Gusto ko magbakal sang prutas.'),
    Phrase(english: 'Do you deliver?', hiligaynon: 'Nagadeliver kamo?'),
    Phrase(english: 'Where can I pay?', hiligaynon: 'Diin ko mabayran?'),
    Phrase(english: 'This is too heavy.', hiligaynon: 'Bug-at ini.'),
    Phrase(english: 'Please wrap this.', hiligaynon: 'Paki-putos ini.'),
    Phrase(english: 'I lost my receipt.', hiligaynon: 'Nadula ko ang resibo ko.'),
    Phrase(english: 'Do you have plastic?', hiligaynon: 'May plastic kamo?'),
    Phrase(english: 'Buy 1 take 1?', hiligaynon: 'Buy 1 take 1 ni?'),
    Phrase(english: 'Promo price?', hiligaynon: 'Presyo sang promo?'),
    Phrase(english: 'Available pa ni?', hiligaynon: 'May ara pa sini?'),
    Phrase(english: 'It’s out of stock.', hiligaynon: 'Wala na stock.'),
    Phrase(english: 'Do you sell this online?', hiligaynon: 'Available ni online?'),
    Phrase(english: 'Is this brand new?', hiligaynon: 'Bago ni siya?'),
    Phrase(english: 'Second hand?', hiligaynon: 'Ginamit na ni?'),
    Phrase(english: 'Can I get a receipt?', hiligaynon: 'Pwede ko mangayo resibo?'),
    Phrase(english: 'Can I see the price tag?', hiligaynon: 'Pwede ko makita ang price tag?'),
    Phrase(english: 'I don’t need a bag.', hiligaynon: 'Indi ko kinahanglan bag.'),
    Phrase(english: 'I’m in a hurry.', hiligaynon: 'Nagadalî ako.'),
    Phrase(english: 'Do you take GCash?', hiligaynon: 'Gina-accept ninyo ang GCash?'),
    Phrase(english: 'That’s too much.', hiligaynon: 'Sobra na ina.'),
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
      favorites = snapshot.docs.map((doc) => Phrase(
        english: doc['english'],
        hiligaynon: doc['hiligaynon'],
      )).toList();
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
        title: const Text('Shopping'),
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