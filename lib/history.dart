import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  void showImagePopup(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/capitol.png',
      'assets/moloM.png',
      'assets/esplanade.png',
      'assets/megaworld.png',
      'assets/calle.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back Arrow
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'History of Iloilo',
                    style: TextStyle(
                      fontFamily: 'KumbhSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // Image Slider
              SizedBox(
                height: 230,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: images.map((path) {
                    return GestureDetector(
                      onTap: () => showImagePopup(context, path),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 280,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              // Etymology Box
              Center(
                child: Container(
                  width: 328,
                  height: 204,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2A7BE6), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Etymology of Iloilo',
                        style: TextStyle(
                          fontFamily: 'KumbhSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          'The name "Iloilo" originates from the old term "Irong-Irong," which means "nose-like" in the local dialect. \nThis designation refers to the shape of the promontory between the Iloilo and Batiano rivers, resembling a nose. \nThe Spanish colonizers adopted this term, which eventually evolved into "Iloilo."',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'KumbhSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xFF878282),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // History Texts
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Early History',
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Before Spanish colonization, Iloilo was home to indigenous communities engaged in farming, fishing, and regional trade.\n\nThe Ilonggos settled along the Iloilo River, benefiting from fertile land and rich fishing grounds.\n\nThe Hinilawod epic shows the Ilonggos\' rich culture, but few records exist.\n\nIloilo\'s location helped in trade, shaping its future economy. This time prepared Iloilo for future changes with foreign powers.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontSize: 12,
                        color: Color(0xFF878282),
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      'Spanish Era (1566–1898)',
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'The Spanish arrived in the 1560s, taking control of Panay and founding La Villa Rica de Arevalo in 1581.\n\nIloilo\'s port opened to international trade in 1855, boosting sugar exports and attracting merchants.\n\nIloilo\'s loyalty to Spain during uprisings earned it the title "La Muy Noble Ciudad" on March 1, 1898.\n\nThis era brought important buildings like churches and schools, shaping Iloilo\'s culture and architecture.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontSize: 12,
                        color: Color(0xFF878282),
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      'Philippine Revolution and American Period (1898–1946)',
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Iloilo played a key role in the Philippine Revolution, with leaders fighting for independence.\n\nAfter the Spanish-American War, the U.S. took control of Iloilo, starting the American colonial period.\n\nUnder U.S. rule, Iloilo grew with public education and better roads and bridges.\n\nIloilo saw the first department stores and cinemas, showing its growth, but World War II brought challenges.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontSize: 12,
                        color: Color(0xFF878282),
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      'Japanese Occupation (1942–1945)',
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'During World War II, Iloilo faced hardship under Japanese rule, with devastation and suffering.\n\nLocal resistance helped free Panay from Japanese rule, showing Ilonggo bravery.\n\nAfter the war, Iloilo needed rebuilding, but its strong community spirit led to recovery.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontSize: 12,
                        color: Color(0xFF878282),
                      ),
                    ),

                    SizedBox(height: 25),

                    Text(
                      'Post-War Period to Present',
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'After gaining independence in 1946, Iloilo focused on rebuilding and improving infrastructure, leading to economic growth and modernization.\n\nToday, Iloilo is known for its rich cultural heritage, historic sites, and vibrant festivals like the Dinagyang Festival, which celebrates the city\'s history and religious devotion.\n\nThe continuous development in sectors such as education, commerce, and tourism has solidified Iloilo\'s status as a key economic and cultural hub in the Philippines.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontFamily: 'KumbhSans',
                        fontSize: 12,
                        color: Color(0xFF878282),
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}