import 'package:flutter/material.dart';
import '../../data/english_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class EnglishBilingualScreen extends StatelessWidget {
  const EnglishBilingualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilingual Bridge'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C27B0), AppTheme.secondary],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF9C27B0).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF9C27B0).withOpacity(0.3)),
            ),
            child: const Text(
              '💡 हर लाइन को दो बार सुनो - पहले English (बोलो), फिर हिंदी (समझो)!',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final item in EnglishData.bilingualSentences)
            _BilingualCard(
              english: item.english,
              hindi: item.hindi,
              note: item.meaning,
            ),
        ],
      ),
    );
  }
}

class _BilingualCard extends StatelessWidget {
  final String english;
  final String hindi;
  final String note;

  const _BilingualCard({
    required this.english,
    required this.hindi,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9C27B0).withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  '🇬🇧 English',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SpeakerButton(
                text: english,
                language: 'en-US',
                size: 34,
                color: const Color(0xFF9C27B0),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            english,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppTheme.primary.withOpacity(0.15),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: Text(
                  '🇮🇳 हिंदी',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SpeakerButton(
                text: hindi,
                language: 'hi-IN',
                size: 34,
                color: AppTheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            hindi,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.warning.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '📌 $note',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}