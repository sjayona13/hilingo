import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seeall.dart';
import 'phrase.dart';

class TechnologyPage extends StatefulWidget {
  const TechnologyPage({super.key});

  @override
  _TechnologyPageState createState() => _TechnologyPageState();
}

class _TechnologyPageState extends State<TechnologyPage> {
  final List<Phrase> phrases = [
    Phrase(english: 'Do you have Wi-Fi?', hiligaynon: 'May Wi-Fi kamo?'),
    Phrase(english: 'What’s the password?', hiligaynon: 'Ano ang password?'),
    Phrase(english: 'The internet is slow.', hiligaynon: 'Hinay ang internet.'),
    Phrase(english: 'I can’t connect.', hiligaynon: 'Indi ko makakonek.'),
    Phrase(english: 'Can I borrow your phone?', hiligaynon: 'Pwede ko mahulam imo telepono?'),
    Phrase(english: 'Where can I charge?', hiligaynon: 'Diin ko pwede ma-charge?'),
    Phrase(english: 'Do you have a charger?', hiligaynon: 'May charger kamo?'),
    Phrase(english: 'Turn it on.', hiligaynon: 'I-on mo.'),
    Phrase(english: 'Turn it off.', hiligaynon: 'I-off mo.'),
    Phrase(english: 'Open the app.', hiligaynon: 'Buksan ang app.'),
    Phrase(english: 'Close the app.', hiligaynon: 'Isira ang app.'),
    Phrase(english: 'Install this.', hiligaynon: 'I-install ini.'),
    Phrase(english: 'My battery is low.', hiligaynon: 'Lowbat ko'),
    Phrase(english: 'Update your phone.', hiligaynon: 'I-update ang telepono mo.'),
    Phrase(english: 'My phone is broken.', hiligaynon: 'Guba ang telepono ko.'),
    Phrase(english: 'I can’t open it.', hiligaynon: 'Indi ko mabuksan.'),
    Phrase(english: 'The screen is cracked.', hiligaynon: 'Bungi ang screen.'),
    Phrase(english: 'Send me the link.', hiligaynon: 'Ipadala ang link.'),
    Phrase(english: 'I’ll message you.', hiligaynon: 'I-message ta ikaw.'),
    Phrase(english: 'Can we video call?', hiligaynon: 'Pwede kita mag video call?'),
    Phrase(english: 'Where’s the signal?', hiligaynon: 'Diin ang signal?'),
    Phrase(english: 'Restart your phone.', hiligaynon: 'I-restart ang telepono mo.'),
    Phrase(english: 'Take a screenshot.', hiligaynon: 'Mag screenshot.'),
    Phrase(english: 'Mute your mic.', hiligaynon: 'I-mute ang mic mo.'),
    Phrase(english: 'Unmute your mic.', hiligaynon: 'I-unmute ang mic mo.'),
    Phrase(english: 'Share your screen.', hiligaynon: 'I-share ang screen mo.'),
    Phrase(english: 'Upload the file.', hiligaynon: 'I-upload ang file.'),
    Phrase(english: 'Download this.', hiligaynon: 'I-download ini.'),
    Phrase(english: 'Check your settings.', hiligaynon: 'Tan-awa ang settings mo.'),
    Phrase(english: 'Clear the cache.', hiligaynon: 'I-clear ang cache.'),
    Phrase(english: 'Log in to your account.', hiligaynon: 'Mag-login sa imo account.'),
    Phrase(english: 'Log out.', hiligaynon: 'Mag-logout.'),
    Phrase(english: 'Reset your password.', hiligaynon: 'I-reset ang password mo.'),
    Phrase(english: 'I forgot my password.', hiligaynon: 'Nakalimot ako sang password ko.'),
    Phrase(english: 'Enable notifications.', hiligaynon: 'I-enable ang notifications.'),
    Phrase(english: 'Disable notifications.', hiligaynon: 'I-disable ang notifications.'),
    Phrase(english: 'This app is crashing.', hiligaynon: 'Nagacrash ini nga app.'),
    Phrase(english: 'Can you fix it?', hiligaynon: 'Pwede mo ni Kay-ohon?'),
    Phrase(english: 'Recover my files.', hiligaynon: 'I-recover ang akon files.'),
    Phrase(english: 'Record the screen.', hiligaynon: 'I-record ang screen.'),
    Phrase(english: 'My camera is not working.', hiligaynon: 'Wala gagana akon camera'),
    Phrase(english: 'It’s lagging.', hiligaynon: 'Nagalag siya.'),
    Phrase(english: 'Check your inbox.', hiligaynon: 'Tan-awa imo inbox.'),
    Phrase(english: 'Check your spam.', hiligaynon: 'Tan-awa ang spam mo.'),
    Phrase(english: 'Send me an email.', hiligaynon: 'I-email ko palihog.'),
    Phrase(english: 'Reply to the message.', hiligaynon: 'Sabta ang mensahe.'),
    Phrase(english: 'Copy the text.', hiligaynon: 'I-copy ang text.'),
    Phrase(english: 'Paste it here.', hiligaynon: 'I-paste diri.'),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update favorite')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technology and Online'),
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
                    p.english == phrase.english && p.hiligaynon == phrase.hiligaynon);

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
