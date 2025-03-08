import 'package:/flutter/material.dart';
import '../components/navigationbar.dart';

class Stockspage extends StatefulWidget {
  const Stockspage({Key? key});

  @override
  _StockpageState createState() => _StockpageState();
}

class _StockpageState extends State<Stockspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFFA59E9E), // 0%
                      Color(0xFFEA1A6E), // 50%
                      Color(0xFF9B51E0), // 80%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: const [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            //Main Content of the whole thing
          ],
        ),
      ),
    );
  }
}
