import 'package:flutter/material.dart';

class EditPhoneView extends StatefulWidget {
  const EditPhoneView({super.key});

  @override
  State<EditPhoneView> createState() => _EditPhoneViewState();
}

class _EditPhoneViewState extends State<EditPhoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone'),
      ),
    );
  }
}
