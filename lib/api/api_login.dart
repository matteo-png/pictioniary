import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String name, String password) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/login');
  var response = await http.post(
    url,
    body: {
      'name': name,
      'password': password,
    },
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData.containsKey('token')) {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', responseData['token']);

      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');  // Récupérer le token stocké
  return token;
}

Future<String?> getName() async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/me');

  String? token = await getToken();
  if(null!=token) {
    final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        }
    );
    debugPrint('response:${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('name')) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', responseData['name']);

        return prefs.getString('name');
      } else {
        return '';
      }
    }
  }
  return null;
}