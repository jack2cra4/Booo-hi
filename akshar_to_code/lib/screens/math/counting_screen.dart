import 'package:flutter/material.dart';
import '../../data/math_data.dart';
import '../../models/lesson.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class CountingScreen extends StatelessWidget {
  const CountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final numbers = MathData.generateCounting();

    return Scaffold(
      appBar: AppBar(
        title: const Text('गिनती 1-100'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43E97B), Color(0xFF00BCD4)],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: numbers.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF43E97B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF43E97B).withOpacity(0.4),
                ),
              ),
              child: const Text(
                '💡 सुनो और दोहराओ! English शब्द और हिंदी नाम दोनों याद करो।',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            );
          }
          final num = numbers[i - 1];
          return _NumberTile(item: num);
        },
      ),
    );
  }
}

class _NumberTile extends StatelessWidget {
  final CountingItem item;

  const _NumberTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43E97B).withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF43E97B).withOpacity(0.7),
                  const Color(0xFF00BCD4).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${item.number}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.english,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  item.hindi,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SpeakerButton(
            text: '${item.english}, ${item.hindi}',
            language: 'en-US',
            size: 32,
            color: const Color(0xFF43E97B),
          ),
        ],
      ),
    );
  }
}