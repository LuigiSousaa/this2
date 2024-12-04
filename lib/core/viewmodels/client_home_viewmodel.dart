import 'package:flutter/material.dart';
import 'package:relier/ui/views/first_task_post_view.dart';
import 'package:relier/ui/views/second_task_post_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHomeViewModel extends ChangeNotifier {
  String _name = '';
  bool _isLoading = true;

  String get name => _name;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> get cardData => [
        {
          'image': 'assets/images/client_home/constructions_and_works.png',
          'label': 'Construções\n& Obras',
        },
        {
          'image': 'assets/images/client_home/plumbing.png',
          'label': 'Encanamento',
        },
        {
          'image': 'assets/images/client_home/gardening.png',
          'label': 'Jardinagem',
        },
        {
          'image': 'assets/images/client_home/painting.png',
          'label': 'Pinturas',
        },
        {
          'image': 'assets/images/client_home/electrical.png',
          'label': 'Elétrica',
        },
        {
          'image': 'assets/images/client_home/other.png',
          'label': 'Outro',
        },
      ];

  Future<void> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final nameUser = prefs.getString('name');

    _name = nameUser ?? 'usuário';
    _isLoading = false;
    notifyListeners();
  }

  void navigateToTaskPost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FirstTaskPostView()),
    );
  }

  void navigateToSecondTaskPost(BuildContext context,
      {required String specialty}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondTaskPostView(specialty: specialty)),
    );
  }
}
