import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdProfessionalRegistrationViewModel extends ChangeNotifier {
  Future<void> registerProfessional(
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
    String complemento,
    String especialidade,
    String tag_1,
    String tag_2,
    String tag_3,
  ) async {
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
      "complemento": complemento,
      "especialidade": especialidade,
      "tag_1": tag_1,
      "tag_2": tag_2,
      "tag_3": tag_3,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://dolphin-app-4vryx.ondigitalocean.app/api/profissionais'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 400 || response.statusCode == 201) {
        await prefs.setString('userType', 'professional');
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao criar usuário',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    } catch (e) {
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
