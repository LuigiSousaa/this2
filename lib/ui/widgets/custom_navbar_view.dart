import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:relier/core/viewmodels/custom_navbar_viewmodel.dart';


class CustomNavbarView extends StatelessWidget {
  final List<Widget> pages;
  final List<GButton> navItems;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color tabBackgroundColor;

  const CustomNavbarView({
    super.key,
    required this.pages,
    required this.navItems,
    this.backgroundColor = const Color(0xFF292929),
    this.activeColor = const Color(0xFF7696FF),
    this.inactiveColor = Colors.grey,
    this.tabBackgroundColor = const Color(0xFF7696FF),
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CustomNavbarViewModel>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView(
        controller: viewModel.pageController,
        onPageChanged: viewModel.onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(37),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GNav(
              backgroundColor: const Color(0xFF1F1F1F),
              color: inactiveColor,
              activeColor: activeColor,
              tabBackgroundColor: tabBackgroundColor.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              gap: 8,
              selectedIndex: viewModel.selectedIndex,
              onTabChange: (index) => viewModel.onTabChange(index),
              tabs: navItems,
            ),
          ),
        ),
      ),
    );
  }
}