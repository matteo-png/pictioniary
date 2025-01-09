import 'package:flutter/material.dart';
import 'package:pictionairy/main.dart';

class Guesserform extends StatelessWidget {
  const Guesserform({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitlePage(
          title: 'PICTION.IA.RY',
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFCEDAE6),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Chrono',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              '232',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScoreCard(
                  team: 'Equipe bleue',
                  score: 89,
                  backgroundColor: Colors.grey[400]!,
                  textColor: Colors.black,
                ),
                ScoreCard(
                  team: 'Equipe rouge',
                  score: 93,
                  backgroundColor: Colors.grey[400]!,
                  textColor: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Qu\'a dessiné votre coéquipier ?',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/QR_icon.png',
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
            ),
            // Boutons de mots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Une',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Texte statique "sur un"
                const Text(
                  'sur un',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 10),

                // TextField "mot 2"
                Flexible(
                  child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Icone d'aide
                const Icon(Icons.help_outline, color: Colors.white),
              ],
            ),
            // Bouton Abandonner
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
              onPressed: () {
                // Action du bouton
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Abandonner et devenir dessinateur',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String team;
  final int score;
  final Color backgroundColor;
  final Color textColor;

  const ScoreCard({super.key,
    required this.team,
    required this.score,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          Text(
            team,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$score',
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class WordContainer extends StatelessWidget {
  final String text;

  const WordContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}