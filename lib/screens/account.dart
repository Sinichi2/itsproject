import 'package:flutter/material.dart';
import '../components/navigationbar.dart';

class Accountpage extends StatefulWidget {
  const Accountpage({Key? key});

  @override
  _AccountpageState createState() => _AccountpageState();
}

class _AccountpageState extends State<Accountpage> {
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
                      Color(0xA59E9E), // 0%
                      Color(0xEA1A6E), // 50%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),

            //Main Content of the whole thing
            SafeArea(child: Column(children:[
                  
                ]
              )),
          ],
        ),
      ),
    );
  }
}
