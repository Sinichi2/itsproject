import 'package:flutter/material.dart';
import 'dart:math' as math;

// Missing NavItem class
class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}

// Missing SemiCircleClipper class
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
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
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
      _toggleMenu();
    } else {
      setState(() {
        _selectedIndex = index;
        if (_isMenuOpen) {
          _isMenuOpen = false;
          _animationController.reverse();
        }
      });
    }
  }

  // Missing _buildNavItem method
  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFFEE0979) : Colors.grey,
            size: 24,
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

  // Missing _buildMenuIcon method
  Widget _buildMenuIcon(IconData icon) {
    return Container(
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
      child: Icon(icon, color: Color(0xFF9B51E0), size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          140, // Increased height to accommodate the menu and floating button
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
                              child: _buildMenuIcon(_menuItems[i].icon),
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
              height: 65,
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
            bottom: 40, // Position it above the navbar
            child: GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                height: 50,
                width: 50,
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
                  child: Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
