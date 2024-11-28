import 'package:flutter/material.dart';
import 'package:relier/ui/views/second_professional_registration_view.dart';

import '../../ui/views/login_view.dart';

class ProfessionalRegistrationViewModel extends ChangeNotifier {
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  void togglePasswordVisibility() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureTextConfirmPassword = !obscureTextConfirmPassword;
    notifyListeners();
  }

  String formatPhone(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    if (input.length > 11) input = input.substring(0, 11);
    if (input.length > 10) {
      return '(${input.substring(0, 2)}) ${input.substring(2, 7)}-${input.substring(7)}';
    } else if (input.length > 6) {
      return '(${input.substring(0, 2)}) ${input.substring(2, 6)}-${input.substring(6)}';
    } else if (input.length > 2) {
      return '(${input.substring(0, 2)}) ${input.substring(2)}';
    } else {
      return input;
    }
  }

  String formatCPF(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    if (input.length > 11) input = input.substring(0, 11);
    if (input.length > 9) {
      return '${input.substring(0, 3)}.${input.substring(3, 6)}.${input.substring(6, 9)}-${input.substring(9)}';
    } else if (input.length > 6) {
      return '${input.substring(0, 3)}.${input.substring(3, 6)}.${input.substring(6)}';
    } else if (input.length > 3) {
      return '${input.substring(0, 3)}.${input.substring(3)}';
    } else {
      return input;
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

  String removeMask(String input) {
    return input.replaceAll(RegExp(r'\D'), '');
  }

  void navigateToSecondRegistration(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String contact,
    String cpf,
    String gender,
    String password,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondProfessionalRegistrationView(
          firstName: firstName,
          lastName: lastName,
          email: email,
          contact: removeMask(contact),
          cpf: removeMask(cpf),
          gender: gender,
          password: password,
        ),
      ),
    );
  }
}
