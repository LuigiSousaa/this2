import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relier/ui/views/company_home_view.dart';
import 'package:relier/ui/views/company_history_products_sold_view.dart';
import 'package:relier/ui/views/help_view.dart';
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/views/client_home_view.dart';
import '../../ui/views/client_service_history_view.dart';
import '../../ui/views/professional_home_view.dart';
import '../../ui/views/professional_service_history_view.dart';
import '../../ui/views/profile_view.dart';
import '../../ui/widgets/custom_navbar_view.dart';

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
              MaterialPageRoute(
                builder: (context) => const CustomNavbarView(
                  pages: [
                    ClientHomeView(),
                    ClientServiceHistoryView(),
                    ProfileView(),
                  ],
                  navItems: [
                    GButton(icon: Icons.home_outlined, text: 'Início'),
                    GButton(icon: Icons.wallet_outlined, text: 'Histórico'),
                    GButton(icon: Icons.person_outline, text: 'Perfil'),
                  ],
                ),
              ),
            );
            break;
          case 'professional':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavbarView(
                  pages:  [
                    ProfessionalHomeView(),
                    ProfessionalServiceHistoryView(),
                    ProfileView(),
                  ],
                  navItems:  [
                    GButton(icon: Icons.home_outlined, text: 'Dashboard'),
                    GButton(icon: Icons.work_outline, text: 'Serviços'),
                    GButton(icon: Icons.person_outline, text: 'Perfil'),
                  ],
                ),
              ),
            );
            break;
          case 'company':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavbarView(
                  pages:  [
                    CompanyHomeView(),
                    CompanyHistoryProductsSoldView(),
                    ProfileView(),
                  ],
                  navItems:  [
                    GButton(icon: Icons.home_outlined, text: 'Início'),
                    GButton(icon: Icons.attach_money, text: 'Vendas'),
                    GButton(icon: Icons.person_outline, text: 'Perfil'),
                  ],
                ),
              ),
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
