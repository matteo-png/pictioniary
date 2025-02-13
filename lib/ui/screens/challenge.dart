import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:convert';
import 'package:pictionairy/api/api_game.dart';


import 'modale.dart';

class ChallengesPage extends StatefulWidget {
  final String gameId;

  const ChallengesPage({super.key, required this.gameId});

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<Map<String, dynamic>> challenges = [];
  int challengeCounter = 0;

  // Fonction pour envoyer les challenges à l'API
  Future<void> _sendAllChallenges() async {
    for (final challenge in challenges) {
      final challengeData = {
        "first_word": challenge["description"].split(' ')[0],
        "second_word": challenge["description"].split(' ')[1],
        "third_word": challenge["description"].split(' ')[2],
        "fourth_word": challenge["description"].split(' ')[3],
        "fifth_word": challenge["description"].split(' ')[4],
        "motsInterdit": challenge["motsInterdit"],
      };

      try {
        final success = await sendChallenge(widget.gameId, challengeData);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Envoi des challenges réussis !! ')),
          );
          _navigateToLoadingPage();
        }
      } catch (e) {
        print('Erreur : $e');
      }
    }
  }

  void _navigateToLoadingPage() {
    final navigator = Navigator.of(context);
    // Redirection vers la page d'attente
    navigator.pushReplacementNamed('/loading', arguments: widget.gameId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saisie des challenges :   '),
        leading: const Icon(Icons.arrow_back),
        backgroundColor: const Color(0xFFCEDAE6),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  final challenge = challenges[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChallengeCard(
                            title: challenge['title'],
                            description: challenge['description'],
                            motsInterdit: challenge['motsInterdit'],
                            onDelete: () {
                              setState(() {
                                challenges.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline, size: 40),
              onPressed: challenges.length >= 3
                  ? null // Désactive le bouton si 3 challenges sont créés
                  : () {
                _showAddChallengeDialog();
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: challenges.length == 3 ? _sendAllChallenges : null,
            child: const Text('Envoyer les challenges '),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }


  // Fonction pour afficher la pop-up
  void _showAddChallengeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddChallengeDialog(onAdd: (newChallenge) {
          setState(() {
            challengeCounter++;
            newChallenge['title'] = 'Challenge #$challengeCounter';
            challenges.add(newChallenge);
          });
        });
      },
    );
  }
}

// Composant pour la carte de challenge
class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> motsInterdit;
  final VoidCallback onDelete;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.motsInterdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 8),
                Row(
                  children: motsInterdit
                      .map(
                        (motsInterdit) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(
                          motsInterdit,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black, size: 30),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
