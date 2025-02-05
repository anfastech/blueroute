import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static final FlutterTts _tts = FlutterTts();
  static bool _isInitialized = false;

  static Future<void> _initialize() async {
    if (!_isInitialized) {
      await _tts.awaitSpeakCompletion(true);
      _isInitialized = true;
    }
  }

  static Future<void> speak(String text) async {
    await _initialize();
    await _tts.stop(); // Stop any previous speech
    await _tts.setVolume(0.6);
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.3);
    await _tts.speak(text);
  }

  static Future<void> stop() async => await _tts.stop();
}