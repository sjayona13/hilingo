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
    Phrase(english: 'I’m looking for clothes.', hiligaynon: 'Gapangita ko bayo.'),
    Phrase(english: 'This is too small.', hiligaynon: 'Gamay ini para sa akon.'),
    Phrase(english: 'This is too big.', hiligaynon: 'Dako ini para sa akon.'),
    Phrase(english: 'Do you have other colors?', hiligaynon: 'May lain pa kamo nga kolor?'),
    Phrase(english: 'I want this in black.', hiligaynon: 'Gusto ko ini nga itom.'),
    Phrase(english: 'Is this on sale?', hiligaynon: 'Sale ni siya?'),
    Phrase(english: 'I’ll think about it.', hiligaynon: 'Panumdoman ko anay.'),
    Phrase(english: 'What size is this?', hiligaynon: 'Ano nga size ini?'),
    Phrase(english: 'Can I try this?', hiligaynon: 'Pwede ko ni masuksok?'),
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
    Phrase(english: 'Where can I pay?', hiligaynon: 'Diin ko pwede mabayran?'),
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
    Phrase(english: "Where can I find this?", hiligaynon: "Diin ko makit-an ini?"),
    Phrase(english: "Do you have this in another size?", hiligaynon: "May lain pa kamo nga size sini?"),
    Phrase(english: "Do you have this in another color?", hiligaynon: "May lain pa kamo nga kolor sini?"),
    Phrase(english: "I want this one.", hiligaynon: "Gusto ko ini."),
    Phrase(english: "Can I pay by card?", hiligaynon: "Pwede ko magbayad gamit card?"),
    Phrase(english: "Do you accept ...?", hiligaynon: "Gina-accept ninyo ang ...?"),
    Phrase(english: "Do you accept coins?", hiligaynon: "Gina-accept ninyo ang sinsilyo?"),
    Phrase(english: "Can I have a bag?", hiligaynon: "Pwede ko makabaton sang bag?"),
    Phrase(english: "Do you sell vegetables?", hiligaynon: "Nagabaligya kamo utan?"),
    Phrase(english: "Do you sell fruits?", hiligaynon: "Nagabaligya kamo prutas?"),
    Phrase(english: "Do you sell meat?", hiligaynon: "Nagabaligya kamo karne?"),
    Phrase(english: "Do you sell fish?", hiligaynon: "Nagabaligya kamo isda?"),
    Phrase(english: "Can I try the sample?", hiligaynon: "Pwede ko matestingan ang sample?"),
    Phrase(english: "Do you sell electronics?", hiligaynon: "Nagabaligya kamo electronics?"),
    Phrase(english: "Do you sell toys?", hiligaynon: "Nagabaligya kamo hampangan?"),
    Phrase(english: "Do you sell souvenirs?", hiligaynon: "Nagabaligya kamo souvenir?"),
    Phrase(english: "Can I reserve this item?", hiligaynon: "Pwede ko i-reserve ini nga item?"),
    Phrase(english: "Do you offer delivery?", hiligaynon: "May delivery kamo?"),
    Phrase(english: "Can you pack this as a gift?", hiligaynon: "Pwede niyo i-putos bilang regalo?"),
    Phrase(english: "Is this included in the promotion?", hiligaynon: "Ari bala ini sa promo?"),
    Phrase(english: "Can I exchange this?", hiligaynon: "Pwede ko ini i-baylohan?"),
    Phrase(english: "Do you offer warranties?", hiligaynon: "May warranty bala kamo?"),
    Phrase(english: "Do you offer refunds?", hiligaynon: "May refund bala kamo?"),
    Phrase(english: "Do you have loyalty points?", hiligaynon: "May loyalty points bala kamo?"),
    Phrase(english: "Can I use my coupon?", hiligaynon: "Pwede ko gamiton ang coupon ko?"),
    Phrase(english: "Do you have new arrivals?", hiligaynon: "May bag-o bala nga abot?"),
    Phrase(english: "Where is the sale section?", hiligaynon: "Diin ang sale section?"),
    Phrase(english: "Can you check if this is available?", hiligaynon: "Pwede mo tan-awon kung available ini?"),
    Phrase(english: "Do you have this in stock?", hiligaynon: "May stock bala kamo sini?"),
    Phrase(english: "Is this item authentic?", hiligaynon: "Tinuod bala ini nga item?"),
    Phrase(english: "Do you provide receipts?", hiligaynon: "Nagahatag kamo sang resibo?"),
    Phrase(english: "Can I get a discount if I buy more?", hiligaynon: "Pwede ko makadiscount kung magbakal ako sang madamo?"),
    Phrase(english: "Do you have a size chart?", hiligaynon: "May size chart bala kamo?"),
    Phrase(english: "Where is the entrance?", hiligaynon: "Diin ang entrance?"),
    Phrase(english: "Where is the exit?", hiligaynon: "Diin ang exit?"),
    Phrase(english: "Do you have this online?", hiligaynon: "May ara bala ini online?"),
    Phrase(english: "Can you gift wrap this?", hiligaynon: "Pwede niyo i-gift wrap ini?"),
    Phrase(english: "Can I pay in installments?", hiligaynon: "Pwede ko bayaran sa installment?"),
    Phrase(english: "Do you have a refund policy?", hiligaynon: "May refund policy bala kamo?"),
    Phrase(english: "Do you have a return policy?", hiligaynon: "May return policy bala kamo?"),
    Phrase(english: "Is this eco-friendly?", hiligaynon: "Eco-friendly bala ini?"),
    Phrase(english: "Do you sell organic products?", hiligaynon: "Nagabaligya kamo organic products?"),
    Phrase(english: "Where can I find accessories?", hiligaynon: "Diin ko makit-an ang accessories?"),
    Phrase(english: "Do you have limited edition items?", hiligaynon: "May limited edition bala kamo?"),
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