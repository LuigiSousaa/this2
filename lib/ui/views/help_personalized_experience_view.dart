import 'package:flutter/material.dart';

class HelpPersonalizedExperienceView extends StatelessWidget {
  const HelpPersonalizedExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/help_pe/personalized_experience.png',
              height: 350,
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 165,
              width: 290,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Experiência personalizada\ne segura',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Receba sugestões de serviços e profissionais de\nacordo com seu perfil e localização, seja para\ncontratar ou oferecer seus serviços. Nossa\nplataforma garante um ambiente seguro para\nnosso usuários.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
