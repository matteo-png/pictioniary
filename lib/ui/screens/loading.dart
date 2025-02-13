import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pictionairy/api/api_game.dart';

class Loading extends StatefulWidget {
  final String gameId;

  const Loading({super.key, required this.gameId});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startStatusCheck();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startStatusCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final status = await fetchGameStatus(widget.gameId);
        if (status == "drawing") {
          _navigateToDrawingPage();
        }
      } catch (e) {
        print("Erreur lors de la vérification du statut : $e");
      }
    });
  }

  void _navigateToDrawingPage() {
    _timer.cancel(); // Arrêter le timer avant la navigation
    Navigator.of(context).pushReplacementNamed('/drawing', arguments: widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFFFF0000),
                rightDotColor: const Color(0xFFe98105),
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                "En attente des autres joueurs",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
