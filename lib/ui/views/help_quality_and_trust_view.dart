import 'package:flutter/material.dart';

class HelpQualityAndTrustView extends StatelessWidget {
  const HelpQualityAndTrustView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/help_qat/quality_and_trust.png',
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
                        'Qualidade e confiança em\ncada serviço',
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
                        'Conectamos você aos melhores profissionais,\noferecendo informações claras, avaliações e\nsegurança para contratar com tranquilidade.',
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
