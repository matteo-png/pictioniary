import 'package:flutter/material.dart';
import 'package:pictionairy/ui/screens/challenge.dart';
import 'package:pictionairy/ui/screens/composition.dart';
import 'package:pictionairy/ui/screens/inscription.dart';
import 'package:pictionairy/ui/screens/loading.dart';
import 'package:pictionairy/ui/screens/drawerform.dart';
import 'package:pictionairy/ui/screens/guesserform.dart';
import 'package:pictionairy/ui/screens/home.dart';
import 'package:pictionairy/ui/screens/identification.dart';
import 'package:pictionairy/ui/screens/scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => Identification(),
        '/home': (context) => const Home(),
        '/qrcode' : (context) => const Scanner(),
        '/inscription': (context) => Inscription()
      },
      title: 'PICTION.IA.RY',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFCEDAE6),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4357AD),
            foregroundColor: const Color(0xFFe4dfda),
            padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          )
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        useMaterial3: true,
      ),
      home: Identification(),
    );
  }
}

class TitlePage extends StatelessWidget {
  final String title;
  const TitlePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Arcade',
        fontSize: 40,
        color: Color(0xff3e2205),
      ),


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class TeamTitle extends StatelessWidget {
  final String teamName;

  const TeamTitle({super.key, required this.teamName});
  @override
  Widget build(BuildContext context) {
    return Text(
      teamName,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}

class TeamCard extends StatelessWidget {
  final Color backgroundColor;
  final List<String> players;

  const TeamCard({super.key, required this.backgroundColor, required this.players});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: players.map((player) {
          return Column(
            children: [
              Text(
                player,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
