import 'package:flutter/material.dart';

class Drawerform extends StatelessWidget {
  const Drawerform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEDAE6), // Couleur d'arrière-plan bleue
      body: SafeArea(
        child: Column(
          children: [
            // Chrono
            const SizedBox(height: 10),
            const Text(
              'Chrono\n300',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            // Votre challenge
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Votre challenge:',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'UNE POULE SUR UN MUR',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      Forbiddenwords(text: 'Poulet'),
                      Forbiddenwords(text: 'Volaille'),
                      Forbiddenwords(text: 'Oiseau'),
                    ],
                  ),
                ],
              ),
            ),

            // Image avec boutons superposés
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Image centrale
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/QR_icon.png', // Chemin vers ton image PNG
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  // Boutons superposés
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action pour régénérer l'image
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        fixedSize: const Size(180, 60),
                      ),
                      icon: const Icon(Icons.refresh, size: 24),
                      label: const Column(
                        children: [
                          Text('Régénérer', style: TextStyle(fontSize: 14)),
                          Text('l\'image (-50pts)', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action pour envoyer au devineur
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        fixedSize: const Size(180, 60),
                      ),
                      icon: const Icon(Icons.send, size: 24),
                      label: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Envoyer au', style: TextStyle(fontSize: 14)),
                          Text('devineur', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bouton flottant en bas à droite
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action du bouton flottant
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

class Forbiddenwords extends StatelessWidget {
  final String text;

  const Forbiddenwords({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
