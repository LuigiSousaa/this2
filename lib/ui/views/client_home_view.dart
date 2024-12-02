import 'package:flutter/material.dart';
import 'package:relier/ui/views/first_task_post_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHomeView extends StatefulWidget {
  const ClientHomeView({super.key});

  @override
  ClientHomeViewState createState() => ClientHomeViewState();
}

class ClientHomeViewState extends State<ClientHomeView> {
  String name = '';

  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() async {
    final prefs = await SharedPreferences.getInstance();
    final nameUser = prefs.getString('name');

    if(nameUser != null){
      setState(() {
        name = nameUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),

            _buildServiceGrid(),

            _buildPromoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
            'Olá $name!',
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
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFFCDCDCD)),
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
    );
  }

  Widget _buildServiceGrid() {
    final List<Map<String, dynamic>> cardData = [
      {
        'icon': Icons.construction,
        'color': Colors.blue[600],
        'label': 'Construções\n& Obras'
      },
      {
        'icon': Icons.plumbing,
        'color': Colors.blue[600],
        'label': 'Encanamento'
      },
      {'icon': Icons.eco, 'color': Colors.blue[600], 'label': 'Jardinagem'},
      {
        'icon': Icons.format_paint,
        'color': Colors.blue[600],
        'label': 'Pinturas'
      },
      {'icon': Icons.bolt, 'color': Colors.blue[600], 'label': 'Elétrica'},
      {'icon': Icons.layers, 'color': Colors.blue[600], 'label': 'Outros'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: cardData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (cardData[index]['label'] == 'Encanamento') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contextnew) => const FirstTaskPostView(),
                  ),
                );
              } else {

              }
            },
            child: buildServiceCard(
              icon: cardData[index]['icon'],
              color: cardData[index]['color'],
              label: cardData[index]['label'],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPromoCard() {
    return Center(
      child: Container(
        width: 355,
        height: 175,
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 28),
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
                  const Text(
                    'Conheça nossos\nplanos feitos para você!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Enthusiastic-bro(1).png',
                    width: 115,
                    height: 115,
                    fit: BoxFit.contain,
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
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
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
    );
  }

  Widget buildServiceCard({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Container(
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
            child: Icon(
              icon,
              color: color,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              label,
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
    );
  }
}
