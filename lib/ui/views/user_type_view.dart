import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/ui/views/client_registration_view.dart';
import 'package:relier/ui/views/professional_registration_view.dart';

import '../../core/viewmodels/user_type_viewmodel.dart';

class UserTypeView extends StatefulWidget {
  const UserTypeView({super.key});

  @override
  State<UserTypeView> createState() => _UserTypeViewState();
}

class _UserTypeViewState extends State<UserTypeView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserTypeViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/common/icon.png',
              height: 200,
            ),
            const SizedBox(height: 50),
            const Text(
              'Como deseja se cadastrar?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => viewModel.navigateToClientRegistration(context),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cliente',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => viewModel.navigateToProfessionalRegistration(context),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Profissional',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
