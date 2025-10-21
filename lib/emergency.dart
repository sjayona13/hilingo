import 'package:flutter/material.dart';
import 'phrase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seeall.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  final List<Phrase> phrases = [
    Phrase(english: "Help!", hiligaynon: "Bulig!"),
    Phrase(english: "Call the police", hiligaynon: "Tawgi ang pulis"),
    Phrase(english: "Call an ambulance", hiligaynon: "Tawgi ang ambulansya"),
    Phrase(english: "I'm lost", hiligaynon: "Nagtalang ako"),
    Phrase(english: "I need help", hiligaynon: "Kinahanglan ko sang bulig"),
    Phrase(english: "There’s a fire", hiligaynon: "May sunog"),
    Phrase(english: "I'm sick", hiligaynon: "Gamasakit ako"),
    Phrase(english: "Where is the hospital?", hiligaynon: "Diin ang ospital?"),
    Phrase(english: "I had an accident", hiligaynon: "Naaksidente ako"),
    Phrase(english: "Please hurry", hiligaynon: "Palihog dasiga"),
    Phrase(english: "I need a doctor", hiligaynon: "Kinahanglan ko sang doktor"),
    Phrase(english: "I was robbed", hiligaynon: "Ginkawatan ako"),
    Phrase(english: "I need a lawyer", hiligaynon: "Kinahanglan ko sang abogado"),
    Phrase(english: "It's urgent", hiligaynon: "Importante ini"),
    Phrase(english: "Stay calm", hiligaynon: "Kalma lang"),
    Phrase(english: "Don't panic", hiligaynon: "Indi magpanic"),
    Phrase(english: "I'm bleeding", hiligaynon: "Ginadugo ko"),
    Phrase(english: "I can't breathe", hiligaynon: "Indi ako kaginhawa"),
    Phrase(english: "Do you speak English?", hiligaynon: "Makahambal ka English?"),
    Phrase(english: "Where am I?", hiligaynon: "Diin ako?"),
    Phrase(english: "What's your name?", hiligaynon: "Ano imo ngalan?"),
    Phrase(english: "Call my family", hiligaynon: "Tawgi pamilya ko"),
    Phrase(english: "It's an emergency", hiligaynon: "Isa ini ka emerhensya"),
    Phrase(english: "I'm okay now", hiligaynon: "Okay na ako"),
    Phrase(english: "Where is the nearest clinic?", hiligaynon: "Diin ang malapit nga klinika?"),
    Phrase(english: "He’s unconscious", hiligaynon: "Wala siya animo"),
    Phrase(english: "She fainted", hiligaynon: "Nalipong siya"),
    Phrase(english: "I need water", hiligaynon: "Kinahanglan ko sang tubig"),
    Phrase(english: "There’s been a crime", hiligaynon: "May krimen nga natabo"),
    Phrase(english: "Call fire department", hiligaynon: "Tawga ang bombero"),
    Phrase(english: "Earthquake!", hiligaynon: "Linog!"),
    Phrase(english: "Flood!", hiligaynon: "Baha!"),
    Phrase(english: "I’m allergic", hiligaynon: "May allergy ako"),
    Phrase(english: "Take me to the hospital", hiligaynon: "Dal-a ako sa ospital"),
    Phrase(english: "Where is the exit?", hiligaynon: "Diin ang gwaan?"),
    Phrase(english: "Stay with me", hiligaynon: "Updi ako"),
    Phrase(english: "I need medicine", hiligaynon: "Kinahanglan ko bulong"),
    Phrase(english: "She’s hurt", hiligaynon: "Nasamaran siya"),
    Phrase(english: "Fire!", hiligaynon: "Kalayo!"),
    Phrase(english: "We need help", hiligaynon: "Kinahanglan namon sang bulig"),
    Phrase(english: "Do you have a first aid kit?", hiligaynon: "May first aid kit ka?"),
    Phrase(english: "I'm scared", hiligaynon: "Nahadlok ako"),
    Phrase(english: "I think I'm in trouble", hiligaynon: "May problema ako"),
    Phrase(english: "Where is the emergency exit?", hiligaynon: "Diin ang emergency exit?"),
    Phrase(english: "Where can I find help?", hiligaynon: "Diin ko makakita bulig?"),
    Phrase(english: "Call 911", hiligaynon: "Tawgi ang 911"),
    Phrase(english: "I need an ambulance immediately", hiligaynon: "Kinahanglan ko sang ambulansya dayon"),
    Phrase(english: "There’s been an accident", hiligaynon: "May aksidente nga natabo"),
    Phrase(english: "Someone is injured", hiligaynon: "May nasamaran nga tawo"),
    Phrase(english: "I need police assistance", hiligaynon: "Kinahanglan ko sang bulig sang pulis"),
    Phrase(english: "Help me escape", hiligaynon: "Buligi ko makapalagyo"),
    Phrase(english: "Fire alarm!", hiligaynon: "Alarm sa kalayo!"),
    Phrase(english: "I’m trapped", hiligaynon: "Naipit ako"),
    Phrase(english: "Call the coast guard", hiligaynon: "Tawga ang coast guard"),
    Phrase(english: "There’s a robbery", hiligaynon: "May kawatan"),
    Phrase(english: "Someone is threatening me", hiligaynon: "May nagatuyo magdaug sa akon"),
    Phrase(english: "I need evacuation", hiligaynon: "Kinahanglan ko i-evacuate"),
    Phrase(english: "There’s a gas leak", hiligaynon: "May leak sang gas"),
    Phrase(english: "I need a stretcher", hiligaynon: "Kinahanglan ko sang stretcher"),
    Phrase(english: "Call a paramedic", hiligaynon: "Tawgi ang paramedic"),
    Phrase(english: "I can’t move", hiligaynon: "Indi ako makahulag"),
    Phrase(english: "My leg is broken", hiligaynon: "Nabali ang tiil ko"),
    Phrase(english: "My arm is broken", hiligaynon: "Nabali ang kamot ko"),
    Phrase(english: "I feel faint", hiligaynon: "Daw malipong ako"),
    Phrase(english: "Someone fainted", hiligaynon: "May nalipong"),
    Phrase(english: "There’s a landslide", hiligaynon: "May landslide"),
    Phrase(english: "There’s a tsunami", hiligaynon: "May tsunami"),
    Phrase(english: "I need rescue", hiligaynon: "Kinahanglan ko sang rescue"),
    Phrase(english: "My friend is unconscious", hiligaynon: "Wala kabalo ang akon amigo/amiga"),
    Phrase(english: "Call search and rescue", hiligaynon: "Tawgi ang search and rescue"),
    Phrase(english: "The building is collapsing", hiligaynon: "Nagakaguba ang building"),
    Phrase(english: "Someone is trapped under debris", hiligaynon: "May naipit sa debris"),
    Phrase(english: "I need water urgently", hiligaynon: "Kinahanglan ko tubig dayon"),
    Phrase(english: "There’s a power outage", hiligaynon: "Wala kuryente"),
    Phrase(english: "Help the injured", hiligaynon: "Buligi ang nasamaran"),
    Phrase(english: "Call a lifeguard", hiligaynon: "Tawga ang lifeguard"),
    Phrase(english: "There’s a car crash", hiligaynon: "May nagbunggoanay nga salakyan"),
    Phrase(english: "I need CPR", hiligaynon: "Kinahanglan ko sang CPR"),
    Phrase(english: "Call for backup", hiligaynon: "Tawga ang backup"),
    Phrase(english: "There’s smoke", hiligaynon: "May aso"),
    Phrase(english: "There’s a chemical spill", hiligaynon: "May chemical spill"),
    Phrase(english: "I’m trapped in an elevator", hiligaynon: "Naipit ako sa elevator"),
    Phrase(english: "I need immediate medical attention", hiligaynon: "Kinahanglan ko dayon sang medical attention"),
    Phrase(english: "Someone is bleeding heavily", hiligaynon: "May nagadugo sing madamo"),
    Phrase(english: "Evacuate immediately", hiligaynon: "Evacuate dayon"),
    Phrase(english: "Don’t touch electrical wires", hiligaynon: "Indi pagtandoga ang kable"),
    Phrase(english: "There’s a robbery in progress", hiligaynon: "May kawatan nga nagahimo subong"),
    Phrase(english: "Keep calm and wait", hiligaynon: "Kalma lang kag hulat"),
    Phrase(english: "Move to higher ground", hiligaynon: "Saylo sa mataas nga lugar"),

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
        title: const Text('Emergency'),
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
