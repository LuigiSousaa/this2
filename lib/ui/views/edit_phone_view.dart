import 'package:flutter/material.dart';

class EditPhoneView extends StatefulWidget {
  const EditPhoneView({super.key});

  @override
  State<EditPhoneView> createState() => _EditPhoneViewState();
}

class _EditPhoneViewState extends State<EditPhoneView> {
  final TextEditingController _phoneController = TextEditingController();

  String formatPhone(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    if (input.length > 11) input = input.substring(0, 11);
    if (input.length > 10) {
      return '(${input.substring(0, 2)}) ${input.substring(2, 7)}-${input.substring(7)}';
    } else if (input.length > 6) {
      return '(${input.substring(0, 2)}) ${input.substring(2, 6)}-${input.substring(6)}';
    } else if (input.length > 2) {
      return '(${input.substring(0, 2)}) ${input.substring(2)}';
    } else {
      return input;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: '(19) 12345-6789',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  final formattedValue = formatPhone(value);
                  _phoneController.value = TextEditingValue(
                    text: formattedValue,
                    selection: TextSelection.collapsed(offset: formattedValue.length),
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5077FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _phoneController.clear();
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
