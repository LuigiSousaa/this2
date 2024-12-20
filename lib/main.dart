import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/client_home_viewmodel.dart';
import 'package:relier/core/viewmodels/client_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/custom_navbar_viewmodel.dart';
import 'package:relier/core/viewmodels/first_task_post_viewmodel.dart';
import 'package:relier/core/viewmodels/fourth_task_post_viewmodel.dart';
import 'package:relier/core/viewmodels/help_easy_communication_viewmodel.dart';
import 'package:relier/core/viewmodels/help_viewmodel.dart';
import 'package:relier/core/viewmodels/login_viewmodel.dart';
import 'package:relier/core/viewmodels/professional_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/profile_viewmodel.dart';
import 'package:relier/core/viewmodels/second_client_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/second_professional_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/second_task_post_viewmodel.dart';
import 'package:relier/core/viewmodels/splash_viewmodel.dart';
import 'package:relier/core/viewmodels/third_professional_registration_viewmodel.dart';
import 'package:relier/core/viewmodels/third_task_post_viewmodel.dart';
import 'package:relier/core/viewmodels/user_type_viewmodel.dart';
import 'package:relier/ui/views/splash_view.dart';

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
        ChangeNotifierProvider(create: (_) => UserTypeViewModel()),
        ChangeNotifierProvider(create: (_) => CustomNavbarViewModel()),
        ChangeNotifierProvider(create: (_) => ClientHomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => FirstTaskPostViewModel()),
        ChangeNotifierProvider(create: (_) => SecondTaskPostViewModel()),
        ChangeNotifierProvider(create: (_) => ThirdTaskPostViewModel()),
        ChangeNotifierProvider(create: (_) => FourthTaskPostViewModel()),
      ],
      child: MaterialApp(
        title: 'Relier',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5077FF)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
