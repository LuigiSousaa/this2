import 'package:flutter/material.dart';

class ThirdTaskPostViewModel extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get captionController => _captionController;

  bool get isButtonEnabled =>
      _titleController.text.isNotEmpty && _captionController.text.isNotEmpty;

  ThirdTaskPostViewModel() {
    _titleController.addListener(_onTextChanged);
    _captionController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _captionController.dispose();
    super.dispose();
  }
}
