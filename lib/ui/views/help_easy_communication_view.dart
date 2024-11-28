import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/help_easy_communication_viewmodel.dart';

class HelpEasyCommunicationView extends StatelessWidget {
  const HelpEasyCommunicationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HelpEasyCommunicationViewmodel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/help_ec/easy_communication.png',
              height: 340,
            ),
            SizedBox(
              height: 216,
              width: 290,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Fácil comunicação e\nsegurança nos contratos',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Converse diretamente com os profissionais ou\nclientes antes de fechar o acordo, tire suas dúvidas\ne combine detalhes. Contamos com sistemas de\nsegurança para proteger suas informações.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 290,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F51B5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => viewModel.onButtonPressed(context),
                      child: const Text(
                        'Iniciar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
