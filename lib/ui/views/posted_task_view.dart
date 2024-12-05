import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:relier/ui/views/client_home_view.dart';
import 'package:relier/ui/views/professional_home_view.dart';
import 'package:relier/ui/views/professional_service_history_view.dart';
import 'package:relier/ui/views/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_navbar_view.dart';
import 'client_service_history_view.dart';

class PostedTaskView extends StatelessWidget {
  const PostedTaskView({super.key});

  Future<void> _checkUserType(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType') ?? '';

    if (userType == 'client') {
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
    } else if (userType == 'professional') {
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
    } else {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/common/icon.png',
                  width: 80,
                  height: 80,
                ),
                // Botão de fechar
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    _checkUserType(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seu pedido foi enviado!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Iniciamos a busca dos melhores profissionais para você!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/posted_task/checkIcon.png',
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fique atento em:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Column(
              children: [
                Row(
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                        color: Color(0xFF7696FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tempo de busca',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      '2',
                      style: TextStyle(
                        color: Color(0xFF7696FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Profissionais encontrados',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        color: Color(0xFF7696FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Contato com o profissional',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      '4',
                      style: TextStyle(
                        color: Color(0xFF7696FF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Negociação e contato',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 230,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7696FF),
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Acompanhar pedido',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
