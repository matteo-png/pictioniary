import 'package:flutter/material.dart';

class AddChallengeDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddChallengeDialog({super.key, required this.onAdd});

  @override
  _AddChallengeDialogState createState() => _AddChallengeDialogState();
}

class _AddChallengeDialogState extends State<AddChallengeDialog> {
  String gender1 = 'UN';
  String preposition = 'SUR';
  String gender2 = 'UN';
  String word1 = '';
  String word2 = '';
  String motInterdit1 = '';
  String motInterdit2 = '';
  String motInterdit3 = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ajout d\'un challenge',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ToggleButtons(
                isSelected: [gender1 == 'UN', gender1 == 'UNE'],
                onPressed: (index) {
                  setState(() {
                    gender1 = index == 0 ? 'UN' : 'UNE';
                  });
                },
                children: [Text('UN'), Text('UNE')],
                borderRadius: BorderRadius.circular(20),
                selectedColor: Colors.white,
                fillColor: Colors.purple,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Votre premier mot'),
                onChanged: (value) {
                  setState(() {
                    word1 = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ToggleButtons(
                isSelected: [preposition == 'SUR', preposition == 'DANS'],
                onPressed: (index) {
                  setState(() {
                    preposition = index == 0 ? 'SUR' : 'DANS';
                  });
                },
                children: [Text('SUR'), Text('DANS')],
                borderRadius: BorderRadius.circular(20),
                selectedColor: Colors.white,
                fillColor: Colors.purple,
              ),
              const SizedBox(height: 8),
              ToggleButtons(
                isSelected: [gender2 == 'UN', gender2 == 'UNE'],
                onPressed: (index) {
                  setState(() {
                    gender2 = index == 0 ? 'UN' : 'UNE';
                  });
                },
                children: [Text('UN'), Text('UNE')],
                borderRadius: BorderRadius.circular(20),
                selectedColor: Colors.white,
                fillColor: Colors.purple,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Votre deuxième mot'),
                onChanged: (value) {
                  setState(() {
                    word2 = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Champs pour ajouter les mots interdits
              TextField(
                decoration: const InputDecoration(hintText: 'Mot interdit 1'),
                onChanged: (value) {
                  setState(() {
                    motInterdit1 = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(hintText: 'Mot interdit 2'),
                onChanged: (value) {
                  setState(() {
                    motInterdit2 = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(hintText: 'Mot interdit 3'),
                onChanged: (value) {
                  setState(() {
                    motInterdit3 = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final newChallenge = {
                    'title': '',
                    'description': '$gender1 $word1 $preposition $gender2 $word2',
                    'motsInterdit': [
                      if (motInterdit1.isNotEmpty) motInterdit1,
                      if (motInterdit2.isNotEmpty) motInterdit2,
                      if (motInterdit3.isNotEmpty) motInterdit3,
                    ]
                  };
                  widget.onAdd(newChallenge);
                  Navigator.of(context).pop();
                },
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}