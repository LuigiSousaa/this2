import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/client_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/help_easy_communication_viewmodel.dart';
import 'package:relier/core/viewmodels/help_viewmodel.dart';
import 'package:relier/core/viewmodels/login_viewmodel.dart';
import 'package:relier/core/viewmodels/professional_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/second_client_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/second_professional_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/splash_viewmodel.dart';
import 'package:relier/core/viewmodels/third_professional_registration_viewmodel.dart';
import 'package:relier/ui/views/professional_registration_view.dart';
import 'package:relier/ui/views/third_professional_registration_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => HelpViewModel()),
        ChangeNotifierProvider(create: (_) => HelpEasyCommunicationViewmodel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ClientRegistrationViewModel()),
        ChangeNotifierProvider(
            create: (_) => SecondClientRegistrationViewModel()),
        ChangeNotifierProvider(
            create: (_) => ProfessionalRegistrationViewModel()),
        ChangeNotifierProvider(
            create: (_) => SecondProfessionalRegistrationViewModel()),
        ChangeNotifierProvider(
            create: (_) => ThirdProfessionalRegistrationViewModel()),
      ],
      child: MaterialApp(
          title: 'Relier',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF5077FF)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const ThirdProfessionalRegistrationView(
            firstName: 'Luigi',
            lastName: 'Sousa',
            email: 'tese@gmail.com',
            contact: '19999999999',
            cpf: "55555555555",
            gender: 'masculino',
            password: 'senha123',
            logradouro: 'Rua 12',
            bairro: 'x',
            numero: '123',
            cep: '11111111',
            cidade: 'Limeira',
            estado: 'Sao paulo',
            pais: 'Brasil',
            complemento: 'Apt',
          )),
    );
  }
}
