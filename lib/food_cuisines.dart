import 'package:flutter/material.dart';

class FoodCuisinesPage extends StatelessWidget {
  const FoodCuisinesPage({super.key});

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
                  'Food and Cuisines',
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
                        'Savor the Flavors of Iloilo: A Journey Through Ilonggo Food and Cuisine',
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
                          'If there’s one thing Iloilo is famous for — aside from its rich culture and warm people — it’s the food. In the City of Love, meals are more than just something to eat; they are part of the Ilonggo identity, filled with flavor, history, and heart.',
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
                title: 'La Paz Batchoy',
                image: 'assets/batchoy.png',
                description:
                    'This iconic noodle soup is a must-try. Originating from the La Paz district, batchoy is made with egg noodles, pork organs, crushed chicharon (pork cracklings), garlic, and a flavorful broth.\n\nWhere to try: Netong’s, Deco’s, Ted’s La Paz Batchoy\nFun Fact: It’s best eaten fresh, with puto or pan de sal on the side!',
              ),

              // Section 2
              sectionWithImage(
                title: 'Pancit Molo',
                image: 'assets/pancitM.png',
                description:
                    'A local version of dumpling soup, Pancit Molo features wonton wrappers filled with ground meat, swimming in a garlicky chicken broth. It’s originally from Molo district and is perfect for rainy days or light comfort meals.\n\nWhere to try: Molo Mansion Café, local carinderias\nBest served hot with fried garlic on top',
              ),

              // Section 3
              sectionWithImage(
                title: 'KBL (Kadyos, Baboy, Langka)',
                image: 'assets/kbl.png',
                description:
                    'A traditional Ilonggo stew made from pork (baboy), jackfruit (langka), and pigeon peas (kadyos). The secret? The souring agent called batuan, which gives it a distinct Ilonggo taste.\n\nWhere to try: Tatoy’s, Breakthrough, or home-cooked meals\nFlavor: Sour-savory, rich and earthy',
              ),

              // Section 4
              sectionWithImage(
                title: 'Fresh Seafood',
                image: 'assets/seafood.png',
                description:
                    'With Iloilo’s proximity to the sea, expect an abundance of fresh seafood — grilled scallops, oysters, shrimps, blue crabs, and bangus (milkfish). Whether baked, grilled, or in soup, it’s always a feast!\n\nWhere to try: Breakthrough, Allan’s Talabahan\nTry this: Buttered scallops and talaba (oysters)',
              ),

              // Section 5
              sectionWithImage(
                title: 'Ilonggo Street Food',
                image: 'assets/streetF.png',
                description:
                    'Don’t miss the tasty treats from the sidewalks — balut (duck egg), isaw (intestines), kwek-kwek (quail eggs), and the local favorite binatog (boiled corn with coconut and sugar).\n\nWhere to try: Iloilo Night Market, JM Basa Street, Plazas\nBest enjoyed at night with friends',
              ),

              // Section 6
              sectionWithImage(
                title: 'Desserts and Delicacies',
                image: 'assets/biscuit.png',
                description:
                    'Satisfy your sweet tooth with Baye-Baye (ground rice & coconut), Biscocho (buttered toast with sugar), Pinasugbo (caramelized banana chips), and Butterscotch — a signature pasalubong treat!\n\nWhere to buy: Biscocho Haus, Panaderia de Molo, JD’s\nGreat for pasalubong!',
              ),

              // Section 7
              sectionWithImage(
                title: 'Native Drinks',
                image: 'assets/bokujuice.png',
                description:
                    'Wash it all down with tanglad (lemongrass) tea, sago’t gulaman, or locally brewed coffee from Guimaras or the mountains of Lambunao. Want something cold? Try fresh coconut juice by the roadside!',
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
