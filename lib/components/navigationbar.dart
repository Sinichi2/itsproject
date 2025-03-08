import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import '../screens/Stocks.dart';
import '../screens/account.dart';
import '../screens/report.dart';

// NavItem class remains the same
class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}

// SemiCircleClipper class remains the same
class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(size.height),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CustomNavBar extends StatefulWidget {
  final Function(int) onPageChanged;
  final int currentIndex;

  const CustomNavBar({
    Key? key,
    required this.onPageChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<NavItem> _navItems = [
    NavItem(icon: Icons.home, label: 'Home'),
    NavItem(icon: Icons.show_chart, label: 'Stocks'),
    NavItem(icon: Icons.add, label: ''), // Placeholder for center button
    NavItem(icon: Icons.bar_chart, label: 'Report'),
    NavItem(icon: Icons.person, label: 'Account'),
  ];

  final List<NavItem> _menuItems = [
    NavItem(icon: Icons.add_a_photo, label: ''),
    NavItem(icon: Icons.edit_document, label: ''),
    NavItem(icon: Icons.sync, label: ''),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Center button - toggle menu
      _toggleMenu();
    } else {
      // Navigate to the selected page
      widget.onPageChanged(index);

      // Close the menu if it's open
      if (_isMenuOpen) {
        setState(() {
          _isMenuOpen = false;
          _animationController.reverse();
        });
      }
    }
  }

  void _onMenuItemTapped(int index) {
    // Handle menu item taps here
    print('Menu item tapped: $index');
    // Close the menu after handling the tap
    setState(() {
      _isMenuOpen = false;
      _animationController.reverse();
    });
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = widget.currentIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFFEE0979) : Colors.grey,
            size: 30,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xFFEE0979) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () => _onMenuItemTapped(index),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: Color(0xFF9B51E0), size: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Semi-circular menu
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: 60,
                child: Transform.scale(
                  scale: _animation.value,
                  child: Opacity(
                    opacity: _animation.value,
                    child: Container(
                      width: 200,
                      height: 100,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Semi-circle background
                          ClipPath(
                            clipper: SemiCircleClipper(),
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF9B51E0).withOpacity(0.9),
                                    Color(0xFF9B51E0).withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Menu items
                          for (int i = 0; i < _menuItems.length; i++)
                            Positioned(
                              left: 40.0 + i * 60.0,
                              bottom: 35.0,
                              child: _buildMenuIcon(_menuItems[i].icon, i),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF121212),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              height: 75,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  // Skip the center item as we have a floating button for it
                  if (index == 2) {
                    return SizedBox(
                      width: 50,
                    ); // Empty space for the floating button
                  }

                  return _buildNavItem(
                    _navItems[index].icon,
                    _navItems[index].label,
                    index,
                  );
                }),
              ),
            ),
          ),

          // Floating action button - positioned above the navbar
          Positioned(
            bottom: 40,
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFEA1A6E), Color(0xFFEE0979)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFEA1A6E).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: AnimatedRotation(
                  turns: _isMenuOpen ? 0.125 : 0, // Rotate 45 degrees when open
                  duration: Duration(milliseconds: 300),
                  child: Icon(Icons.add, color: Colors.white, size: 36),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Main app with navigation
class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Define all pages
  final List<Widget> _pages = [
    Homepage(),
    Stockspage(),
    Reportspage(),
    Accountpage(),
  ];

  // Map navigation bar indices to page indices
  // The center button (index 2) is not mapped to any page
  int _navIndexToPageIndex(int navIndex) {
    if (navIndex < 2) {
      return navIndex; // Home (0) and Stocks (1) remain the same
    } else if (navIndex > 2) {
      return navIndex - 1; // Report (3 -> 2) and Account (4 -> 3)
    }
    return 0; // Default to home page for safety
  }

  // Map page indices to navigation bar indices
  int _pageIndexToNavIndex(int pageIndex) {
    if (pageIndex < 2) {
      return pageIndex; // Home (0) and Stocks (1) remain the same
    } else {
      return pageIndex + 1; // Report (2 -> 3) and Account (3 -> 4)
    }
  }

  void _onNavItemTapped(int navIndex) {
    // Set the current index for highlighting in the navigation bar
    setState(() {
      _currentIndex = navIndex;
    });

    // Don't navigate when the center button is pressed
    if (navIndex != 2) {
      // Convert nav index to page index and navigate
      int pageIndex = _navIndexToPageIndex(navIndex);
      _pageController.jumpToPage(pageIndex);
    }
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
        physics: NeverScrollableScrollPhysics(), // Disable swiping
        children: _pages,
        onPageChanged: (pageIndex) {
          // Update the navbar index when page changes programmatically
          setState(() {
            _currentIndex = _pageIndexToNavIndex(pageIndex);
          });
        },
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onPageChanged: _onNavItemTapped,
      ),
    );
  }
}
