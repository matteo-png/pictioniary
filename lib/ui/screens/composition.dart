import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pictionairy/api/api_game.dart';
import 'dart:async';
import '../../main.dart';

class Composition extends StatefulWidget {
  final String gameId;

  const Composition({super.key, required this.gameId});

  @override
  _CompositionState createState() => _CompositionState();
}

class _CompositionState extends State<Composition> {

  late Timer _timer;
  Map<String, dynamic>? gameData;
  String? bluePlayer1;
  String? bluePlayer2;
  String? redPlayer1;
  String? redPlayer2;

  @override
  void initState() {
    super.initState();
    _fetchGameData();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchGameData();
    });
  }

  Future<void> _fetchGameData() async {
    gameData = await fetchGameSession(widget.gameId);

    if (gameData != null) {
      bluePlayer1 = await _getPlayerName(gameData!['blue_player_1']);
      bluePlayer2 = await _getPlayerName(gameData!['blue_player_2']);
      redPlayer1 = await _getPlayerName(gameData!['red_player_1']);
      redPlayer2 = await _getPlayerName(gameData!['red_player_2']);

      setState(() {}); // Rafraîchit l'interface après avoir récupéré les données
    }
  }

  Future<String?> _getPlayerName(int? playerId) async {
    if (playerId != null) {
      return await fetchPlayerName(playerId);
    }
    return null;
  }

  Future<void> _leaveGame() async {
    final success = await leaveGameSession(widget.gameId);
    if (success) {
      // Redirection vers la page d'accueil
      final navigator = Navigator.of(context);
      navigator.pushNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la sortie de la partie')),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Composition des équipes'),
        backgroundColor: const Color(0xFFCEDAE6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _leaveGame,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                Center(
                  child: Text(
                    'Numéro de la Partie : ${widget.gameId}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: QrImageView(
                    data: widget.gameId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                const SizedBox(height: 16),
                const TeamTitle(teamName: 'Equipe Bleu'),
                const SizedBox(height: 8),
                TeamCard(
                  backgroundColor: Colors.blue,
                  players: [
                    bluePlayer1 ?? '<en attente>',
                    bluePlayer2 ?? '<en attente>',
                  ],
                ),
                const SizedBox(height: 24),
                const TeamTitle(teamName: 'Equipe Rouge'),
                const SizedBox(height: 8),
                TeamCard(
                  backgroundColor: Colors.red,
                  players: [
                    redPlayer1 ?? '<en attente>',
                    redPlayer2 ?? '<en attente>',
                  ],
                ),
                const SizedBox(height: 64),
                const Text(
                  'La partie sera lancée automatiquement une fois les joueurs au complet',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
