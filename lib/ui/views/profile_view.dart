import 'package:flutter/material.dart';
import 'package:relier/ui/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Map<String, String> userInfo = {};

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userInfo["firstName"] = prefs.getString("firstName") ?? "";
      userInfo["lastName"] = prefs.getString("lastName") ?? "";
      userInfo["email"] = prefs.getString("email") ?? "";
      userInfo["password"] = prefs.getString("password") ?? "";
      userInfo["celular"] = prefs.getString("celular") ?? "";
      userInfo["cpf"] = prefs.getString("cpf") ?? "";
      userInfo["genero"] = prefs.getString("genero") ?? "";
      userInfo["logradouro"] = prefs.getString("logradouro") ?? "";
      userInfo["bairro"] = prefs.getString("bairro") ?? "";
      userInfo["numero"] = prefs.getString("numero") ?? "";
      userInfo["cep"] = prefs.getString("cep") ?? "";
      userInfo["cidade"] = prefs.getString("cidade") ?? "";
      userInfo["estado"] = prefs.getString("estado") ?? "";
      userInfo["pais"] = prefs.getString("pais") ?? "";
      userInfo["complemento"] = prefs.getString("complemento") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: MediaQuery.of(context).size.width / 2 - 80,
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 120,
                      color: Color(0xFF5077FF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  buildTextField("First Name", userInfo["firstName"]),
                  const SizedBox(height: 10),
                  buildTextField("Last Name", userInfo["lastName"]),
                  const SizedBox(height: 10),
                  buildTextField("Email", userInfo["email"]),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      buildTextField("Celular", userInfo["celular"]),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                        onPressed: () {
                          // Navegar para tela de edição
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      buildTextField("Password", userInfo["password"]),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                        onPressed: () {
                          // Navegar para tela de edição
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildTextField("CPF", userInfo["cpf"]),
                  const SizedBox(height: 10),
                  buildTextField("Gênero", userInfo["genero"]),
                  const SizedBox(height: 20),
                  buildAddressSection(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? idUsuario = prefs.getString('id_user');

                if (idUsuario != null) {
                  final response = await http.post(
                    Uri.parse('https://url/api/logout/$idUsuario'),
                  );

                  if (response.statusCode == 200) {
                    await prefs.remove('id_user');
                    prefs.setBool('first_access', true);
                    await prefs.remove('userType');

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Logout realizado com sucesso!')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (contextNew) => const LoginView(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Erro ao realizar o logout!')),
                    );
                  }
                }
              },
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String? value) {
    return TextFormField(
      initialValue: value,
      enabled: false,
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
    );
  }

  Widget buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              buildTextField("Logradouro", userInfo["logradouro"]),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                onPressed: () {
                  // Navegar para tela de edição
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          buildTextField("Bairro", userInfo["bairro"]),
          const SizedBox(height: 10),
          buildTextField("Número", userInfo["numero"]),
          const SizedBox(height: 10),
          buildTextField("CEP", userInfo["cep"]),
          const SizedBox(height: 10),
          buildTextField("Cidade", userInfo["cidade"]),
          const SizedBox(height: 10),
          buildTextField("Estado", userInfo["estado"]),
          const SizedBox(height: 10),
          buildTextField("País", userInfo["pais"]),
          const SizedBox(height: 10),
          buildTextField("Complemento", userInfo["complemento"]),
        ],
      ),
    );
  }
}
