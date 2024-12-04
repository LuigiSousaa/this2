import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/client_home_viewmodel.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});

  @override
  ClientHomeViewState createState() => ClientHomeViewState();
}

class ClientHomeViewState extends State<ClientHomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientHomeViewModel>(context, listen: false).getName();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ClientHomeViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(34),
                        bottomRight: Radius.circular(34),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Olá, ${viewModel.name}!',
                          style: const TextStyle(
                            color: Color(0xFFCDCDCD),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            width: 330,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF292929),
                                hintText: 'Qual serviço você procura?',
                                hintStyle: const TextStyle(
                                  color: Color(0xFFCDCDCD),
                                  fontWeight: FontWeight.w300,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFFCDCDCD),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: viewModel.cardData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (viewModel.cardData[index]['label'] == 'Outro') {
                              viewModel.navigateToTaskPost(context);
                            } else if (viewModel.cardData[index]['label'] ==
                                'Construções\n& Obras') {
                              viewModel.navigateToSecondTaskPost(context,
                                  specialty: 'construcao_civil');
                            } else if (viewModel.cardData[index]['label'] ==
                                'Encanamento') {
                              viewModel.navigateToSecondTaskPost(context,
                                  specialty: 'encanamento');
                            } else if (viewModel.cardData[index]['label'] ==
                                'Jardinagem') {
                              viewModel.navigateToSecondTaskPost(context,
                                  specialty: 'jardinagem');
                            } else if (viewModel.cardData[index]['label'] ==
                                'Pinturas') {
                              viewModel.navigateToSecondTaskPost(context,
                                  specialty: 'pintura');
                            } else if (viewModel.cardData[index]['label'] ==
                                'Elétrica') {
                              viewModel.navigateToSecondTaskPost(context,
                                  specialty: 'eletrica');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F1F1F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    viewModel.cardData[index]['image'],
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 8.0),
                                  child: Text(
                                    viewModel.cardData[index]['label'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 380,
                      height: 175,
                      margin: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                                  child: Text(
                                    'Conheça nossos\nplanos feitos para você!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/client_home/enthusiastic-bro.png',
                                  width: 170,
                                  height: 115,
                                  fit: BoxFit.fitHeight,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF5A5AFF),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200),
                                      bottomLeft: Radius.circular(200),
                                      topRight: Radius.circular(27),
                                      bottomRight: Radius.circular(27),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  width: 107,
                                  height: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF7696FF),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200),
                                      bottomLeft: Radius.circular(200),
                                      topRight: Radius.circular(27),
                                      bottomRight: Radius.circular(27),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
