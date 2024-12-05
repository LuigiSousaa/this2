import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/third_task_post_view.dart';

class SecondTaskPostViewModel extends ChangeNotifier {
  late String specialty;

  SecondTaskPostViewModel();

  List<String> _originalOptions = [];
  List<String> _options = [];
  String? _selectedOption;
  String? _selectedOriginalOption;
  bool _isLoading = true;
  bool _isButtonDisabled = true;


  String get message => _messages[specialty] ?? 'O que você precisa fazer?';

  List<String> get originalOptions => _originalOptions;

  List<String> get options => _options;

  String? get selectedOption => _selectedOption;

  bool get isLoading => _isLoading;

  bool get isButtonDisabled => _isButtonDisabled;


  final Map<String, String> _messages = {
    'construcao_civil': 'O que você precisa para a construção ou reforma?',
    'encanamento': 'Qual serviço de encanamento você precisa realizar?',
    'jardinagem': 'O que você precisa no seu jardim?',
    'pintura': 'Que tipo de pintura você deseja realizar?',
    'eletrica': 'Qual serviço elétrico você precisa?',
    'marcenaria': 'Que serviço de marcenaria você precisa?',
    'montador_moveis': 'O que precisa em relação aos seus móveis?',
    'instalador': 'Qual tipo de instalação você precisa?',
    'reparador': 'Qual reparo você precisa?',
    'limpeza': 'Qual tipo de limpeza você precisa?',
    'diarista': 'Que tipo de serviço a diarista realizará?',
    'cozinheiro': 'Que tipo de serviço culinário você precisa?',
  };

  void setSpecialty(String specialty) {
    this.specialty = specialty;
    notifyListeners();
  }

  Future<void> fetchOptions(BuildContext context) async {
    _selectedOption = null;
    _selectedOriginalOption = null;
    _isButtonDisabled = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://dolphin-app-4vryx.ondigitalocean.app/api/profissionais/especialidades'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        _originalOptions =
        List<String>.from(data['especialidade'][specialty] ?? []);
        _options = _originalOptions
            .map((option) => capitalizeWords(option.replaceAll('_', ' ')))
            .toList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao carregar opções: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar opções: $e')),
      );
    } finally {
      _isButtonDisabled = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  String capitalizeWords(String input) {
    return input.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return '';
    }).join(' ');
  }

  void selectOption(String option, String originalOption) {
    _selectedOption = option;
    _selectedOriginalOption = originalOption;
    _isButtonDisabled = false;
    notifyListeners();
  }


  void navigateToThirdTaskPost(BuildContext context) {
    if (_selectedOriginalOption != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThirdTaskPostView(
            specialty: specialty,
            subspecialtyspecialty: _selectedOriginalOption!,
          ),
        ),
      );
    } else {

    }
  }
}
