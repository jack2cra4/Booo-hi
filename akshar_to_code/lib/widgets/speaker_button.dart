import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

class SpeakerButton extends StatelessWidget {
  final String text;
  final String? language;
  final double size;
  final Color? color;
  final VoidCallback? onTap;

  const SpeakerButton({
    super.key,
    required this.text,
    this.language,
    this.size = 32,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? AppTheme.primary;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        if (language == 'hi-IN') {
          TTSService().speakHindi(text);
        } else if (language == 'en-US') {
          TTSService().speakEnglish(text);
        } else {
          TTSService().speak(text, langCode: language);
        }
      },
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [btnColor, btnColor.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: btnColor.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.volume_up_rounded,
          color: Colors.white,
          size: size * 0.55,
        ),
      ),
    );
  }
}