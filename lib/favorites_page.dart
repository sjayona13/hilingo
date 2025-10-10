import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phrase.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<void> removeFromFavorites(Phrase phrase) async {
    final query = await FirebaseFirestore.instance
        .collection('favorites')
        .where('english', isEqualTo: phrase.english)
        .where('hiligaynon', isEqualTo: phrase.hiligaynon)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          }

          final docs = snapshot.data!.docs;

          final favorites = docs.map((doc) {
            return Phrase(
              english: doc['english'],
              hiligaynon: doc['hiligaynon'],
            );
          }).toList()
            ..sort((a, b) => a.english.toLowerCase().compareTo(b.english.toLowerCase()));

          return ListView.separated(
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const Divider(thickness: 1),
            itemBuilder: (context, index) {
              final phrase = favorites[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => removeFromFavorites(phrase),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
