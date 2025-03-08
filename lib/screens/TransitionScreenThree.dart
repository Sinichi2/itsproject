import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'loginScreen.dart';

class TransitionScreenThree extends StatefulWidget {
  const TransitionScreenThree({Key? key}) : super(key: key);

  @override
  _TransitionScreenThreeState createState() => _TransitionScreenThreeState();
}

class _TransitionScreenThreeState extends State<TransitionScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // 1. Gradient overlay at 15% opacity
            Opacity(
              opacity: 0.15, // 15% visibility
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA59E9E), // 0%
                      Color(0xFFEA1A6E), // 50%
                      Color(0xFF9B51E0), // 80%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // 2. Main content
            SafeArea(
              child: Column(
                children: [
                  const Spacer(),

                  // 2a. SVG graphic (use forward slash)
                  SvgPicture.asset(
                    'assets/images/Transition_page_three.svg',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 24),

                  // 2b. Heading text
                  const Text(
                    "Let's get started",
                    style: TextStyle(
                      fontFamily: 'HelveticaRounded',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2c. Subtitle text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "It's never a better time to start than now! "
                      "Think about how you will be managing your finances — "
                      "it's an investment in your future.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Archivo',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // 2d. Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8D5AD4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'HelveticaRounded',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text("Let's start"),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
