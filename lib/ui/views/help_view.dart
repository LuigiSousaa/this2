import 'package:flutter/material.dart';
import 'package:relier/ui/views/help_easy_communication_view.dart';
import 'package:relier/ui/views/help_personalized_experience_view.dart';
import 'package:relier/ui/views/help_quality_and_trust_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/help_viewmodel.dart';



class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final controller = PageController();


  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<HelpViewModel>(context);


    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/common/icon.png',
          height: 45,
        ),
        actions: [
          TextButton(
            onPressed: () => viewModel.navigateToLogin(context),
            child: const Text(
              'Pular',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFF292929),
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: const [
              HelpQualityAndTrustView(),
              HelpPersonalizedExperienceView(),
              HelpEasyCommunicationView(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}