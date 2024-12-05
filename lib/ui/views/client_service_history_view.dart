import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClientServiceHistoryView extends StatefulWidget {
  const ClientServiceHistoryView({super.key});

  @override
  ClientServiceHistoryViewState createState() =>
      ClientServiceHistoryViewState();
}

class ClientServiceHistoryViewState extends State<ClientServiceHistoryView> {
  String selectedSection = 'Pendentes';
  List<dynamic> pendingTasks = [];
  List<dynamic> ongoingTasks = [];
  List<dynamic> completedTasks = [];
  bool isLoading = true;

  Future<void> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Token não encontrado');
      return;
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
        Uri.parse('https://dolphin-app-4vryx.ondigitalocean.app/api/tasks'),
        headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> tasks = data['tasks'];

      setState(() {
        pendingTasks =
            tasks.where((task) => task['status'] == 'pendente').toList();
        ongoingTasks =
            tasks.where((task) => task['status'] == 'andamento').toList();
        completedTasks =
            tasks.where((task) => task['status'] == 'finalizado').toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> handleCandidateAction(int taskId, int candidateId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('Token não encontrado');
      return;
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse(
          'https://dolphin-app-4vryx.ondigitalocean.app/api/tasks/work/$taskId/$candidateId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profissional escolhido com sucesso',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      );

      // Atualiza a lista de tarefas após a escolha do profissional
      fetchTasks();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Falha ao escolher profissional',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  void showCandidatesModal(BuildContext context, int taskId, List<dynamic> candidatos) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: candidatos.length,
          itemBuilder: (context, index) {
            var candidato = candidatos[index];
            return ListTile(
              title: Text('Candidato ${candidato['id']}'),
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  handleCandidateAction(taskId, candidato['profissional_id']);
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
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
                'Minhas publicações',
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
                width: 350,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: selectedSection == 'Pendentes'
                          ? Alignment.centerLeft
                          : selectedSection == 'Em andamento'
                              ? Alignment.center
                              : Alignment.centerRight,
                      child: Container(
                        width: 116,
                        height: 45,
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
                                selectedSection = 'Pendentes';
                              });
                            },
                            child: Center(
                              child: Text(
                                'Pendentes',
                                style: TextStyle(
                                  color: selectedSection == 'Pendentes'
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14,
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
                                selectedSection = 'Em andamento';
                              });
                            },
                            child: Center(
                              child: Text(
                                'Em andamento',
                                style: TextStyle(
                                  color: selectedSection == 'Em andamento'
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14,
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
                                selectedSection = 'Concluídas';
                              });
                            },
                            child: Center(
                              child: Text(
                                'Concluídas',
                                style: TextStyle(
                                  color: selectedSection == 'Concluídas'
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: 14,
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
              child: Center(
                child: selectedSection == 'Pendentes'
                    ? isLoading
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: pendingTasks.length,
                            itemBuilder: (context, index) {
                              var task = pendingTasks[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(
                                    task['titulo'],
                                  ),
                                  subtitle: Text(
                                    task['descricao'],
                                  ),
                                  trailing: Text(
                                    task['status'],
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onTap: () {
                                    showCandidatesModal(context, task['id'], task['candidatos']);
                                  },
                                ),
                              );
                            },
                          )
                    : selectedSection == 'Em andamento'
                        ? isLoading
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                itemCount: ongoingTasks.length,
                                itemBuilder: (context, index) {
                                  var task = ongoingTasks[index];
                                  return Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text(
                                        task['titulo'],
                                      ),
                                      subtitle: Text(
                                        task['descricao'],
                                      ),
                                      trailing: Text(
                                        task['status'],
                                        style: const TextStyle(
                                          color: Color(0xFF7696FF),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                        : isLoading
                            ? const CircularProgressIndicator()
                            : ListView.builder(
                                itemCount: completedTasks.length,
                                itemBuilder: (context, index) {
                                  var task = completedTasks[index];
                                  return Card(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text(
                                        task['titulo'],
                                      ),
                                      subtitle: Text(
                                        task['descricao'],
                                      ),
                                      trailing: Text(
                                        task['status'],
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
