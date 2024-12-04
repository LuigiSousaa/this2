import 'package:flutter/material.dart';
import 'package:relier/ui/views/second_task_post_view.dart';

class FirstTaskPostView extends StatelessWidget {
  const FirstTaskPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
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
                    OptionItem(
                      label: 'Conserto e manutenção',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'construcao_civil'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Encanamento',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'encanamento'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Jardinagem',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'jardinagem'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Pintura',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'pintura'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Elétrica',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'eletrica'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Marcenaria',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'marcenaria'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Montador de móveis',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'montador_moveis'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Instalador',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'instalador'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Reparador',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'reparador'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Limpeza',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'limpeza'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Diarista',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'diarista'),
                          ),
                        );
                      },
                    ),
                    OptionItem(
                      label: 'Cozinheiro',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondTaskPostView(specialty: 'cozinheiro'),
                          ),
                        );
                      },
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
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF7696FF)),
      onTap: onTap,
    );
  }
}