import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends ChangeNotifier {
  final RegisterService registerService = RegisterService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> registerAndGetToken(BuildContext context) async {
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      print('All fields are required');
      return;
    }

    final String? token =
        await registerService.getToken(email, password, username);
    if (token != null) {
      // Registration successful, store token in SharedPreferences
      await _saveToken(token);

      // You can also navigate to another screen or perform other actions here
      log('Token received: $token');
    } else {
      // Registration failed, show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
