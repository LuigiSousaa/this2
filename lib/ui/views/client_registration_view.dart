import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/client_registration_viewmodel.dart';

class ClientRegistrationView extends StatefulWidget {
  const ClientRegistrationView({super.key});

  @override
  ClientRegistrationViewState createState() => ClientRegistrationViewState();
}

class ClientRegistrationViewState extends State<ClientRegistrationView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _cpfController = TextEditingController();
  String gender = '';
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ClientRegistrationViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/common/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 16),
                // Nome
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nome',
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

                // Sobrenome
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Sobrenome',
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
                // Email
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                // Celular
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _contactController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      _contactController.value = TextEditingValue(
                        text: viewModel.formatPhone(value),
                        selection: TextSelection.collapsed(
                          offset: viewModel.formatPhone(value).length,
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'Celular',
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
                // CPF
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      _cpfController.value = TextEditingValue(
                        text: viewModel.formatCPF(value),
                        selection: TextSelection.collapsed(
                          offset: viewModel.formatCPF(value).length,
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      labelText: 'CPF',
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

                const SizedBox(height: 16),
                // Gênero
                SizedBox(
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qual seu gênero?',
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                'Masculino',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              leading: Radio<String>(
                                value: 'masculino',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text(
                                'Feminino',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              leading: Radio<String>(
                                value: 'feminino',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Senha
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: viewModel.obscureTextPassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: GestureDetector(
                        onTap: () => viewModel.togglePasswordVisibility(),
                        child: Icon(
                          viewModel.obscureTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
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
                // Confirma senha
                SizedBox(
                  width: 320,
                  height: 56,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: viewModel.obscureTextConfirmPassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Confirmação de senha',
                      labelStyle: const TextStyle(color: Colors.white),
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            viewModel.toggleConfirmPasswordVisibility(),
                        child: Icon(
                          viewModel.obscureTextConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (_confirmPasswordController.text !=
                          _passwordController.text) {
                        return 'As senhas não coincidem';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),
                // Botão de continuar
                SizedBox(
                  width: 320,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.navigateToSecondRegistration(
                          context,
                          _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _contactController.text,
                          _cpfController.text,
                          gender,
                          _passwordController.text,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xFF3F51B5)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
