import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import 'speaker_button.dart';

class LetterCard extends StatelessWidget {
  final String character;
  final String transliteration;
  final String? word;
  final String? wordMeaning;
  final String? audioText;
  final String? language;
  final VoidCallback? onTap;
  final Color? color;

  const LetterCard({
    super.key,
    required this.character,
    required this.transliteration,
    this.word,
    this.wordMeaning,
    this.audioText,
    this.language,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppTheme.primary;
    return GestureDetector(
      onTap: onTap ??
          () {
            if (audioText != null) {
              TTSService().speak(audioText!, langCode: language);
            }
          },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cardColor.withOpacity(0.15), cardColor.withOpacity(0.05)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cardColor.withOpacity(0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              character,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: cardColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              transliteration,
              style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
            ),
            if (word != null && wordMeaning != null) ...[
              const SizedBox(height: 8),
              Text(
                word!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: cardColor),
              ),
              Text(
                wordMeaning!,
                style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final String word;
  final String? meaning;
  final String? subtitle;
  final String? audioText;
  final String? language;
  final Color? color;

  const WordCard({
    super.key,
    required this.word,
    this.meaning,
    this.subtitle,
    this.audioText,
    this.language,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppTheme.secondary;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cardColor, cardColor.withOpacity(0.3)],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                      if (meaning != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          meaning!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SpeakerButton(
                  text: audioText ?? word,
                  language: language,
                  size: 40,
                  color: cardColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}