import 'package:flutter/material.dart';
import 'package:relier/ui/views/login_view.dart';

class HelpEasyCommunicationViewmodel extends ChangeNotifier {
  void onButtonPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (contextNew) => const LoginView(),
      ),
    ); // Placeholder
  }
}
