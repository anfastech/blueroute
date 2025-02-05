import 'dart:async';
import 'package:flutter/material.dart';

class CPRsteps extends StatefulWidget {
  final bool isVoiceEnabled;

  CPRsteps({required this.isVoiceEnabled});

  @override
  _CPRstepsState createState() => _CPRstepsState();
}

class _CPRstepsState extends State<CPRsteps> {
  int currentStep = 0;
  int timeLeft = 40; // 1 minute timer
  Timer? timer;

final List<Map<String, String>> steps = [
  {
    'title': 'Step 01 (Check the Scene)',
    'image': 'images/CPR/1.png',
    'detail': 'Before starting CPR, ensure the scene is safe for both you and the victim. Look for hazards like traffic, fire, or electricity.',
  },
  {
    'title': 'Step 02 (Check for Responsiveness)',
    'image': 'images/CPR/2.png',
    'detail': 'Tap the person gently and shout, "Are you okay?" If there’s no response, proceed with CPR. If they’re breathing, place them in the recovery position and wait for help.',
  },
  {
    'title': 'Step 03 (Call for Help)',
    'image': 'images/CPR/3.png',
    'detail': 'If the person is unresponsive, immediately call for emergency services. If possible, ask someone else to call while you begin CPR.',
  },
  {
    'title': 'Step 04 (Check for Breathing)',
    'image': 'images/CPR/4.png',
    'detail': 'Look for chest movements or listen for breathing sounds. Feel for airflow near their mouth and nose. If there’s no breathing, begin chest compressions.',
  },
  {
    'title': 'Step 05 (Start Chest Compressions)',
    'image': 'images/CPR/5.png',
    'detail': 'Place your hands in the center of the chest and push hard and fast. Aim for 100-120 compressions per minute, allowing full chest recoil after each compression.',
  },
  {
    'title': 'Step 06 (Give Rescue Breaths)',
    'image': 'images/CPR/6.png',
    'detail': 'After 30 chest compressions, give 2 rescue breaths. Ensure the person’s airway is open by tilting their head back, then breathe into their mouth until the chest rises.',
  },
];



  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    setState(() => timeLeft = 40);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        nextStep();
      }
    });
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
      startTimer();
    } else {
      timer?.cancel();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      startTimer();
    }
  }

  void resetTimer() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2A47),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                'First Aid Guidance',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                steps[currentStep]['title']!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF2E3B5A),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    if (currentStep == 6)
                      Column(
                        children: [
                          Text(
                            steps[currentStep]['detail']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Yes button
                                  nextStep();
                                },
                                child: Text('Yes'),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle No button
                                  nextStep();
                                },
                                child: Text('No'),
                              ),
                            ],
                          ),
                        ],
                      )
                    else
                      Image.asset(
                        steps[currentStep]['image']!,
                        height: 180,
                      ),
                    SizedBox(height: 10),
                    if (currentStep != 6)
                      Text(
                        steps[currentStep]['detail']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: previousStep,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.replay, color: Colors.white),
                    onPressed: resetTimer,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: nextStep,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Next Step In: ${timeLeft.toString().padLeft(2, '0')} Sec',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
