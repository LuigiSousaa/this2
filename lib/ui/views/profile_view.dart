import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).loadUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                  buildTextField("First Name", viewModel.userInfo["firstName"]),
                  const SizedBox(height: 10),
                  buildTextField("Last Name", viewModel.userInfo["lastName"]),
                  const SizedBox(height: 10),
                  buildTextField("Email", viewModel.userInfo["email"]),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      buildTextField("Celular", viewModel.userInfo["celular"]),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                        onPressed: () => viewModel.navigateToEditPhone(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      buildTextField("Password", viewModel.userInfo["password"]),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                        onPressed: () => viewModel.navigateToEditPassword(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildTextField("CPF", viewModel.userInfo["cpf"]),
                  const SizedBox(height: 10),
                  buildTextField("Gênero", viewModel.userInfo["genero"]),
                  const SizedBox(height: 20),
                  buildAddressSection(viewModel),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => viewModel.logout(context),
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

  Widget buildAddressSection(ProfileViewModel viewModel) {
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
              buildTextField("Logradouro", viewModel.userInfo["logradouro"]),
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
                onPressed: () => viewModel.navigateToEditAddress(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          buildTextField("Bairro", viewModel.userInfo["bairro"]),
          const SizedBox(height: 10),
          buildTextField("Número", viewModel.userInfo["numero"]),
          const SizedBox(height: 10),
          buildTextField("CEP", viewModel.userInfo["cep"]),
          const SizedBox(height: 10),
          buildTextField("Cidade", viewModel.userInfo["cidade"]),
          const SizedBox(height: 10),
          buildTextField("Estado", viewModel.userInfo["estado"]),
          const SizedBox(height: 10),
          buildTextField("País", viewModel.userInfo["pais"]),
          const SizedBox(height: 10),
          buildTextField("Complemento", viewModel.userInfo["complemento"]),
        ],
      ),
    );
  }
}