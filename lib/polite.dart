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
    Phrase(english: 'I’m sorry.', hiligaynon: 'Pasensyahi ako.'),
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
    Phrase(english: 'You’re welcome.', hiligaynon: 'Wala sang ano man.'),
    Phrase(english: 'Nice to meet you.', hiligaynon: 'Nalipay ako nga nakilala ka.'),
    Phrase(english: 'Sorry for the inconvenience.', hiligaynon: 'Pasensya sa abala.'),
    Phrase(english: 'Can I sit here?', hiligaynon: 'Pwede ko diri magpungko?'),
    Phrase(english: 'Is it okay?', hiligaynon: 'Okay lang?'),
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
    Phrase(english: 'Let’s respect each other.', hiligaynon: 'Magrespetohanay kita.'),
    Phrase(english: 'Please be patient.', hiligaynon: 'Palihog magpa-pasensya.'),
    Phrase(english: 'Excuse my mistake.', hiligaynon: 'Pasensya sa akon sala.'),
    Phrase(english: 'May I help you with that?', hiligaynon: 'Pwede ko ikaw buligan sina?'),
    Phrase(english: 'Thank you very much.', hiligaynon: 'Daku gid nga salamat.'),
    Phrase(english: 'I’m grateful.', hiligaynon: 'Gina-pasalamatan ko gid.'),
    Phrase(english: 'I apologize.', hiligaynon: 'Nagapangayo ako pasaylo.'),
    Phrase(english: 'Please accept my apologies.', hiligaynon: 'Palihog batona akon pagpasenya.'),
    Phrase(english: 'Pardon me.', hiligaynon: 'Pasensyahi ako.'),
    Phrase(english: 'It’s an honor.', hiligaynon: 'Isang dungog ini.'),
    Phrase(english: 'I’m humbled.', hiligaynon: 'Nagapaluya ako.'),
    Phrase(english: 'May I join you?', hiligaynon: 'Pwede ko mag-upod sa imo?'),
    Phrase(english: 'Please help yourself.', hiligaynon: 'Palihog buligi ang imo kaugalingon.'),
    Phrase(english: 'I truly appreciate it.', hiligaynon: 'Tuman gid nga gina-pasalamatan ko.'),
    Phrase(english: 'Thank you for your time.', hiligaynon: 'Salamat sa imo oras.'),
    Phrase(english: 'Please forgive my delay.', hiligaynon: 'Palihog patawara ako sa dugay.'),
    Phrase(english: 'I didn’t mean to trouble you.', hiligaynon: 'Wala ko tuyo nga magpalisod sa imo.'),
    Phrase(english: 'Thank you for your understanding.', hiligaynon: 'Salamat sa imo pag-intindi.'),
    Phrase(english: 'I’m honored to meet you.', hiligaynon: 'Nalipay ako nga makilala ka.'),
    Phrase(english: 'Please allow me to introduce myself.', hiligaynon: 'Palihog pasugti ako nga ipakilala ang akon kaugalingon.'),
    Phrase(english: 'It’s very kind of you.', hiligaynon: 'Buotan ka gid.'),
    Phrase(english: 'Please take care.', hiligaynon: 'Palihog maghalong.'),
    Phrase(english: 'I appreciate your help.', hiligaynon: 'Gina-pasalamatan ko gid ang imo bulig.'),
    Phrase(english: 'Thank you for your patience.', hiligaynon: 'Salamat sa imo pasensya.'),
    Phrase(english: 'Please don’t worry.', hiligaynon: 'Palihog indi magproblema.'),
    Phrase(english: 'I respect your opinion.', hiligaynon: 'Gina-respeto ko ang imo opinion.'),
    Phrase(english: 'It’s a pleasure to help you.', hiligaynon: 'Kalipay ko ikaw buligan.'),
    Phrase(english: 'Please feel free.', hiligaynon: 'Palihog, indi magduha-duha.'),
    Phrase(english: 'Thank you for your support.', hiligaynon: 'Salamat sa imo suporta.'),
    Phrase(english: 'I hope it’s okay.', hiligaynon: 'Nagalaum ako nga okay lang ini.'),
    Phrase(english: 'Please accept my respect.', hiligaynon: 'Palihog dawata ang akon respeto.'),
    Phrase(english: 'I am at your service.', hiligaynon: 'Ari ako para sa imo serbisyo.'),
    Phrase(english: 'Thank you for your consideration.', hiligaynon: 'Salamat sa imo konsiderasyon.'),
    Phrase(english: 'Please forgive me if I’m wrong.', hiligaynon: 'Palihog patawara ako kon sala ako.'),
    Phrase(english: 'I appreciate your kindness.', hiligaynon: 'Gina-pasalamatan ko ang imo buot.'),
    Phrase(english: 'Please take it easy.', hiligaynon: 'Palihog, indi magdali-dali.'),
    Phrase(english: 'I’m honored by your help.', hiligaynon: 'Nalipay ako sang imo bulig.'),
    Phrase(english: 'Please accept this gift.', hiligaynon: 'Palihog dawata ini nga regalo.'),
    Phrase(english: 'Thank you for inviting me.', hiligaynon: 'Salamat sa pag-imbitar sa akon.'),
    Phrase(english: 'Please excuse me for leaving early.', hiligaynon: 'Palihog pasensyahi ako kay mauna ako halin.'),
    Phrase(english: 'I am grateful for your guidance.', hiligaynon: 'Gina-pasalamatan ko gid ang imo giya.'),
    Phrase(english: 'It’s a pleasure meeting you.', hiligaynon: 'Kalipay ko nga makilala ka.'),
    Phrase(english: 'Thank you for your hospitality.', hiligaynon: 'Salamat sa imo pagbaton.'),
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
