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
    Phrase(english: 'Open the app.', hiligaynon: 'Buksi ang app.'),
    Phrase(english: 'Close the app.', hiligaynon: 'Isira ang app.'),
    Phrase(english: 'Install this.', hiligaynon: 'I-install ini.'),
    Phrase(english: 'My battery is low.', hiligaynon: 'Lowbat ko'),
    Phrase(english: 'Update your phone.', hiligaynon: 'I-update ang telepono mo.'),
    Phrase(english: 'My phone is broken.', hiligaynon: 'Guba ang telepono ko.'),
    Phrase(english: 'I can’t open it.', hiligaynon: 'Indi ko mabuksan.'),
    Phrase(english: 'The screen is cracked.', hiligaynon: 'Buka ang screen.'),
    Phrase(english: 'Send me the link.', hiligaynon: 'Ipadala sa akon ang link.'),
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
    Phrase(english: 'Turn on Bluetooth.', hiligaynon: 'I-on ang Bluetooth.'),
    Phrase(english: 'Turn off Bluetooth.', hiligaynon: 'I-off ang Bluetooth.'),
    Phrase(english: 'Connect to Wi-Fi.', hiligaynon: 'Konektar sa Wi-Fi.'),
    Phrase(english: 'Disconnect from Wi-Fi.', hiligaynon: 'I-disconnect sa Wi-Fi.'),
    Phrase(english: 'Open the browser.', hiligaynon: 'Buksan ang browser.'),
    Phrase(english: 'Close the browser.', hiligaynon: 'Isira ang browser.'),
    Phrase(english: 'Search online.', hiligaynon: 'Mag-search online.'),
    Phrase(english: 'Bookmark this page.', hiligaynon: 'I-bookmark ini nga page.'),
    Phrase(english: 'Clear browsing history.', hiligaynon: 'I-clear ang browsing history.'),
    Phrase(english: 'Update the app.', hiligaynon: 'I-update ang app.'),
    Phrase(english: 'Install the update.', hiligaynon: 'I-install ang update.'),
    Phrase(english: 'Uninstall the app.', hiligaynon: 'I-uninstall ang app.'),
    Phrase(english: 'Check for updates.', hiligaynon: 'Tan-awa kon may updates.'),
    Phrase(english: 'Enable Wi-Fi calling.', hiligaynon: 'I-enable ang Wi-Fi calling.'),
    Phrase(english: 'Disable Wi-Fi calling.', hiligaynon: 'I-disable ang Wi-Fi calling.'),
    Phrase(english: 'Turn on airplane mode.', hiligaynon: 'I-on ang airplane mode.'),
    Phrase(english: 'Turn off airplane mode.', hiligaynon: 'I-off ang airplane mode.'),
    Phrase(english: 'Pair the device.', hiligaynon: 'I-pair ang device.'),
    Phrase(english: 'Unpair the device.', hiligaynon: 'I-unpair ang device.'),
    Phrase(english: 'Check signal strength.', hiligaynon: 'Tan-awa ang signal strength.'),
    Phrase(english: 'Enable dark mode.', hiligaynon: 'I-enable ang dark mode.'),
    Phrase(english: 'Disable dark mode.', hiligaynon: 'I-disable ang dark mode.'),
    Phrase(english: 'Restart the app.', hiligaynon: 'I-restart ang app.'),
    Phrase(english: 'Sync your account.', hiligaynon: 'I-sync ang imo account.'),
    Phrase(english: 'Backup your data.', hiligaynon: 'I-backup ang imo data.'),
    Phrase(english: 'Restore your data.', hiligaynon: 'I-restore ang imo data.'),
    Phrase(english: 'Enable location services.', hiligaynon: 'I-enable ang location services.'),
    Phrase(english: 'Disable location services.', hiligaynon: 'I-disable ang location services.'),
    Phrase(english: 'Enable GPS.', hiligaynon: 'I-enable ang GPS.'),
    Phrase(english: 'Disable GPS.', hiligaynon: 'I-disable ang GPS.'),
    Phrase(english: 'Connect to a hotspot.', hiligaynon: 'Konektar sa hotspot.'),
    Phrase(english: 'Disconnect from a hotspot.', hiligaynon: 'I-disconnect sa hotspot.'),
    Phrase(english: 'Scan the QR code.', hiligaynon: 'I-scan ang QR code.'),
    Phrase(english: 'Enter your password.', hiligaynon: 'I-sulod ang imo password.'),
    Phrase(english: 'Enable two-factor authentication.', hiligaynon: 'I-enable ang two-factor authentication.'),
    Phrase(english: 'Disable two-factor authentication.', hiligaynon: 'I-disable ang two-factor authentication.'),
    Phrase(english: 'Log in securely.', hiligaynon: 'Mag-login sang seguro.'),
    Phrase(english: 'Log out securely.', hiligaynon: 'Mag-logout sang seguro.'),
    Phrase(english: 'Enable notifications.', hiligaynon: 'I-enable ang notifications.'),
    Phrase(english: 'Disable notifications.', hiligaynon: 'I-disable ang notifications.'),
    Phrase(english: 'Clear the cache.', hiligaynon: 'I-clear ang cache.'),
    Phrase(english: 'Check storage space.', hiligaynon: 'Tan-awa ang storage space.'),
    Phrase(english: 'Connect to a printer.', hiligaynon: 'Konektar sa printer.'),
    Phrase(english: 'Disconnect from a printer.', hiligaynon: 'I-disconnect sa printer.'),
    Phrase(english: 'Send a screenshot.', hiligaynon: 'Ipadala ang screenshot.'),
    Phrase(english: 'Record a video.', hiligaynon: 'Mag-record sang video.'),
    Phrase(english: 'Take a photo.', hiligaynon: 'Magkuha sang litrato.'),
    Phrase(english: 'Share a file.', hiligaynon: 'I-share ang file.'),
    Phrase(english: 'Download the app.', hiligaynon: 'I-download ang app.'),
    Phrase(english: 'Upload the file.', hiligaynon: 'I-upload ang file.'),
    Phrase(english: 'Enable microphone.', hiligaynon: 'I-enable ang microphone.'),
    Phrase(english: 'Disable microphone.', hiligaynon: 'I-disable ang microphone.'),
    Phrase(english: 'Enable camera.', hiligaynon: 'I-enable ang camera.'),
    Phrase(english: 'Disable camera.', hiligaynon: 'I-disable ang camera.'),
    Phrase(english: 'Turn on flashlight.', hiligaynon: 'I-on ang flashlight.'),
    Phrase(english: 'Turn off flashlight.', hiligaynon: 'I-off ang flashlight.'),

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
