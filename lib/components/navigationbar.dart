import 'dart:io';

import 'package:flutter/material.dart';
import '../screens/homepage.dart';
import '../screens/Stocks.dart';
import '../screens/account.dart';
import '../screens/report.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: BottomAppBar(
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 60,
            color: Colors.black87,
            child: Row(
              children: [
                navItem(
                  Icons.home_outlined,
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                navItem(Icons.bar_chart, pageIndex == 1, onTap: () => onTap(1)),
                navItem(Icons.report, pageIndex == 2, onTap: () => onTap(2)),
                navItem(
                  Icons.account_circle,
                  pageIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: selected ? Color(0xEA1A6E) : Colors.white.withOpacity(0.4),
      ),
    ),
  );
}
