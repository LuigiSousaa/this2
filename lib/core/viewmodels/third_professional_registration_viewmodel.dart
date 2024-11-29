import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdProfessionalRegistrationViewModel extends ChangeNotifier {
  Map<String, List<String>> _specialities = {};
  String? _selectedSpeciality;
  List<String> _tags = [];
  String? _selectedTag1;
  String? _selectedTag2;
  String? _selectedTag3;
  bool _isLoading = false;

  Map<String, List<String>> get specialities => _specialities;

  String? get selectedSpeciality => _selectedSpeciality;

  List<String> get tags => _tags;

  String? get selectedTag1 => _selectedTag1;

  String? get selectedTag2 => _selectedTag2;

  String? get selectedTag3 => _selectedTag3;

  bool get isLoading => _isLoading;

  Future<void> fetchSpecialities(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            'https://dolphin-app-4vryx.ondigitalocean.app/api/profissionais/especialidades'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        Map<String, List<String>> parsedSpecialities = {};
        responseBody['especialidade'].forEach((key, value) {
          parsedSpecialities[key] = List<String>.from(value);
        });

        _specialities = parsedSpecialities;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Erro ao buscar especialidades: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erro ao carregar especialidades.',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
      print("Erro ao carregar especialidades: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onSpecialitySelected(String? speciality) {
    _selectedSpeciality = speciality;
    _tags = _specialities[speciality] ?? [];
    _selectedTag1 = null;
    _selectedTag2 = null;
    _selectedTag3 = null;
    notifyListeners();
  }

  void setSelectedTag1(String? tag) {
    _selectedTag1 = tag;
    notifyListeners();
  }

  void setSelectedTag2(String? tag) {
    _selectedTag2 = tag;
    notifyListeners();
  }

  void setSelectedTag3(String? tag) {
    _selectedTag3 = tag;
    notifyListeners();
  }

  Future<void> registerProfessional(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String contact,
    String cpf,
    String gender,
    String password,
    String logradouro,
    String bairro,
    String numero,
    String cep,
    String cidade,
    String estado,
    String pais,
    String complemento,
    String especialidade,
    String tag_1,
    String tag_2,
    String tag_3,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "celular": contact,
      "cpf": cpf,
      "genero": gender,
      "logradouro": logradouro,
      "bairro": bairro,
      "numero": numero,
      "cep": cep,
      "cidade": cidade,
      "estado": estado,
      "pais": pais,
      "complemento": complemento,
      "especialidade": especialidade,
      "tag_1": tag_1,
      "tag_2": tag_2,
      "tag_3": tag_3,
    };

    try {
      final response = await http.post(
        Uri.parse(
            'https://dolphin-app-4vryx.ondigitalocean.app/api/profissionais'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 400 || response.statusCode == 201) {
        await prefs.setString('userType', 'professional');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Usuário criado com sucesso',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (contextNew) => const LoginView(),
          ),
        );
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao criar usuário',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Falha ao criar o usuário',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}
