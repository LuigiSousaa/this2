import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondClientRegistrationViewModel extends ChangeNotifier {
  String formatCep(String cep) {
    if (cep.length == 8) {
      return "${cep.substring(0, 5)}-${cep.substring(5, 8)}";
    } else {
      return cep;
    }
  }

  Future<void> fetchCepData(
      String cep,
      void Function(Map<String, dynamic>) onSuccess,
      void Function() onError) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        onSuccess(data);
      } else {
        onError();
      }
    } catch (e) {
      onError();
    }
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (contextNew) => const LoginView(),
      ),
    );
  }

  Future<void> registerClient(
      BuildContext context,
      String firstName,
      String lastName,
      String email,
      String contact,
      String cpf,
      String gender,
      String password,
      String logradouro,
      String bairro,
      String numero,
      String cep,
      String cidade,
      String estado,
      String pais,
      String complemento) async {
    final prefs = await SharedPreferences.getInstance();
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "celular": contact,
      "cpf": cpf,
      "genero": gender,
      "logradouro": logradouro,
      "bairro": bairro,
      "numero": numero,
      "cep": cep,
      "cidade": cidade,
      "estado": estado,
      "pais": pais,
      "complemento": complemento
    };

    try {
      final response = await http.post(
        Uri.parse('https://dolphin-app-4vryx.ondigitalocean.app/api/users'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode != 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao criar usuário',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      } else {
        await prefs.setString('userType', 'client');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Usuário criado com sucesso',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (contextNew) => const LoginView(),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Falha ao criar o usuário',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}
