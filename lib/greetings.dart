import 'package:flutter/material.dart';
import 'phrase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Greetings2Page extends StatefulWidget {
  const Greetings2Page({super.key});

  @override
  _Greetings2PageState createState() => _Greetings2PageState();
}

class _Greetings2PageState extends State<Greetings2Page> {
  final List<Phrase> greetings = [
    Phrase(english: "Hello", hiligaynon: "Kamusta"),
    Phrase(english: "Hi", hiligaynon: "Hi"),
    Phrase(english: "Good morning", hiligaynon: "Maayong aga"),
    Phrase(english: "Good afternoon", hiligaynon: "Maayong hapon"),
    Phrase(english: "Good evening", hiligaynon: "Maayong gab-i"),
    Phrase(english: "How are you?", hiligaynon: "Kamusta ka?"),
    Phrase(english: "I'm fine", hiligaynon: "Maayo man ko"),
    Phrase(english: "Nice to meet you", hiligaynon: "Nalipay ako nga nakilala ka"),
    Phrase(english: "Long time no see", hiligaynon: "Dugay na nga wala ta nagkitaay"),
    Phrase(english: "Welcome", hiligaynon: "Dayon"),
    Phrase(english: "Welcome back", hiligaynon: "Dayon liwat"),
    Phrase(english: "Good to see you", hiligaynon: "Maayo nga nakita ta ikaw"),
    Phrase(english: "How’s everything?", hiligaynon: "Kamusta ang tanan?"),
    Phrase(english: "How’s your day?", hiligaynon: "Kamusta adlaw mo?"),
    Phrase(english: "How have you been?", hiligaynon: "Kamusta ka na?"),
    Phrase(english: "Happy birthday", hiligaynon: "Malipayon nga kaadlawan"),
    Phrase(english: "Happy anniversary", hiligaynon: "Malipayon nga anibersaryo"),
    Phrase(english: "Merry Christmas", hiligaynon: "Malipayong Paskwa"),
    Phrase(english: "Happy New Year", hiligaynon: "Malipayon nga Bag-ong Tuig"),
    Phrase(english: "Congratulations", hiligaynon: "Pagdayaw"),
    Phrase(english: "Best wishes", hiligaynon: "Pinakamaayo nga handum"),
    Phrase(english: "Have a nice day", hiligaynon: "Maayo nga adlaw sa imo"),
    Phrase(english: "Have a safe trip", hiligaynon: "Halong sa imo biyahe"),
    Phrase(english: "Take care", hiligaynon: "Halong gid"),
    Phrase(english: "Get well soon", hiligaynon: "Mag-ayo ka gid dayon"),
    Phrase(english: "Goodbye", hiligaynon: "Ba-baye"),
    Phrase(english: "See you", hiligaynon: "Kitaay ta liwat"),
    Phrase(english: "See you later", hiligaynon: "Kitaay ta liwat sa dason"),
    Phrase(english: "See you tomorrow", hiligaynon: "Kitaay ta buwas"),
    Phrase(english: "Good night", hiligaynon: "Maayong gab-i"),
    Phrase(english: "Sweet dreams", hiligaynon: "Matam-is nga damgo"),
    Phrase(english: "What’s up?", hiligaynon: "Ano balita?"),
    Phrase(english: "Pleased to meet you", hiligaynon: "Nalipay ako nga nakilala ka"),
    Phrase(english: "How’s life?", hiligaynon: "Kamusta kabuhi mo?"),
    Phrase(english: "All good?", hiligaynon: "Okay lang tanan?"),
    Phrase(english: "It’s been a while", hiligaynon: "Dugay na wala ta nagkita"),
    Phrase(english: "You look great", hiligaynon: "Nami ikaw subong"),
    Phrase(english: "You're early", hiligaynon: "Temprano ka"),
    Phrase(english: "You're late", hiligaynon: "Ulahi ka"),
    Phrase(english: "Just in time", hiligaynon: "Eksakto lang"),
    Phrase(english: "Have fun", hiligaynon: "Mag-enjoy ka"),
    Phrase(english: "Good luck", hiligaynon: "Maayong palad"),
    Phrase(english: "Rest well", hiligaynon: "Pahuway gid"),
    Phrase(english: "Enjoy your day", hiligaynon: "Mag-enjoy ka sa imo adlaw"),
    Phrase(english: "Happy holidays", hiligaynon: "Malipayon nga bakasyon"),
    Phrase(english: "Have a blessed day", hiligaynon: "Pagpakamaayo sa imo adlaw"),
    Phrase(english: "Bless you", hiligaynon: "Pagpakamaayo"),
    Phrase(english: "Welcome home", hiligaynon: "Dayon sa inyo balay"),
  ];

  
  Set<String> favoriteIds = {};

  @override
  void initState() {
    super.initState();
    
    FirebaseFirestore.instance.collection('favorites').snapshots().listen((snapshot) {
      setState(() {
        favoriteIds = snapshot.docs
            .map((doc) => '${doc['english']}_${doc['hiligaynon']}')
            .toSet();
      });
    });
  }

  void toggleFavorite(Phrase phrase) {
    final docId = '${phrase.english}_${phrase.hiligaynon}';
    final docRef = FirebaseFirestore.instance.collection('favorites').doc(docId);
    final isFavorite = favoriteIds.contains(docId);

    setState(() {
      if (isFavorite) {
        favoriteIds.remove(docId);
      } else {
        favoriteIds.add(docId);
      }
    });

    if (isFavorite) {
      docRef.delete().catchError((_) {
        setState(() => favoriteIds.add(docId));
      });
    } else {
      docRef.set({
        'english': phrase.english,
        'hiligaynon': phrase.hiligaynon,
        'timestamp': FieldValue.serverTimestamp(),
      }).catchError((_) {
        setState(() => favoriteIds.remove(docId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings'),
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
                itemCount: greetings.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = greetings[index];
                  final docId = '${phrase.english}_${phrase.hiligaynon}';
                  final isFavorite = favoriteIds.contains(docId);

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
