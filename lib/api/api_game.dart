import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_login.dart';

Future<String?> createGameSession() async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions');
  String? token = await getToken();

  if (token != null) {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // La création a réussi
      final data = jsonDecode(response.body);
      return data['id'].toString();
    } else {
      // Affiche la réponse pour voir pourquoi ça échoue
      debugPrint("Erreur lors de la création de la session : ${response.body}");
      return null;
    }
  } else {
    debugPrint("Erreur : le token est nul");
    return null;
  }
}

Future<bool> joinGameSession(String gameId, String color) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/join');
  String? token = await getToken();

  if (token != null) {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'color': color}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Rejoindre a réussi
      return true;
    } else {
      // Affiche la réponse pour voir pourquoi ça échoue
      debugPrint("Erreur lors du join de la session : ${response.body}");
      return false;
    }
  } else {
    debugPrint("Erreur : le token est nul");
    return false;
  }
}

Future<Map<String, dynamic>?> fetchGameSession(String gameId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId');
  final token = await getToken();

  if (token != null) {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint("Erreur lors de la récupération de la session : ${response.body}");
      return null;
    }
  } else {
    debugPrint("Erreur : le token est nul");
    return null;
  }
}

Future<String?> fetchPlayerName(int playerId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/players/$playerId');
  final token = await getToken();

  if (token != null) {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['name'];
    } else {
      debugPrint("Erreur lors de la récupération du joueur : ${response.body}");
      return null;
    }
  } else {
    debugPrint("Erreur : le token est nul");
    return null;
  }
}

Future<bool> leaveGameSession(String gameId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/leave');
  final token = await getToken();

  if (token != null) {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Erreur lors de la déconnexion de la session : ${response.body}');
      return false;
    }
  } else {
    debugPrint('Erreur réseau lors de la déconnexion : ');
    return false;
  }
}

Future<bool> startGameSession(String gameId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/start');
  final token = await getToken();

  if (token != null) {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Erreur lors de la déconnexion de la session : ${response.body}');
      return false;
    }
  } else {
    debugPrint('Erreur réseau lors de la déconnexion : ');
    return false;
  }
}

Future<String?> fetchGameStatus(String gameId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/status');
  final token = await getToken();

  if (token != null) {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'];
    } else {
      debugPrint("Erreur lors de la récupération du joueur : ${response.body}");
      return null;
    }
  } else {
    debugPrint("Erreur : le token est nul");
    return null;
  }
}

Future<bool> sendChallenge(String gameId, Map<String, dynamic> challenge) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/challenges');
  String? token = await getToken();

  final body = {
    "first_word": challenge["first_word"] ?? '',
    "second_word": challenge["second_word"] ?? '',
    "third_word": challenge["third_word"] ?? '',
    "fourth_word": challenge["fourth_word"] ?? '',
    "fifth_word": challenge["fifth_word"] ?? '',
    "forbidden_words": challenge["motsInterdit"] ?? [],
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      return true;
    } else {
      throw Exception('Erreur lors de l\'envoi du challenge : ${response.body}');
    }
  } catch (e) {
    throw Exception('Erreur lors de l\'envoi du challenge : $e');
  }
}

Future<List<dynamic>> fetchMyChallenges(String gameId) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/myChallenges');
  final token = await getToken();


  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Erreur lors de la récupération des challenges");
  }
}

Future<Map<String, dynamic>> regenerateImage(String gameId, String challengeId, String prompt) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/$gameId/challenges/$challengeId/draw');
  final token = await getToken();
  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"},
    body: jsonEncode({"prompt": prompt}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Erreur lors de la régénération de l'image");
  }
}

