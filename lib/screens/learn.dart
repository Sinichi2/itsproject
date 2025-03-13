import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../.env';

class Learnpage extends StatefulWidget {
  const Learnpage({Key? key});

  @override
  _LearnpageState createState() => _LearnpageState();
}

class _LearnpageState extends State<Learnpage> {
  //Gemini model

  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    safetySettings: [
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
