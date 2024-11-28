import 'package:flutter/material.dart';

class ProfessionalHomeView extends StatefulWidget {
  const ProfessionalHomeView({super.key});

  @override
  State<ProfessionalHomeView> createState() => _ProfessionalHomeViewState();
}

class _ProfessionalHomeViewState extends State<ProfessionalHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional'),
      ),
    );
  }
}
