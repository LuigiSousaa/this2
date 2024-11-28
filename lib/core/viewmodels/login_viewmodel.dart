import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/client_home_view.dart';
import 'package:relier/ui/views/professional_home_view.dart';
import 'package:relier/ui/views/user_type_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  bool _obscureText = true;
  bool _errorLogin = false;
  bool _isLoading = false;

  bool get obscureText => _obscureText;

  bool get errorLogin => _errorLogin;

  bool get isLoading => _isLoading;

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void navigateToRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserTypeView(),
      ),
    );
  }

  Future<void> login(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://dolphin-app-4vryx.ondigitalocean.app/api/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode != 201) {
        _errorLogin = true;
      } else {
        final responseBody = jsonDecode(response.body);
        _errorLogin = false;
        prefs.setBool('first_access', false);
        prefs.setString('token', responseBody['token']);

        final isProfessional = responseBody['user']['isProfissional'];
        prefs.setString('userType', isProfessional ? 'professional' : 'client');

        emailController.clear();
        passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (contextNew) => isProfessional
                ? const ProfessionalHomeView()
                : const ClientHomeView(),
          ),
        );
      }
    } catch (e) {
      _errorLogin = true;
      print("Erro no login: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
