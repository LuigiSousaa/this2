import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/second_professional_registration_viewmodel.dart';

class SecondProfessionalRegistrationView extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String cpf;
  final String gender;
  final String password;

  const SecondProfessionalRegistrationView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.cpf,
    required this.gender,
    required this.password,
  });

  @override
  State<SecondProfessionalRegistrationView> createState() =>
      _SecondProfessionalRegistrationViewState();
}

class _SecondProfessionalRegistrationViewState
    extends State<SecondProfessionalRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _paisController = TextEditingController();
  final _complementoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cepController.addListener(_onCepChanged);
  }

  void _onCepChanged() async {
    String cep = _cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length == 8) {
      Provider.of<SecondProfessionalRegistrationViewModel>(context,
              listen: false)
          .fetchCepData(cep, (data) {
        setState(() {
          _logradouroController.text = data['logradouro'] ?? '';
          _bairroController.text = data['bairro'] ?? '';
          _cidadeController.text = data['localidade'] ?? '';
          _estadoController.text = data['estado'] ?? '';
          _paisController.text = 'Brasil';
          _complementoController.text = 's/';
        });
      }, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Falha ao consultar o CEP',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      });
    } else {
      setState(() {
        _logradouroController.text = '';
        _bairroController.text = '';
        _cidadeController.text = '';
        _estadoController.text = '';
        _paisController.text = '';
        _complementoController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<SecondProfessionalRegistrationViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/common/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 16),
                // Campo CEP
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'CEP',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _cepController.text = viewModel.formatCep(value);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Logradouro
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _logradouroController,
                    readOnly: true,
                    // Manter readOnly
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Logradouro',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Número
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Número',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Cidade
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _cidadeController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Estado
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _estadoController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Estado',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo País
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _paisController,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'País',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Campo Complemento
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _complementoController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Complemento',
                      labelStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Botão para cadastrar
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F51B5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        viewModel.navigateToThirdRegistration(
                          context,
                          widget.firstName,
                          widget.lastName,
                          widget.email,
                          widget.contact,
                          widget.cpf,
                          widget.gender,
                          widget.password,
                          _logradouroController.text,
                          _bairroController.text,
                          _numeroController.text,
                          _cepController.text,
                          _cidadeController.text,
                          _estadoController.text,
                          _paisController.text,
                          _complementoController.text,
                        );
                      }
                    },
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.transparent, Colors.white],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'ou',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.transparent, Colors.white],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        child: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => viewModel.navigateToLogin(context),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      children: [
                        TextSpan(
                          text: 'Já tem uma conta? ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Entre',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
