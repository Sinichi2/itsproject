import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'TransitionScreenThree.dart';

class TransitionScreenTwo extends StatefulWidget {
  const TransitionScreenTwo({Key? key}) : super(key: key);

  @override
  _TransitionScreenTwoState createState() => _TransitionScreenTwoState();
}

class _TransitionScreenTwoState extends State<TransitionScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Base color behind your gradient
        child: Stack(
          children: [
            // 1. Gradient overlay at 15% opacity
            Opacity(
              opacity: 0.15,
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

            // 2. Main content in the center (SVG + Text + Button)
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Wraps content vertically
                  children: [
                    // SVG graphic (adjust size as needed)
                    SizedBox(
                      width: 450,
                      height: 500,
                      child: SvgPicture.asset(
                        'assets/images/Transition_page_two.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 100),

                    // Text (fontSize = 14)
                    const Text(
                      "start small, invest big,\n and watch your future soar!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'HelveticaRounded',
                        fontSize: 14, // Smaller text
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 60),

                    // "Next" button
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
                          MaterialPageRoute(
                            builder: (_) => const TransitionScreenThree(),
                          ),
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
