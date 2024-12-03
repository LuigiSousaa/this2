import 'package:flutter/material.dart';
import 'package:relier/ui/views/first_task_post_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHomeViewModel extends ChangeNotifier {
  String _name = '';
  bool _isLoading = true;

  String get name => _name;

  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> get cardData => [
        {
          'icon': Icons.construction,
          'color': Colors.blue[600],
          'label': 'Construções\n& Obras'
        },
        {
          'icon': Icons.plumbing,
          'color': Colors.blue[600],
          'label': 'Encanamento'
        },
        {'icon': Icons.eco, 'color': Colors.blue[600], 'label': 'Jardinagem'},
        {
          'icon': Icons.format_paint,
          'color': Colors.blue[600],
          'label': 'Pinturas'
        },
        {'icon': Icons.bolt, 'color': Colors.blue[600], 'label': 'Elétrica'},
        {'icon': Icons.layers, 'color': Colors.blue[600], 'label': 'Outros'},
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
}
