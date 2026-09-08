import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/module_card.dart';
import 'english_alphabet_screen.dart';
import 'english_words_screen.dart';
import 'english_bilingual_screen.dart';

class EnglishDashboard extends StatelessWidget {
  const EnglishDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Mastery'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.secondary, Color(0xFFFF8A65)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ModuleCard(
              title: 'Letter Basics',
              subtitle: 'Capital & Small Letters with Phonics',
              icon: Icons.abc,
              color: AppTheme.moduleColors[1],
              badge: 'A-Z',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EnglishAlphabetScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'Word Building',
              subtitle: '2-Letter to Complex Sounds',
              icon: Icons.wordpress,
              color: const Color(0xFF00BCD4),
              badge: 'Words',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EnglishWordsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'Bilingual Bridge',
              subtitle: 'English ↔ हिंदी line-by-line',
              icon: Icons.compare_arrows,
              color: const Color(0xFF9C27B0),
              badge: 'Dual',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EnglishBilingualScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}