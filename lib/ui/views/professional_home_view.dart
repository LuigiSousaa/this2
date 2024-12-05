import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfessionalHomeView extends StatefulWidget {
  const ProfessionalHomeView({super.key});

  @override
  HomeProfissionalState createState() => HomeProfissionalState();
}

class HomeProfissionalState extends State<ProfessionalHomeView> {
  bool isProgressSelected = true;
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('https://dolphin-app-4vryx.ondigitalocean.app/api/tasks'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        tasks = data['tasks'] ?? [];
      });
    } else {
      jsonDecode(response.body);
      throw Exception('Falha ao carregar as tarefas');
    }
  }

  Future<void> applyToTask(String taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('https://dolphin-app-4vryx.ondigitalocean.app/api/tasks/candidatos/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Candidatura realizada com sucesso!', style: TextStyle(color: Colors.green),),),
      );

      setState(() {
        tasks.removeWhere((task) => task['id'].toString() == taskId);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao se candidatar', style: TextStyle(color: Colors.red),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Meus Agendamentos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 300, // Largura total do botão
                height: 45, // Altura do botão
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: isProgressSelected
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7696FF),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isProgressSelected = true;
                              });
                            },
                            child: Center(
                              child: Text(
                                'Em progresso',
                                style: TextStyle(
                                  color: isProgressSelected
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isProgressSelected = false;
                              });
                            },
                            child: Center(
                              child: Text(
                                'Concluídas',
                                style: TextStyle(
                                  color: isProgressSelected
                                      ? Colors.grey
                                      : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  if (task['status'] != 'pendente') {
                    return const SizedBox.shrink();
                  }

                  return _buildAgendamentoCard(task);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgendamentoCard(dynamic task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task['titulo'] ?? 'Sem título',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.grey,
                size: 40,
              ),
              const SizedBox(width: 8),
              Text(
                task['responsavel'] ?? 'Responsável não definido',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 40,
              ),
              const SizedBox(width: 8),
              Text(
                task['local'] ?? 'Local não especificado',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                applyToTask(task['id'].toString());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7696FF),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Candidatar-se',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
