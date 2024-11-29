import 'package:flutter/material.dart';
import 'package:relier/ui/views/client_registration_view.dart';
import 'package:relier/ui/views/professional_registration_view.dart';

class UserTypeViewModel extends ChangeNotifier {

  void navigateToClientRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClientRegistrationView()),
    );
  }

  void navigateToProfessionalRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfessionalRegistrationView()),
    );
  }
}