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

        // prefs.setString('user_id', responseBody['user'][0]);
        prefs.setString('name', responseBody['user']['firstName']);
        prefs.setString('lastName', responseBody['user']['lastName']);
        prefs.setString('email', responseBody['user']['email']);
        prefs.setString('password', passwordController.text);
        prefs.setString('celular', responseBody['user']['celular']);

        final isProfessional = responseBody['user']['isProfissional'];

        String cep = responseBody['user']['isProfissional']
            ? responseBody['user']['profissional']['cep']
            : responseBody['user']['cliente']['cep'];

        cep = formatCep(cep);

        if (isProfessional) {
          prefs.setString('userType', 'professional');
          prefs.setString('cpf', responseBody['user']['profissional']['cpf']);
          prefs.setString(
              'genero', responseBody['user']['profissional']['genero']);
          prefs.setString(
              'logradouro', responseBody['user']['profissional']['logradouro']);
          prefs.setString(
              'bairro', responseBody['user']['profissional']['bairro']);
          prefs.setString(
              'numero', responseBody['user']['profissional']['numero']);
          prefs.setString('cep', cep);
          prefs.setString(
              'cidade', responseBody['user']['profissional']['cidade']);
          prefs.setString(
              'estado', responseBody['user']['profissional']['estado']);
          prefs.setString('pais', responseBody['user']['profissional']['pais']);
          prefs.setString('complemento',
              responseBody['user']['profissional']['complemento']);
        } else {
          prefs.setString('userType', 'client');
          prefs.setString('cpf', responseBody['user']['cliente']['cpf']);
          prefs.setString('genero', responseBody['user']['cliente']['genero']);
          prefs.setString(
              'logradouro', responseBody['user']['cliente']['logradouro']);
          prefs.setString('bairro', responseBody['user']['cliente']['bairro']);
          prefs.setString('numero', responseBody['user']['cliente']['numero']);
          prefs.setString('cep', cep);
          prefs.setString('cidade', responseBody['user']['cliente']['cidade']);
          prefs.setString('estado', responseBody['user']['cliente']['estado']);
          prefs.setString('pais', responseBody['user']['cliente']['pais']);
          prefs.setString(
              'complemento', responseBody['user']['cliente']['complemento']);
        }

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
                      GButton(icon: Icons.chat, text: 'Conversas'),
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

  String formatCep(String cep) {
    if (cep.length == 8) {
      return '${cep.substring(0, 5)}-${cep.substring(5, 8)}';
    }
    return cep;
  }
}
