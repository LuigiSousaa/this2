import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ThirdProfessionalRegistrationView extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String cpf;
  final String gender;
  final String password;
  final String logradouro;
  final String bairro;
  final String numero;
  final String cep;
  final String cidade;
  final String estado;
  final String pais;
  final String complemento;

  const ThirdProfessionalRegistrationView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.cpf,
    required this.gender,
    required this.password,
    required this.logradouro,
    required this.bairro,
    required this.numero,
    required this.cep,
    required this.cidade,
    required this.estado,
    required this.pais,
    required this.complemento,
  });

  @override
  State<ThirdProfessionalRegistrationView> createState() =>
      _ThirdProfessionalRegistrationViewState();
}

class _ThirdProfessionalRegistrationViewState
    extends State<ThirdProfessionalRegistrationView> {
  Map<String, List<String>> specialities = {};
  String? selectedSpeciality;
  List<String> tags = [];
  String? selectedTag1;
  String? selectedTag2;
  String? selectedTag3;

  @override
  void initState() {
    super.initState();
    fetchSpecialities();
  }

  Future<void> fetchSpecialities() async {
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

        setState(() {
          specialities = parsedSpecialities;
        });
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
    }
  }

  void onSpecialitySelected(String? speciality) {
    setState(() {
      selectedSpeciality = speciality;
      tags = specialities[speciality] ?? [];
      selectedTag1 = null;
      selectedTag2 = null;
      selectedTag3 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Image.asset(
                'assets/images/common/logo.png',
                height: 150,
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                hint: const Text(
                  "Selecione uma especialidade",
                  style: TextStyle(color: Colors.white),
                ),
                value: selectedSpeciality,
                isExpanded: true,
                items: [
                  for (var key in specialities.keys)
                    DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        key.replaceAll('_', ' ').toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
                onChanged: onSpecialitySelected,
              ),
              const SizedBox(height: 16),
              if (tags.isNotEmpty) ...[
                SizedBox(
                  height: 50,
                  width: 250,
                  child: DropdownButton<String>(
                    hint: const Text(
                      "Selecione a primeira tag",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: selectedTag1,
                    isExpanded: true,
                    items: [
                      for (var tag in tags)
                        DropdownMenuItem<String>(
                          value: tag,
                          child: Text(
                            tag.replaceAll('_', ' ').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                    onChanged: (value) => setState(() {
                      selectedTag1 = value;
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: DropdownButton<String>(
                    hint: const Text(
                      "Selecione a segunda tag",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: selectedTag2,
                    isExpanded: true,
                    items: [
                      for (var tag in tags)
                        DropdownMenuItem<String>(
                          value: tag,
                          child: Text(
                            tag.replaceAll('_', ' ').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                    onChanged: (value) => setState(() {
                      selectedTag2 = value;
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: DropdownButton<String>(
                    hint: const Text(
                      "Selecione a terceira tag",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    value: selectedTag3,
                    isExpanded: true,
                    items: [
                      for (var tag in tags)
                        DropdownMenuItem<String>(
                          value: tag,
                          child: Text(
                            tag.replaceAll('_', ' ').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                    onChanged: (value) => setState(() {
                      selectedTag3 = value;
                    }),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
