import 'package:flutter/material.dart';

class TouristAttractionsPage extends StatelessWidget {
  const TouristAttractionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back arrow
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Title
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Tourist Attractions',
                  style: TextStyle(
                    fontFamily: 'KumbhSans',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Outlined square box
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
                        'Top Tourist Attractions in Iloilo You Shouldn’t Miss',
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
                          'Welcome to Iloilo — the City of Love, where history, culture, and natural beauty blend to create unforgettable experiences! Whether you’re a first-time visitor or coming back for more, Iloilo offers something for every traveler.',
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

              // Section 1
              sectionWithImage(
                title: 'Molo Church (St. Anne Parish Church)',
                image: 'assets/moloC.png',
                description:
                    'Nicknamed the “Feminist Church,” this Gothic-style landmark is famous for its statues of female saints inside. It’s a historical and architectural gem located right in the heart of Molo District.\n\nLocation: Molo Plaza\nHighlight: 16 all-female saint statues',
              ),

              // Section 2
              sectionWithImage(
                title: 'Miag-ao Church (Sto. Tomas de Villanueva Parish)',
                image: 'assets/miagaoC.png',
                description:
                    'A UNESCO World Heritage Site, this centuries-old Baroque church in Miag-ao is a masterpiece of Filipino-Spanish architecture. Its facade tells stories carved in stone — a must-see for history buffs!\n\nLocation: Miag-ao, Iloilo\nHighlight: Intricate carvings & golden hue',
              ),

              // Section 3
              sectionWithImage(
                title: 'Iloilo River Esplanade',
                image: 'assets/esplanade.png',
                description:
                    'A favorite spot for locals and tourists alike, the Esplanade is perfect for walking, jogging, or simply relaxing while watching the sunset over the Iloilo River.\n\nLocation: Mandurriao to Molo\nHighlight: Scenic walkways and nature views',
              ),

              // Section 4
              sectionWithImage(
                title: 'Garin Farm Pilgrimage Resort',
                image: 'assets/garinF.png',
                description:
                    'Located in San Joaquin, Garin Farm is a spiritual and recreational destination. Climb 480 steps to a giant Divine Mercy cross and experience a simulated "Heaven."\n\nLocation: San Joaquin, Iloilo\nHighlight: Pure white tunnel of light and scenic farm activities',
              ),

              // Section 5
              sectionWithImage(
                title: 'Calle Real (J.M. Basa Street)',
                image: 'assets/calle.png',
                description:
                    'This historic downtown street is lined with elegant colonial buildings, restored and preserved to show off Iloilo’s commercial past. Perfect for photo ops and culture walks!\n\nLocation: City Proper\nHighlight: Heritage buildings & shops',
              ),

              // Section 6
              sectionWithImage(
                title: 'La Paz Public Market',
                image: 'assets/market.png',
                description:
                    'Don’t leave Iloilo without tasting La Paz Batchoy where it all began — right in La Paz Market! Watch it being prepared and enjoy its hot, flavorful goodness.\n\nLocation: La Paz\nHighlight: Netong’s Batchoy or Deco’s Original',
              ),

              // Section 7
              sectionWithImage(
                title: 'Islas de Gigantes',
                image: 'assets/isla.png',
                description:
                    'Technically in Carles, Iloilo, this island chain boasts white sand beaches, rock formations, lagoons, and fresh seafood feasts. A paradise for island hoppers and beach lovers.\n\nLocation: Carles, Iloilo\nHighlight: Cabugao Gamay, Tangke Lagoon, Scallops buffet!',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Custom widget builder for reusable layout with image
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