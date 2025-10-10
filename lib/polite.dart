import 'package:flutter/material.dart';
import 'phrase.dart';
import 'seeall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PolitePage extends StatefulWidget {
  const PolitePage({super.key});

  @override
  _PolitePageState createState() => _PolitePageState();
}

class _PolitePageState extends State<PolitePage> {
  final List<Phrase> phrases = [
    Phrase(english: 'Please.', hiligaynon: 'Palihog.'),
    Phrase(english: 'Thank you.', hiligaynon: 'Salamat.'),
    Phrase(english: 'Excuse me.', hiligaynon: 'Pasensya.'),
    Phrase(english: 'I’m sorry.', hiligaynon: 'Pasayloa ako.'),
    Phrase(english: 'Can I?', hiligaynon: 'Pwede ko?'),
    Phrase(english: 'May I help you?', hiligaynon: 'Pwede ko ikaw buligan?'),
    Phrase(english: 'Yes, please.', hiligaynon: 'Oo, palihog.'),
    Phrase(english: 'No, thank you.', hiligaynon: 'Indi, salamat.'),
    Phrase(english: 'I appreciate it.', hiligaynon: 'Gina-pasalamatan ko.'),
    Phrase(english: 'Be careful.', hiligaynon: 'Maghalong ka.'),
    Phrase(english: 'Have a nice day.', hiligaynon: 'Maayong adlaw.'),
    Phrase(english: 'Good morning.', hiligaynon: 'Maayong aga.'),
    Phrase(english: 'Good afternoon.', hiligaynon: 'Maayong hapon.'),
    Phrase(english: 'Good evening.', hiligaynon: 'Maayong gab-i.'),
    Phrase(english: 'Good night.', hiligaynon: 'Maayong gab-i.'),
    Phrase(english: 'You’re welcome.', hiligaynon: 'Walay sapayan.'),
    Phrase(english: 'Nice to meet you.', hiligaynon: 'Nalipay ako nga nakilala ka.'),
    Phrase(english: 'Sorry for the inconvenience.', hiligaynon: 'Pasensya sa abala.'),
    Phrase(english: 'Can I sit here?', hiligaynon: 'Pwede ko diri magpungko?'),
    Phrase(english: 'Is it okay?', hiligaynon: 'Pwede lang?'),
    Phrase(english: 'Go ahead.', hiligaynon: 'Sige lang.'),
    Phrase(english: 'After you.', hiligaynon: 'Ikaw anay.'),
    Phrase(english: 'Allow me.', hiligaynon: 'Pasugti ako.'),
    Phrase(english: 'Bless you.', hiligaynon: 'Pagpakamaayo ikaw.'),
    Phrase(english: 'You’re very kind.', hiligaynon: 'Buot ka gid.'),
    Phrase(english: 'I didn’t mean to.', hiligaynon: 'Wala ko tuyo.'),
    Phrase(english: 'With all due respect.', hiligaynon: 'Sa bug-os ko nga pagrespeto.'),
    Phrase(english: 'Let me know.', hiligaynon: 'Pahibalo-a ako.'),
    Phrase(english: 'I understand.', hiligaynon: 'Gina-intindi ko.'),
    Phrase(english: 'I don’t understand.', hiligaynon: 'Wala ko kaintindi.'),
    Phrase(english: 'Could you repeat that?', hiligaynon: 'Pwede mo ina liwaton?'),
    Phrase(english: 'Sorry I’m late.', hiligaynon: 'Pasensya, dugay ako.'),
    Phrase(english: 'Please wait.', hiligaynon: 'Palihog hulat.'),
    Phrase(english: 'Please come in.', hiligaynon: 'Palihog sulod.'),
    Phrase(english: 'Please take a seat.', hiligaynon: 'Palihog pungko.'),
    Phrase(english: 'I’ll be right back.', hiligaynon: 'Balik ako dayon.'),
    Phrase(english: 'Thanks for waiting.', hiligaynon: 'Salamat sa paghulat.'),
    Phrase(english: 'No problem.', hiligaynon: 'Wala problema.'),
    Phrase(english: 'It’s okay.', hiligaynon: 'Okay lang.'),
    Phrase(english: 'That’s very nice of you.', hiligaynon: 'Buotan ka gid.'),
    Phrase(english: 'Much appreciated.', hiligaynon: 'Daku nga pasalamat.'),
    Phrase(english: 'Please forgive me.', hiligaynon: 'Palihog patawara ako.'),
    Phrase(english: 'That’s alright.', hiligaynon: 'Okay lang ina.'),
    Phrase(english: 'Do you mind?', hiligaynon: 'Okay lang sa imo?'),
    Phrase(english: 'It was my pleasure.', hiligaynon: 'Kalipay ko ina.'),
    Phrase(english: 'Let’s respect each other.', hiligaynon: 'Magrespetoay kita.'),
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
      favorites = snapshot.docs
          .map((doc) => Phrase(
                english: doc['english'],
                hiligaynon: doc['hiligaynon'],
              ))
          .toList();
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
        title: const Text('Polite Expressions'),
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
