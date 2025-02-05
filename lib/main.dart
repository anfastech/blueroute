import 'package:flutter/material.dart';
import 'guide_INTRO.dart';
import 'TextToSpeech.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FirstAidScreen(),
      theme: ThemeData(
        primaryColor: const Color(0xFF1A2A52),
        cardColor: const Color(0xFF2C3E75),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF5B82FB),
        ),
      ),
    );
  }
}

class FirstAidScreen extends StatefulWidget {
  const FirstAidScreen({super.key});

  @override
  _FirstAidScreenState createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  int _clickCount = 0;
  static const int _requiredClicks = 5;
  bool isVoiceEnabled = false;

  void _makeEmergencyCall() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Emergency Call"),
          content: const Text("Initiating Emergency Call..."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showClickAlert(BuildContext context, int remainingClicks) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$remainingClicks more clicks needed"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _emergencyCallButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDA312C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () {
        setState(() {
          _clickCount++;
          if (_clickCount >= _requiredClicks) {
            _clickCount = 0;
            _makeEmergencyCall();
          } else {
            _showClickAlert(context, _requiredClicks - _clickCount);
          }
        });
      },
      child: const Text(
        "Call Emergency Services",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _emergencyButton(String text, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () {
        // Action for emergency button
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset('images/logo_blueroute.png', height: 100),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Start First Aid Guidance",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(Icons.info_outline,
                                color: Colors.white, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        "Voice Mode:",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  isVoiceEnabled ? "Enable" : "Disable",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Switch(
                            value: isVoiceEnabled,
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            thumbColor: WidgetStatePropertyAll<Color>(
                              Theme.of(context).cardColor,
                            ),
                            thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                              (Set<WidgetState> states) {
                                if (isVoiceEnabled) {
                                  return const Icon(Icons.volume_up,
                                      color: Colors.white);
                                } else {
                                  return const Icon(Icons.volume_off,
                                      color: Colors.grey);
                                }
                              },
                            ),
                            onChanged: (value) {
                              setState(() {
                                isVoiceEnabled = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A2A52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => INTROpage(isVoiceEnabled: isVoiceEnabled)),
                            );
                          },
                          child: const Text(
                            "Start",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Emergency Actions:",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 15),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4.0,
                  children: [
                    _emergencyCallButton(),
                    _emergencyButton("Manage Shock", const Color(0xFF5E17EB)),
                    _emergencyButton("Provide CPR", const Color(0xFF00BF63)),
                    _emergencyButton("Treat Bleeding", const Color(0xFFFF914D)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "This app provides general guidance.",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
