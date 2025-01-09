import 'package:flutter/material.dart';
import 'package:pictionairy/main.dart';
import 'package:pictionairy/ui/screens/home.dart';
import '../../api/api_login.dart';


class Identification extends StatelessWidget {
  Identification({super.key});

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
                'Connexion',
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


                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);


                    bool isAuthenticated = await login(name, password);

                    if (isAuthenticated) {
                      navigator.pushNamed('/home');
                      nameController.clear();
                      passwordController.clear();
                    } else {
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Pseudo ou mot de passe incorrect')),
                      );
                    }
                  }
                },

                child: const Text('Connexion'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/inscription');
                },
                child: const Text('Pas de compte ? Inscrivez-vous'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}