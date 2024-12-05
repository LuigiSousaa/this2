import 'package:flutter/material.dart';
import 'package:relier/ui/views/second_task_post_view.dart';

class FirstTaskPostViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> get options => [
    {'label': 'Conserto e manutenção', 'specialty': 'construcao_civil'},
    {'label': 'Encanamento', 'specialty': 'encanamento'},
    {'label': 'Jardinagem', 'specialty': 'jardinagem'},
    {'label': 'Pintura', 'specialty': 'pintura'},
    {'label': 'Elétrica', 'specialty': 'eletrica'},
    {'label': 'Marcenaria', 'specialty': 'marcenaria'},
    {'label': 'Montador de móveis', 'specialty': 'montador_moveis'},
    {'label': 'Instalador', 'specialty': 'instalador'},
    {'label': 'Reparador', 'specialty': 'reparador'},
    {'label': 'Limpeza', 'specialty': 'limpeza'},
    {'label': 'Diarista', 'specialty': 'diarista'},
    {'label': 'Cozinheiro', 'specialty': 'cozinheiro'},
  ];

  void navigateToSecondTaskPost(BuildContext context, String specialty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondTaskPostView(specialty: specialty),
      ),
    );
  }
}