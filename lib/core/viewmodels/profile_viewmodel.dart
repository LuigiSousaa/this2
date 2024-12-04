import 'package:flutter/material.dart';
import 'package:relier/ui/views/edit_address_view.dart';
import 'package:relier/ui/views/edit_password_view.dart';
import 'package:relier/ui/views/edit_phone_view.dart';
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileViewModel extends ChangeNotifier {
  Map<String, String> _userInfo = {};
  bool _isLoading = true;

  Map<String, String> get userInfo => _userInfo;

  bool get isLoading => _isLoading;

  Future<void> loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _userInfo = {
        "firstName": prefs.getString("firstName") ?? "",
        "lastName": prefs.getString("lastName") ?? "",
        "email": prefs.getString("email") ?? "",
        "password": prefs.getString("password") ?? "",
        "celular": prefs.getString("celular") ?? "",
        "cpf": prefs.getString("cpf") ?? "",
        "genero": prefs.getString("genero") ?? "",
        "logradouro": prefs.getString("logradouro") ?? "",
        "bairro": prefs.getString("bairro") ?? "",
        "numero": prefs.getString("numero") ?? "",
        "cep": prefs.getString("cep") ?? "",
        "cidade": prefs.getString("cidade") ?? "",
        "estado": prefs.getString("estado") ?? "",
        "pais": prefs.getString("pais") ?? "",
        "complemento": prefs.getString("complemento") ?? "",
      };
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void navigateToEditPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditPasswordView()),
    );
  }

  void navigateToEditAddress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditAddressView()),
    );
  }

  void navigateToEditPhone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditPhoneView()),
    );
  }

  Future<void> logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUsuario = prefs.getString('id_user');

      if (idUsuario != null) {
        final response = await http.post(
          Uri.parse('https://url/api/logout/$idUsuario'),
        );

        if (response.statusCode == 200) {
          await prefs.remove('id_user');
          prefs.setBool('first_access', true);
          await prefs.remove('userType');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout realizado com sucesso!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao realizar o logout!')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar logout: $e')),
      );
    }
  }
}
