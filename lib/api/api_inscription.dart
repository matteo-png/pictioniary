import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> inscription(String name, String password) async {
  final url = Uri.parse('https://pictioniary.wevox.cloud/api/players');
  await http.post(
    url,
    body: {
      'name': name,
      'password': password,
    },
  );
    return true;
}
