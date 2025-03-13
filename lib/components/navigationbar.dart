import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import '../screens/Stocks.dart';
import '../screens/account.dart';
import '../screens/report.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // Define all pages
  final List<Widget> _pages = [
    Homepage(), // Index 0: Homepage (not swipeable)
    Stockspage(), // Index 1: Stocks
    Accountpage(), // Index 2: Account
    Reportspage(), // Index 3: Report
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      _pageController.jumpToPage(0);
    } else if (index == 1) {
      _pageController.jumpToPage(1);
    } else if (index == 2) {
      _pageController.jumpToPage(2);
    } else if (index == 3) {
      _pageController.jumpToPage(3);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(), // Enable swiping
        children: _pages,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: const Color(0xFFEE0979),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Report'),
        ],
      ),
    );
  }
}
