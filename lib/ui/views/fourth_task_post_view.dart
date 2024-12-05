import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/fourth_task_post_viewmodel.dart';

class FourthTaskPostView extends StatelessWidget {
  final String specialty;
  final String subspecialtyspecialty;
  final String title;
  final String caption;

  const FourthTaskPostView({
    super.key,
    required this.specialty,
    required this.subspecialtyspecialty,
    required this.title,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FourthTaskPostViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF292929),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/fourth_tp/address_bro.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              for (String option in viewModel.options)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 17.0),
                  child: GestureDetector(
                    onTap: () => viewModel.selectOption(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: viewModel.selectedOption == option
                              ? const Color(0xFF7696FF)
                              : const Color(0xFF3E3E3E),
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: viewModel.selectedOption == option
                                    ? const Color(0xFF7696FF)
                                    : Colors.white,
                                fontSize: 16,
                              ),
                              child: Text(option),
                            ),
                          ),
                          CustomRadioButton(
                              isSelected: viewModel.selectedOption == option),
                        ],
                      ),
                    ),
                  ),
                ),
              if (viewModel.selectedOption == 'Outro') ...[
                const SizedBox(height: 20),
                ...viewModel.buildTextFields(context),
              ],
              const SizedBox(height: 40),
              SizedBox(
                width: 230,
                child: ElevatedButton(
                  onPressed: viewModel.selectedOption != null
                      ? () async {
                          await viewModel.submitTask(context, specialty,
                              subspecialtyspecialty, title, caption);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: viewModel.selectedOption != null
                        ? const Color(0xFF7696FF)
                        : Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    'Publicar tarefa ->',
                    style: TextStyle(
                      color: viewModel.selectedOption != null
                          ? Colors.black
                          : Colors.white,
                    ),
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

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;

  const CustomRadioButton({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF7696FF) : Colors.transparent,
        border: Border.all(
          color: isSelected ? const Color(0xFF7696FF) : const Color(0xFF575757),
          width: 2,
        ),
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isSelected ? 1 : 0,
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
