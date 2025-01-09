import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'modale.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  List<Map<String, dynamic>> challenges = [];
  int challengeCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saisie des challenges'),
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
              onPressed: () {
                _showAddChallengeDialog();
              },
            ),
          ),
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
