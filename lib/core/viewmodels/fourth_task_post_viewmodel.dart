import 'package:flutter/material.dart';
import 'package:relier/ui/views/posted_task_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FourthTaskPostViewModel extends ChangeNotifier {
  final List<String> _options = ['Casa', 'Outro'];
  String? selectedOption;

  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController paisController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();

  List<String> get options => _options;

  void selectOption(String option) {
    selectedOption = option;
    notifyListeners();
  }

  List<Widget> buildTextFields(BuildContext context) {
    return [
      buildTextField("CEP", cepController, onChanged: fetchCepData),
      buildTextField("Logradouro", logradouroController),
      buildTextField("Bairro", bairroController),
      buildTextField("Cidade", cidadeController),
      buildTextField("Estado", estadoController),
      buildTextField("Pais", paisController),
      buildTextField("Número", numeroController),
      buildTextField("Complemento", complementoController)
    ];
  }

  Widget buildTextField(String label, TextEditingController controller,
      {ValueChanged<String>? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> fetchCepData(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logradouroController.text = data['logradouro'] ?? '';
        bairroController.text = data['bairro'] ?? '';
        cidadeController.text = data['localidade'] ?? '';
        estadoController.text = data['uf'] ?? '';
        paisController.text = 'Brasil';
        complementoController.text = 's/';
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> submitTask(BuildContext context, String speciality,
      String subspecialtyspecialty, String title, String caption) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ??
        '1|8GLdjDVCTUtdpop5p1lnOJBcj8QAwLvKlShsYEWka8e1a74d';

    String logradouro = selectedOption == 'Casa'
        ? prefs.getString('logradouro') ?? ''
        : logradouroController.text;
    String bairro = selectedOption == 'Casa'
        ? prefs.getString('bairro') ?? ''
        : bairroController.text;
    String cidade = selectedOption == 'Casa'
        ? prefs.getString('cidade') ?? ''
        : cidadeController.text;
    String estado = selectedOption == 'Casa'
        ? prefs.getString('estado') ?? ''
        : estadoController.text;
    String pais = selectedOption == 'Casa'
        ? prefs.getString('pais') ?? 'Brasil'
        : paisController.text;
    String numero = selectedOption == 'Casa'
        ? prefs.getString('numero') ?? ''
        : numeroController.text;
    String complemento = selectedOption == 'Casa'
        ? prefs.getString('complemento') ?? ''
        : complementoController.text;
    String cep = selectedOption == 'Casa'
        ? prefs.getString('cep') ?? ''
        : cepController.text;
    String titulo = title;
    String descricao = caption;
    String especialidade = speciality;
    String subespecialidade = subspecialtyspecialty;

    const url = 'https://dolphin-app-4vryx.ondigitalocean.app/api/tasks';
    final body = {
      "logradouro": logradouro,
      "bairro": bairro,
      "numero": numero,
      "cep": cep,
      "cidade": cidade,
      "estado": estado,
      "pais": pais,
      "complemento": complemento,
      "especialidade": especialidade,
      "subespecialidade": subespecialidade,
      "titulo": titulo,
      "descricao": descricao,
      "data_agendamento": getCurrentDateTime(),
    };


    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tarefa publicada com sucesso",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (contextNew) => const PostedTaskView(),
        ),
      );
    } else {
      print(response.body);
      print(response.statusCode);
      final rb = jsonDecode(response.body);
      print(rb['error']);
      print(cep);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Erro ao publicar tarefa",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  String getCurrentDateTime() {
    return DateTime.now().toIso8601String();
  }
}
