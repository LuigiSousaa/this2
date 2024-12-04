import 'package:flutter/material.dart';

class EditAddressView extends StatefulWidget {
  const EditAddressView({super.key});

  @override
  State<EditAddressView> createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
      ),
    );
  }
}
