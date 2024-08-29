import 'package:flutter/material.dart';
import 'package:skisubapp/profile/ProfileScreen.dart';
// import 'package:skisubapp/WalletScreen.dart';
import 'package:skisubapp/dashboard.dart';
// import 'package:skisubapp/homescreen.dart';
import 'package:skisubapp/services.dart';
import 'package:skisubapp/wallets/WalletBalance.dart';
import 'package:skisubapp/widget/bottomnav.dart';

class HomeView extends StatefulWidget {const HomeView
({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
   int currentIndex = 0;
    @override
    void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // List of available screens
  final List<Widget> _screens = [
    DashboardScreen(),
    ServicesPage(),
    WalletScreen(),
    ProfilePage(),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 249, 249, 1),
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
          _pageController.jumpToPage(currentIndex);
        }),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) => setState(() {
            currentIndex = value;
          }),
          children: _screens
          // [
          //   const DashboardScreen(),
          //   Container(
          //     color: Colors.purple,
          //   ),
          // ],
        ),
      ),
    );
  }
 
}