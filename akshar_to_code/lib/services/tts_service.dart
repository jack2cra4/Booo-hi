import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';

class TTSService {
  static final TTSService _instance = TTSService._();
  factory TTSService() => _instance;
  TTSService._();

  final FlutterTts _tts = FlutterTts();
  String _currentLanguage = 'hi-IN';
  double _speechRate = 0.5;
  bool _isInitialized = false;

  String get currentLanguage => _currentLanguage;
  double get speechRate => _speechRate;

  Future<void> init() async {
    if (_isInitialized) return;
    await _tts.setLanguage(_currentLanguage);
    await _tts.setSpeechRate(_speechRate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _isInitialized = true;
  }

  Future<void> preWarm({String langCode = 'en-US'}) async {
    try {
      await _tts.stop();
      await _tts.setLanguage(langCode);
      await _tts.setSpeechRate(0.52);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
      try {
        await _tts.setQueueMode(0);
      } catch (_) {}
      _isInitialized = true;
    } catch (e) {
      debugPrint('TTS preWarm error: $e');
    }
  }

  Future<void> speakImmediate(
    String text, {
    String? langCode,
  }) async {
    if (text.isEmpty) return;
    try {
      await _tts.stop();
      if (langCode != null) {
        await _tts.setLanguage(langCode);
      }
      await _tts.setSpeechRate(0.52);
      await _tts.setPitch(1.0);
      try {
        await _tts.setQueueMode(0);
      } catch (_) {}
      await _tts.speak(text);
      if (langCode != null) {
        await _tts.setLanguage(_currentLanguage);
      }
    } catch (e) {
      debugPrint('TTS speakImmediate error: $e');
    }
  }

  Future<void> setLanguage(String langCode) async {
    _currentLanguage = langCode;
    await _tts.setLanguage(langCode);
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    await _tts.setSpeechRate(rate);
  }

  Future<void> speak(String text, {String? langCode}) async {
    if (text.isEmpty) return;
    try {
      if (langCode != null) {
        await _tts.setLanguage(langCode);
      }
      await _tts.speak(text);
      if (langCode != null) {
        await _tts.setLanguage(_currentLanguage);
      }
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }

  Future<void> speakHindi(String text) async {
    await speak(text, langCode: 'hi-IN');
  }

  Future<void> speakEnglish(String text) async {
    await speak(text, langCode: 'en-US');
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> pause() async {
    await _tts.pause();
  }

  void dispose() {
    _tts.stop();
  }
}
