import 'package:flutter/material.dart';

class CulturePage extends StatelessWidget {
  const CulturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Culture of Iloilo',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              
              Center(
                child: Container(
                  width: 328,
                  height: 204,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF2A7BE6), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Discovering the Rich Culture of Iloilo: A City of Warmth and Heritage',
                        style: TextStyle(
                          fontFamily: 'KumbhSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          'When we talk about Western Visayas, one name always shines bright — Iloilo. Known as the “Heart of the Philippines,” Iloilo isn’t just famous for its batchoy or beautiful churches — it is a land deeply rooted in heritage, history, and heartfelt hospitality.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'KumbhSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              
              sectionWithImage(
                title: 'A Glimpse of Iloilo’s Historical Soul',
                image: 'assets/cpic.png',
                description:
                    'Walking through the streets of Jaro, Molo, or downtown Iloilo, you’ll see Spanish colonial houses and old churches that have stood the test of time. The Molo Church, famously known as the “feminist church” for its all-female saint statues, and the Jaro Cathedral, where the miraculous image of Our Lady of the Candles resides, are just some cultural gems that speak of Iloilo’s strong Catholic faith.',
              ),

              
              sectionWithImage(
                title: 'Festivals That Bring People Together',
                image: 'assets/cpic2.png',
                description:
                    'The Dinagyang Festival is Iloilo’s most iconic celebration. Held every January, it honors the Santo Niño and showcases Ati-Atihan-inspired dances in elaborate costumes, drumbeats, and joyful street parades. It’s more than a show — it’s a symbol of devotion, unity, and Ilonggo creativity.',
              ),

              
              sectionWithImage(
                title: 'The Art of Hablon and Local Craftsmanship',
                image: 'assets/cpic3.png',
                description:
                    'In places like Miag-ao and Oton, traditional weaving continues to thrive. Hablon, a handwoven fabric made from natural fibers, is more than cloth — it represents the patience and pride of local weavers. Today, it’s being reintroduced in modern fashion, keeping Iloilo’s textile legacy alive.',
              ),

              
              sectionWithImage(
                title: 'The Language of Sweetness',
                image: 'assets/cpic4.png',
                description:
                    'Hiligaynon, the local language, is often described as malambing (gentle or sweet-sounding). Conversations in Iloilo are respectful, warm, and polite — a reflection of the Ilonggo character. Whether you\'re a stranger or family, you\'re always welcomed with a smile and treated with kindness.',
              ),

              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Iloilo Today: Tradition Meets Progress',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Despite the growth of malls, businesses, and modern development, Iloilo has found a way to preserve its heritage while embracing progress. Cultural preservation efforts, youth art movements, and tourism initiatives show that Iloilo’s culture is not just history — it’s alive and evolving.',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontSize: 12,
                    color: Color(0xFF878282),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget sectionWithImage({
    required String title,
    required String image,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'KumbhSans',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 161,
                height: 222,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'KumbhSans',
                    fontSize: 12,
                    color: Color(0xFF878282),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}