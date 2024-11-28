import 'package:flutter/material.dart';
import 'package:relier/ui/views/login_view.dart';

class HelpViewModel extends ChangeNotifier {
  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (contextNew) => const LoginView(),
      ),
    );
  }
}
