import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/api_game.dart';

class Drawerform extends StatefulWidget {
  final String gameId;

  const Drawerform({super.key, required this.gameId});

  @override
  _DrawerformState createState() => _DrawerformState();
}

class _DrawerformState extends State<Drawerform> {
  Map<String, dynamic>? challengeData;
  bool isLoading = true;
  bool isGenerating = false;
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchChallenge();
  }

  Future<void> _fetchChallenge() async {
    try {
      final response = await fetchMyChallenges(widget.gameId);
      if (response.isNotEmpty) {
        setState(() {
          challengeData = response[0]; // Prendre le premier challenge
          isLoading = false;
        });
      }
    } catch (e) {
      print("Erreur lors de la récupération du challenge : $e");
    }
  }

  Future<void> _generateImage() async {
    if (_promptController.text.isEmpty) return;

    setState(() {
      isGenerating = true;
    });

    try {
      final newChallenge = await regenerateImage(
        widget.gameId,
        challengeData!['id'].toString(),
        _promptController.text,
      );

      setState(() {
        challengeData = newChallenge;
        isGenerating = false;
      });
    } catch (e) {
      print("Erreur lors de la génération de l'image : $e");
      setState(() {
        isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCEDAE6),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            const SizedBox(height: 20),

            //Challenge dynamique
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Votre challenge:',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${challengeData?['first_word']} ${challengeData?['second_word']} ${challengeData?['third_word']} ${challengeData?['fourth_word']} ${challengeData?['fifth_word']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: _buildForbiddenWords(),
                  ),
                ],
              ),
            ),

            // Zone de texte pour entrer le prompt
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextField(
                controller: _promptController,
                decoration: InputDecoration(
                  hintText: "Décris ton image...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),

            // Bouton pour générer l'image
            ElevatedButton.icon(
              onPressed: isGenerating ? null : _generateImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                fixedSize: const Size(200, 50),
              ),
              icon: isGenerating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.image, size: 24),
              label: const Text('Générer l\'image'),
            ),

            // Image générée
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: challengeData?['image_path'] != null
                      ? Image.network(
                    challengeData!['image_path'],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text("Erreur de chargement"));
                    },
                  )
                      : const Center(child: Text("Aucune image générée")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour afficher les mots interdits
  List<Widget> _buildForbiddenWords() {
    if (challengeData == null || challengeData!['forbidden_words'] == null) {
      return [];
    }

    List<String> forbiddenWords =
    List<String>.from(json.decode(challengeData!['forbidden_words']));

    return forbiddenWords.map((word) => Forbiddenwords(text: word)).toList();
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
