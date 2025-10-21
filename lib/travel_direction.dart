import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';

class TravelDirectionPage extends StatefulWidget {
  const TravelDirectionPage({super.key});

  @override
  State<TravelDirectionPage> createState() => _TravelDirectionPageState();
}

class _TravelDirectionPageState extends State<TravelDirectionPage> {
  final List<Phrase> travelPhrases = [
    Phrase(english: "Where is the bus stop?", hiligaynon: "Diin ang sakayan?"),
    Phrase(english: "I need a taxi", hiligaynon: "Kinahanglan ko sang taxi"),
    Phrase(english: "How much is the fare?", hiligaynon: "Tagpila ang plite?"),
    Phrase(english: "Where is the airport?", hiligaynon: "Diin ang airport?"),
    Phrase(english: "Left", hiligaynon: "Wala"),
    Phrase(english: "Right", hiligaynon: "Tu-o"),
    Phrase(english: "Straight ahead", hiligaynon: "Deretso lang"),
    Phrase(english: "Stop here", hiligaynon: "Pundo diri"),
    Phrase(english: "Go faster", hiligaynon: "Dasiga gamay"),
    Phrase(english: "Go slower", hiligaynon: "Hinay gamay"),
    Phrase(english: "Where are we going?", hiligaynon: "Diin kita pakadto?"),
    Phrase(english: "This way", hiligaynon: "Paagi diri"),
    Phrase(english: "That way", hiligaynon: "Paagi didto"),
    Phrase(english: "Turn left", hiligaynon: "Liko sa wala"),
    Phrase(english: "Turn right", hiligaynon: "Liko sa tu-o"),
    Phrase(english: "Is it far?", hiligaynon: "Layo pa?"),
    Phrase(english: "Is it near?", hiligaynon: "Lapit lang?"),
    Phrase(english: "I’m lost", hiligaynon: "Natalang ako"),
    Phrase(english: "Can you help me?", hiligaynon: "Pwede ka bulig sa akon?"),
    Phrase(english: "Where is the hotel?", hiligaynon: "Diin ang hotel?"),
    Phrase(english: "I want to go here", hiligaynon: "Gusto ko magkadto diri"),
    Phrase(english: "I need directions", hiligaynon: "Kinahanglan ko sang direksyon"),
    Phrase(english: "Near the market", hiligaynon: "Lapit sa tinda"),
    Phrase(english: "By the church", hiligaynon: "Kilid sang simbahan"),
    Phrase(english: "Next to the bank", hiligaynon: "Tupad sang bangko"),
    Phrase(english: "Opposite the mall", hiligaynon: "Atubang sang mall"),
    Phrase(english: "Is there parking?", hiligaynon: "May parking dira?"),
    Phrase(english: "Which road?", hiligaynon: "Ano nga dalan?"),
    Phrase(english: "I will walk", hiligaynon: "Malakat lang ko"),
    Phrase(english: "I will ride", hiligaynon: "Masakay ako"),
    Phrase(english: "Take me to this address", hiligaynon: "Dal-a ko diri nga lugar"),
    Phrase(english: "It's on the left side", hiligaynon: "Ara sa wala nga bahin"),
    Phrase(english: "It's on the right side", hiligaynon: "Ara sa tu-o nga bahin"),
    Phrase(english: "At the corner", hiligaynon: "Sa kanto"),
    Phrase(english: "Go down here", hiligaynon: "Naug ka diri"),
    Phrase(english: "Get on there", hiligaynon: "Sakay ka didto"),
    Phrase(english: "Where is the port?", hiligaynon: "Diin ang pantalan?"),
    Phrase(english: "What time is the trip?", hiligaynon: "Anong oras ang byahe?"),
    Phrase(english: "Do I need a ticket?", hiligaynon: "Kinahanglan ko ticket?"),
    Phrase(english: "Can I book online?", hiligaynon: "Pwede online mag-book?"),
    Phrase(english: "Is it safe?", hiligaynon: "Indi delikado?"),
    Phrase(english: "Is it open?", hiligaynon: "Bukas pa?"),
    Phrase(english: "We are here", hiligaynon: "Ari na kita"),
    Phrase(english: "You're going the wrong way", hiligaynon: "Sala imo gina-agyan"),
    Phrase(english: "Let’s go", hiligaynon: "Panaw ta"),
    Phrase(english: "I'm on my way", hiligaynon: "Paadto na ko"),
    Phrase(english: "Where is the bus schedule?", hiligaynon: "Diin ang iskedyul sang bus?"),
    Phrase(english: "Is there Wi-Fi here?", hiligaynon: "May Wi-Fi bala diri?"),
    Phrase(english: "How much is the luggage fee?", hiligaynon: "Tagpila ang bayad sa bagahe?"),
    Phrase(english: "Do you have a locker?", hiligaynon: "May locker bala kamo?"),
    Phrase(english: "Where can I rent a scooter?", hiligaynon: "Diin ko pwede mag-abang sang scooter?"),
    Phrase(english: "Where can I rent a bicycle?", hiligaynon: "Diin ko pwede mag-abang sang bisikleta?"),
    Phrase(english: "Where is the taxi stand?", hiligaynon: "Diin ang taxi stand?"),
    Phrase(english: "Where is the bus ticket counter?", hiligaynon: "Diin ang ticket counter sang bus?"),
    Phrase(english: "Where is the information desk?", hiligaynon: "Diin ang information desk?"),
    Phrase(english: "I need a hotel", hiligaynon: "Kinahanglan ko sang hotel"),
    Phrase(english: "Do you have rooms available?", hiligaynon: "May available nga kwarto kamo?"),
    Phrase(english: "I want a single room", hiligaynon: "Gusto ko single nga kwarto"),
    Phrase(english: "I want a double room", hiligaynon: "Gusto ko double nga kwarto"),
    Phrase(english: "Do you have a family room?", hiligaynon: "May family room bala kamo?"),
    Phrase(english: "How much per night?", hiligaynon: "Tagpila kada gab-i?"),
    Phrase(english: "Can I see the room?", hiligaynon: "Pwede ko makita ang kwarto?"),
    Phrase(english: "I want to book a room", hiligaynon: "Gusto ko mag-book sang kwarto"),
    Phrase(english: "Do you accept credit cards?", hiligaynon: "Gina-accept niyo bala ang credit card?"),
    Phrase(english: "Is breakfast included?", hiligaynon: "Dala bala ang pamahaw sa presyo?"),
    Phrase(english: "What time is check-in?", hiligaynon: "San-o ang check-in?"),
    Phrase(english: "What time is check-out?", hiligaynon: "San-o ang check-out?"),
    Phrase(english: "Where can I find a taxi?", hiligaynon: "Diin ko makakita taxi?"),
    Phrase(english: "Can you call a taxi for me?", hiligaynon: "Pwede ka tawgon taxi para sa akon?"),
    Phrase(english: "I need a ride to the airport", hiligaynon: "Kinahanglan ko sakyan pakadto airport"),
    Phrase(english: "I need a ride to the hotel", hiligaynon: "Kinahanglan ko sakyan pakadto hotel"),
    Phrase(english: "Where is the tourist information center?", hiligaynon: "Diin ang tourist information center?"),
    Phrase(english: "Are there guided tours?", hiligaynon: "May guided tour bala?"),
    Phrase(english: "How much is the tour?", hiligaynon: "Tagpila ang tour?"),
    Phrase(english: "Is the tour in English?", hiligaynon: "Ingles bala ang tour?"),
    Phrase(english: "Where is the museum?", hiligaynon: "Diin ang museo?"),
    Phrase(english: "Where is the art gallery?", hiligaynon: "Diin ang art gallery?"),
    Phrase(english: "Where is the historical site?", hiligaynon: "Diin ang historical site?"),
    Phrase(english: "Where is the beach?", hiligaynon: "Diin ang baybay?"),
    Phrase(english: "Where is the park?", hiligaynon: "Diin ang parke?"),
    Phrase(english: "Where is the shopping mall?", hiligaynon: "Diin ang mall?"),
    Phrase(english: "Where is the market?", hiligaynon: "Diin ang tinda?"),
    Phrase(english: "Where is the bank?", hiligaynon: "Diin ang bangko?"),
    Phrase(english: "Where is the pharmacy?", hiligaynon: "Diin ang botika?"),
    Phrase(english: "Where is the hospital?", hiligaynon: "Diin ang ospital?"),
    Phrase(english: "Where is the police station?", hiligaynon: "Diin ang police station?"),
    Phrase(english: "Where is the post office?", hiligaynon: "Diin ang post office?"),
    Phrase(english: "I need an ambulance", hiligaynon: "Kinahanglan ko sang ambulansya"),
    Phrase(english: "Where is the exit?", hiligaynon: "Diin ang exit?"),
    Phrase(english: "Where is the entrance?", hiligaynon: "Diin ang entrance?"),
    Phrase(english: "Where is the restroom?", hiligaynon: "Diin ang kasilyas?"),
    Phrase(english: "Where is the elevator?", hiligaynon: "Diin ang elevator?"),
    Phrase(english: "Where is the escalator?", hiligaynon: "Diin ang escalator?"),
    Phrase(english: "Can I take photos?", hiligaynon: "Pwede ko magkuha sang litrato?"),
    Phrase(english: "Where can I buy souvenirs?", hiligaynon: "Diin ko pwede mabakal souvenir?"),
    Phrase(english: "Do you have a guide?", hiligaynon: "May guide bala kamo?"),
    Phrase(english: "Can I join the tour?", hiligaynon: "Pwede ko makasulod sa tour?"),
    Phrase(english: "How long is the tour?", hiligaynon: "Dugay bala ang tour?"),
    Phrase(english: "Where can I rent a boat?", hiligaynon: "Diin ko pwede mag-abang sang barko?"),
    Phrase(english: "Is there a ferry?", hiligaynon: "May ferry bala?"),
    Phrase(english: "Where is the ferry terminal?", hiligaynon: "Diin ang ferry terminal?"),
    Phrase(english: "Do you have a map of the city?", hiligaynon: "May mapa kamo sang syudad?"),
    Phrase(english: "I need a travel guide", hiligaynon: "Kinahanglan ko sang travel guide"),
    Phrase(english: "Where is the scenic view?", hiligaynon: "Diin ang maayo nga talan-awon?"),
    Phrase(english: "I want to rent a car", hiligaynon: "Gusto ko magrenta sang salakyan"),
    Phrase(english: "Where is the parking?", hiligaynon: "Diin ang parkingan?"),
    Phrase(english: "Do you have a shuttle service?", hiligaynon: "May shuttle service bala kamo?"),
    Phrase(english: "How do I get to the nearest station?", hiligaynon: "Paagi paano ko makadto sa pinakamalapit nga estasyon?"),
    Phrase(english: "Is this the right platform?", hiligaynon: "Ini bala ang husto nga platform?"),
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
        title: const Text('Travel and Direction'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), 
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
                itemCount: travelPhrases.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final phrase = travelPhrases[index];
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
