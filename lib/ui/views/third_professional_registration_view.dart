import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/third_professional_registration_viewmodel.dart';

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

class _ThirdProfessionalRegistrationViewState extends State<ThirdProfessionalRegistrationView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ThirdProfessionalRegistrationViewModel>(context, listen: false).fetchSpecialities(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ThirdProfessionalRegistrationViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Center(
            child: viewModel.isLoading
                ? const CircularProgressIndicator()
                : Column(
                children: [
                const SizedBox(height: 24),
            Image.asset(
              'assets/images/common/logo.png',
              height: 150,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              width: 300,
              child: DropdownButton<String>(
                hint: const Text(
                  "Selecione uma especialidade",
                  style: TextStyle(color: Colors.white),
                ),
                value: viewModel.selectedSpeciality,
                isExpanded: true,
                items: [
                  for (var key in viewModel.specialities.keys)
                    DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        key.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: viewModel.selectedSpeciality == key
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                ],
                onChanged: viewModel.onSpecialitySelected,
              ),
            ),
            const SizedBox(height: 16),
            if (viewModel.tags.isNotEmpty) ...[
        SizedBox(
        height: 50,
        width: 300,
        child: DropdownButton<String>(
          hint: const Text(
            "Selecione a primeira tag",
            style: TextStyle(color: Colors.white),
          ),
          value: viewModel.selectedTag1,
          isExpanded: true,
          items: [
            for (var tag in viewModel.tags)
              DropdownMenuItem<String>(
                value: tag,
                child: Text(
                  tag.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    color: viewModel.selectedTag1 == tag
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              )
          ],
          onChanged: viewModel.setSelectedTag1,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 50,
        width: 300,
        child: DropdownButton<String>(
          hint: const Text(
            "Selecione a segunda tag",
            style: TextStyle(color: Colors.white),
          ),
          value: viewModel.selectedTag2,
          isExpanded: true,
          items: [
            for (var tag in viewModel.tags)
              DropdownMenuItem<String>(
                value: tag,
                child: Text(
                  tag.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    color: viewModel.selectedTag2 == tag
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
          ],
          onChanged: viewModel.setSelectedTag2,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        height: 50,
        width: 300,
        child: DropdownButton<String>(
          hint: const Text(
            "Selecione a terceira tag",
            style: TextStyle(color: Colors.white),
          ),
          value: viewModel.selectedTag3,
          isExpanded: true,
          items: [
            for (var tag in viewModel.tags)
              DropdownMenuItem<String>(
                value: tag,
                child: Text(
                  tag.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    color: viewModel.selectedTag3 == tag
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              )
          ],
          onChanged: viewModel.setSelectedTag3,
        ),
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (viewModel.selectedSpeciality != null &&
                viewModel.selectedTag1 != null &&
                viewModel.selectedTag2 != null &&
                viewModel.selectedTag3 != null) {

              viewModel.registerProfessional(
                context,
                widget.firstName,
                widget.lastName,
                widget.email,
                widget.contact,
                widget.cpf,
                widget.gender,
                widget.password,
                widget.logradouro,
                widget.bairro,
                widget.numero,
                widget.cep,
                widget.cidade,
                widget.estado,
                widget.pais,
                widget.complemento,
                viewModel.selectedSpeciality!,
                viewModel.selectedTag1!,
                viewModel.selectedTag2!,
                viewModel.selectedTag3!,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, selecione todas as opções.')));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F51B5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Cadastrar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
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