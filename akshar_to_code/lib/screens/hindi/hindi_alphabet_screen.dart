import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';
import '../../widgets/speaker_button.dart';

class HindiAlphabetScreen extends StatefulWidget {
  const HindiAlphabetScreen({super.key});

  @override
  State<HindiAlphabetScreen> createState() => _HindiAlphabetScreenState();
}

class _HindiAlphabetScreenState extends State<HindiAlphabetScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('वर्णमाला (Alphabet)'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'स्वर (Vowels)'),
              Tab(text: 'व्यंजन (Consonants)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _LetterGrid(
              letters: HindiData.swar,
              color: Colors.pink,
            ),
            _LetterGrid(
              letters: HindiData.vyanjan,
              color: AppTheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterGrid extends StatelessWidget {
  final List<dynamic> letters;
  final Color color;

  const _LetterGrid({required this.letters, required this.color});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 140,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: letters.length,
      itemBuilder: (context, i) {
        final letter = letters[i];
        return InkWell(
          onTap: () =>
              _showDetail(context, letter, color),
          child: LetterCard(
            character: letter.character,
            transliteration: letter.transliteration,
            word: letter.word,
            wordMeaning: letter.wordMeaning,
            audioText: letter.character,
            language: 'hi-IN',
            color: color,
          ),
        );
      },
    );
  }

  void _showDetail(BuildContext context, dynamic letter, Color color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              letter.character,
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: color,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              letter.transliteration,
              style: const TextStyle(
                fontSize: 20,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${letter.word} • ${letter.wordMeaning}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SpeakerButton(
                        text: letter.character,
                        language: 'hi-IN',
                        size: 40,
                        color: color,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SpeakerButton(
              text: letter.character,
              language: 'hi-IN',
              size: 64,
              color: color,
            ),
            const SizedBox(height: 8),
            const Text(
              'सुनने के लिए दबाएँ',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}