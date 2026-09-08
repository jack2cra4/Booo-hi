import 'package:flutter/material.dart';
import '../../data/english_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';

class EnglishWordsScreen extends StatefulWidget {
  const EnglishWordsScreen({super.key});

  @override
  State<EnglishWordsScreen> createState() => _EnglishWordsScreenState();
}

class _EnglishWordsScreenState extends State<EnglishWordsScreen> {
  int _selectedTab = 0;

  final _tabs = [
    (
      '2-Letter',
      <WordListSection>[
        WordListSection(
          title: 'Sight Words',
          subtitle: 'हाई-फ़्रीक्वेंसी शब्द',
          color: Colors.pink,
          words: EnglishData.twoLetterWords,
        ),
      ],
    ),
    (
      'CVC Words',
      <WordListSection>[
        WordListSection(
          title: '3-Letter CVC',
          subtitle: 'Consonant-Vowel-Consonant',
          color: const Color(0xFF00BCD4),
          words: EnglishData.threeLetterWords,
        ),
      ],
    ),
    (
      '4-Letter +',
      <WordListSection>[
        WordListSection(
          title: 'Word Families',
          subtitle: '4+ Letter Words',
          color: const Color(0xFF8BC34A),
          words: EnglishData.fourLetterWords,
        ),
      ],
    ),
    (
      'Blends',
      <WordListSection>[
        WordListSection(
          title: 'Blends: BL, CL, ST, SH, CH, TH',
          subtitle: 'ध्वनि मिश्रण',
          color: const Color(0xFFFF9800),
          words: [
            ...EnglishData.blends,
            ...EnglishData.blendWords,
          ],
        ),
        WordListSection(
          title: 'Complex Sounds',
          subtitle: 'Long Vowels & Silent Letters',
          color: const Color(0xFF9C27B0),
          words: EnglishData.complexPhonics,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Word Building'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppTheme.primary,
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final isSelected = i == _selectedTab;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedTab = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? Colors.white : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        _tabs[i].$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final section in _tabs[_selectedTab].$2) ...[
            Text(
              section.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              section.subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            for (final word in section.words)
              WordCard(
                word: word.english,
                subtitle: '${word.hindi} (${word.length} letters)',
                meaning: word.meaning,
                audioText: word.english,
                language: 'en-US',
                color: section.color,
              ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class WordListSection {
  final String title;
  final String subtitle;
  final Color color;
  final List<dynamic> words;

  const WordListSection({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.words,
  });
}