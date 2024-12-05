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
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    if (viewModel.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    String userName = viewModel.userInfo["firstName"]?.isEmpty ?? true
        ? "Nome do Usuário"
        : viewModel.userInfo["firstName"]!;

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
                  height: 110,
                  decoration: const BoxDecoration(
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
                    backgroundColor: Color(0xFF1F1F1F),
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            Column(
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Assinante Básico",
                  style: TextStyle(
                    color: Color(0xFF0800FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Informações do Usuário',
                      style: TextStyle(
                        color: Color(0xFFCDCDCD),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextField("First Name", viewModel.userInfo["firstName"]),
                  const SizedBox(height: 12),
                  buildTextField("Last Name", viewModel.userInfo["lastName"]),
                  const SizedBox(height: 12),
                  buildTextField("Email", viewModel.userInfo["email"]),
                  const SizedBox(height: 12),
                  buildEditableField(
                    "Celular",
                    viewModel.userInfo["celular"],
                        () => viewModel.navigateToEditPhone(context),
                  ),
                  const SizedBox(height: 12),
                  buildEditableField(
                    "Password",
                    viewModel.userInfo["password"],
                        () => viewModel.navigateToEditPassword(context),
                  ),
                  const SizedBox(height: 12),
                  buildTextField("CPF", viewModel.userInfo["cpf"]),
                  const SizedBox(height: 12),
                  buildTextField("Gênero", viewModel.userInfo["genero"]),
                  const SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Endereço",
                          style: TextStyle(
                            color: Color(0xFFCDCDCD),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          onPressed: () => viewModel.navigateToEditAddress(context),
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF5077FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildAddressSection(viewModel),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => viewModel.logout(context),
              child: const Text(
                'Sair',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  Widget buildTextField(String label, String? value) {
    return TextFormField(
      initialValue: value,
      enabled: false,
      obscureText: label == "Password",
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget buildEditableField(String label, String? value, VoidCallback onEdit) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        buildTextField(label, value),
        IconButton(
          icon: const Icon(Icons.edit, color: Color(0xFF5077FF)),
          onPressed: onEdit,
        ),
      ],
    );
  }

  Widget buildAddressSection(ProfileViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          buildTextField("Logradouro", viewModel.userInfo["logradouro"]),
          const SizedBox(height: 12),
          buildTextField("Bairro", viewModel.userInfo["bairro"]),
          const SizedBox(height: 12),
          buildTextField("Número", viewModel.userInfo["numero"]),
          const SizedBox(height: 12),
          buildTextField("CEP", viewModel.userInfo["cep"]),
          const SizedBox(height: 12),
          buildTextField("Cidade", viewModel.userInfo["cidade"]),
          const SizedBox(height: 12),
          buildTextField("Estado", viewModel.userInfo["estado"]),
          const SizedBox(height: 12),
          buildTextField("País", viewModel.userInfo["pais"]),
          const SizedBox(height: 12),
          buildTextField("Complemento", viewModel.userInfo["complemento"]),
        ],
      ),
    );
  }
}
