import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/first_task_post_viewmodel.dart';

class FirstTaskPostView extends StatelessWidget {
  const FirstTaskPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FirstTaskPostViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'O que você procura?',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF575757)),
                ),
                child: Column(
                  children: [
                    for (var option in viewModel.options)
                      OptionItem(
                        label: option['label'],
                        onTap: () => viewModel.navigateToSecondTaskPost(context, option['specialty']), // Passa a especialidade para o ViewModel
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class OptionItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const OptionItem({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF7696FF)),
      onTap: onTap,
    );
  }
}