import 'dart:async';
import 'package:flutter/foundation.dart';

class AudioFeedbackService {
  static bool _initialized = false;

  static Future<void> playCelebrationSound() async {
    _initialized = true;
    debugPrint('Playing celebration sound feedback');
  }

  static Future<void> playWrongSound() async {
    debugPrint('Playing wrong answer sound feedback');
  }

  static Future<void> playTapSound() async {
    debugPrint('Playing tap sound feedback');
  }
}