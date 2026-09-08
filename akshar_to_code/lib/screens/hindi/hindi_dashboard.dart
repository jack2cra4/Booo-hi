import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/module_card.dart';
import 'hindi_alphabet_screen.dart';
import 'hindi_words_screen.dart';
import 'hindi_matras_screen.dart';
import 'hindi_sentences_screen.dart';

class HindiDashboard extends StatelessWidget {
  const HindiDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('हिंदी सीखें'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.moduleColors[0], AppTheme.primary],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ModuleCard(
              title: 'वर्णमाला',
              subtitle: 'स्वर और व्यंजन सीखें',
              icon: Icons.abc,
              color: AppTheme.moduleColors[0],
              badge: 'अ से अः',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HindiAlphabetScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'शब्द निर्माण',
              subtitle: '2, 3, 4 अक्षर वाले शब्द',
              icon: Icons.feed_outlined,
              color: const Color(0xFF00BCD4),
              badge: 'शब्द',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HindiWordsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'मात्राएँ',
              subtitle: 'बारहखड़ी और मात्रा पहचान',
              icon: Icons.sign_language,
              color: const Color(0xFFFF9800),
              badge: 'मात्रा',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HindiMatrasScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'वाक्य निर्माण',
              subtitle: 'छोटे वाक्य से पैराग्राफ तक',
              icon: Icons.chat_outlined,
              color: Colors.green,
              badge: 'वाक्य',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HindiSentencesScreen(),
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