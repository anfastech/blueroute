import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Page"),
        backgroundColor: const Color(0xFF1A2A52), // Matches primary color
      ),
      body: const Center(
        child: Text(
          "Welcome to the anfas page!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
