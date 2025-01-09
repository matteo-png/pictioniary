import 'package:flutter/material.dart';
import 'package:pictionairy/api/api_inscription.dart';
import 'package:pictionairy/main.dart';
import 'package:pictionairy/ui/screens/home.dart';


class Inscription extends StatelessWidget {
  Inscription({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Inscription',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Entrez votre pseudo',
                  ),
                  validator: (value) {
                    if (null == value || value.isEmpty) {
                      return 'Veuillez entrer un pseudo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20
                ),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Entrez votre mot de passe',
                  ),
                  validator: (value) {
                    if (null == value || value.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String name = nameController.text;
                    String password = passwordController.text;

                    final navigator = Navigator.of(context);

                    await inscription(name, password);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text(
                            'Merci pour votre inscription, vous pouvez maintenant vous connecter',
                          ),
                        );
                      },
                    );

                    // Délai de 3 secondes avant de fermer la popin et rediriger
                    await Future.delayed(const Duration(seconds: 3));
                    navigator.pop(); // Ferme la popin

                    navigator.pushNamed('/login');
                  }
                },

                child: const Text('Enregistrer'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Text('Déjà un compte ? Connectez vous'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}