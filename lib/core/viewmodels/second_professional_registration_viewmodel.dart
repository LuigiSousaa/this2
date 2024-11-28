import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/login_view.dart';

import '../../ui/views/third_professional_registration_view.dart';

class SecondProfessionalRegistrationViewModel extends ChangeNotifier {
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

  void navigateToThirdRegistration(
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
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThirdProfessionalRegistrationView(
          firstName: firstName,
          lastName: lastName,
          email: email,
          contact: contact,
          cpf: cpf,
          gender: gender,
          password: password,
          logradouro: logradouro,
          bairro: bairro,
          pais: pais,
          numero: numero,
          cep: cep,
          cidade: cidade,
          estado: estado,
          complemento: complemento,
        ),
      ),
    );
  }
}
