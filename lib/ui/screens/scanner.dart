import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:pictionairy/api/api_game.dart';
import 'composition.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  Future<String?> getRandomAvailableColor(String gameId) async {
    // Récupérer les données de la session de jeu
    final gameData = await fetchGameSession(gameId);

    if (gameData != null) {
      final blueTeam = gameData['blue_team'];
      final redTeam = gameData['red_team'];

      // Vérifier la place disponible dans chaque équipe
      final hasBlueSpace = blueTeam.length < 2;
      final hasRedSpace = redTeam.length < 2;

      // Liste des couleurs disponibles
      final availableColors = <String>[];
      if (hasBlueSpace) availableColors.add("blue");
      if (hasRedSpace) availableColors.add("red");

      // Si au moins une couleur est disponible, en choisir une au hasard
      if (availableColors.isNotEmpty) {
        final random = Random();
        return availableColors[random.nextInt(availableColors.length)];
      }
    }

    // Retourne null si aucune couleur n'est disponible
    return null;
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final gameId = scanData.code;

      if (gameId != null) {
        // Obtenez une couleur aléatoire disponible
        final teamColor = await getRandomAvailableColor(gameId);

        if (teamColor != null) {
          // Rejoindre la partie avec la couleur choisie
          final joined = await joinGameSession(gameId, teamColor);

          if (joined) {
            // Redirige vers la page Composition si le joueur a rejoint avec succès
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Composition(gameId: gameId),
              ),
            );
          } else {
            // Affiche un message d'erreur si le join échoue
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Impossible de rejoindre la partie')),
            );
          }
        } else {
          // Affiche un message si les équipes sont complètes
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Les équipes sont complètes')),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
      MediaQuery.of(context).size.height < 400)
      ? 250.0
      : 300.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un QR Code'),
        backgroundColor: const Color(0xFFCEDAE6),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Scannez le QR Code pour rejoindre une partie'),
            ),
          ),
        ],
      ),
    );
  }
}
