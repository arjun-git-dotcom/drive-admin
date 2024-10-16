import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authservices {
  final String baseurl = 'http://10.0.2.2:3001/api/auth/admin/login';

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseurl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String? token = data['accessToken'];
        

        // Save token to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);
        return token;
      } else {
       
        debugPrint('Login failed: ${response.body}');
        return null;
      }
    } catch (e) {
     
      debugPrint('Error occurred: $e');
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }
}
