import 'package:flutter/material.dart';
import 'package:relier/ui/views/client_home_view.dart';
import 'package:relier/ui/views/company_home_view.dart';
import 'package:relier/ui/views/professional_home_view.dart';
import 'package:relier/ui/views/help_view.dart';
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> navigateToNextView(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool? firstAccess = prefs.getBool('first_access');
    if (firstAccess == null) {
      await prefs.setBool('first_access', true);
      firstAccess = true;
    }
    final userType = prefs.getString('userType');

    await Future.delayed(const Duration(seconds: 5), () {
      if (firstAccess == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HelpView()),
        );
      } else {
        switch (userType) {
          case 'client':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ClientHomeView()),
            );
            break;
          case 'professional':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfessionalHomeView()),
            );
            break;
          case 'company':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CompanyHomeView()),
            );
            break;
          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
            break;
        }
      }
    });
  }
}
