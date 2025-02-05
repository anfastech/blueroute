import 'dart:async';
import 'package:flutter/material.dart';
import 'guide_CPR.dart';
import 'main.dart';
import 'TextToSpeech.dart';

class FRSTsteps extends StatefulWidget {
  final bool isVoiceEnabled;

  FRSTsteps({required this.isVoiceEnabled});

  @override
  _FRSTstepsState createState() => _FRSTstepsState();
}

class _FRSTstepsState extends State<FRSTsteps> {
  int currentStep = 0;
  int timeLeft = 40; // 1 minute timer
  Timer? timer;

  final List<Map<String, String>> steps = [
    {
      'title': 'Step 01 (Triaging)',
      'image': 'images/FRST/1.png',
      'detail':
          'Assess the surroundings for any potential danger. Ensure your safety before approaching the person in need. If the scene is unsafe, call for professional help immediately.',
    },
    {
      'title': 'Step 02 (Check Response)',
      'image': 'images/FRST/2.png',
      'detail':
          'Gently tap the person on the shoulder and ask loudly, "Are you okay?" If there is no response, proceed to the next step.',
    },
    {
      'title': 'Step 03 (Call for Help)',
      'image': 'images/FRST/3.png',
      'detail':
          'If the person is unresponsive, immediately call emergency services or ask someone nearby to do so. Provide clear information about the situation and location.',
    },
    {
      'title': 'Step 04 (Check Breathing)',
      'image': 'images/FRST/4.png',
      'detail':
          'Look for chest movements, listen for breathing sounds, and feel for airflow near the nose and mouth. Take at least 10 seconds to assess breathing.',
    },
    {
      'title': 'Step 05 (Start CPR)',
      'image': 'images/FRST/5.png',
      'detail':
          'If the person is not breathing, start CPR immediately. Place your hands in the center of the chest and push hard and fast at a rate of 100-120 compressions per minute.',
    },
    {
      'title': 'Step 06 (Use AED)',
      'image': 'images/FRST/6.png',
      'detail':
          'If an Automated External Defibrillator (AED) is available, turn it on and follow the voice instructions. Ensure no one is touching the person while delivering a shock.',
    },
    {
      'title': 'Step 07 (Are They Breathing?)',
      'image': 'images/FRST/7.png',
      'detail':
          'Check if the person is breathing again. If yes, place them in a recovery position and monitor their condition. If no, continue CPR until professional help arrives.',
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Manage bleeding'),
                                        content: Text(
                                            'Follow the steps to manage bleeding.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()),
                                              );
                                            },
                                            child: Text('Home'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text('Yes'),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle No button
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CPRsteps(
                                            isVoiceEnabled: widget.isVoiceEnabled)),
                                  );
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
