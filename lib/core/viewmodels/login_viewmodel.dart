import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/client_home_view.dart';
import 'package:relier/ui/views/professional_home_view.dart';
import 'package:relier/ui/views/user_type_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/views/client_service_history_view.dart';
import '../../ui/views/professional_service_history_view.dart';
import '../../ui/views/profile_view.dart';
import '../../ui/widgets/custom_navbar_view.dart';

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

      if (response.statusCode != 200) {
        _errorLogin = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email ou senha inválidos',
            ),
          ),
        );
      } else {
        final responseBody = jsonDecode(response.body);
        _errorLogin = false;
        prefs.setBool('first_access', false);
        prefs.setString('token', responseBody['token']);

        prefs.setString('name', responseBody['user']['firstName']);

        final isProfessional = responseBody['user']['isProfissional'];
        prefs.setString('userType', isProfessional ? 'professional' : 'client');

        emailController.clear();
        passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CustomNavbarView(
              pages: isProfessional
                  ? const [
                      ProfessionalHomeView(),
                      ProfessionalServiceHistoryView(),
                      ProfileView(),
                    ]
                  : const [
                      ClientHomeView(),
                      ClientServiceHistoryView(),
                      ProfileView(),
                    ],
              navItems: isProfessional
                  ? const [
                      GButton(icon: Icons.home_outlined, text: 'Dashboard'),
                      GButton(icon: Icons.work_outline, text: 'Serviços'),
                      GButton(icon: Icons.person_outline, text: 'Perfil'),
                    ]
                  : const [
                      GButton(icon: Icons.home_outlined, text: 'Início'),
                      GButton(icon: Icons.wallet_outlined, text: 'Histórico'),
                      GButton(icon: Icons.person_outline, text: 'Perfil'),
                    ],
            ),
          ),
        );
      }
    } catch (e) {
      _errorLogin = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
