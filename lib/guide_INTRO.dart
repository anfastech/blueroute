import 'package:flutter/material.dart';
import 'guide_FRST.dart';
import 'TextToSpeech.dart';

class INTROpage extends StatelessWidget {
  final bool isVoiceEnabled;

  INTROpage({required this.isVoiceEnabled});

  @override
  Widget build(BuildContext context) {
    if (isVoiceEnabled) {
      TextToSpeech.speak("Quick tips, step 1, Check for breathing, step 2, Call for help immediately, step 3, Keep calm and assess the situation");
    }

    return Scaffold(
      backgroundColor: Color(0xFF1E2A47), // Dark blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Section
              Text(
                'Blueroute AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Intelligence Meets Road Safety',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),

              // Illustration
              Image.asset(
                'images/help.png', // Replace with your actual image asset
                height: 180,
              ),

              SizedBox(height: 20),
              

              // Quick Tips Section
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B5A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Tips:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. Check for breathing\n'
                      '2. Call for help immediately.\n'
                      '3. Keep calm and assess the situation.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Next Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C82F7), // Blue button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FRSTsteps(isVoiceEnabled: isVoiceEnabled)),
                  );
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),

              // Footer Text
              Text(
                'This app provides general guidance.',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
