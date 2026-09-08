import 'package:flutter/material.dart';
import '../../data/english_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';

class EnglishAlphabetScreen extends StatelessWidget {
  const EnglishAlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('English Alphabet'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Capital (A-Z)'),
              Tab(text: 'Small (a-z)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _LetterGrid(letters: EnglishData.capitalLetters),
            _LetterGrid(letters: EnglishData.smallLetters),
          ],
        ),
      ),
    );
  }
}

class _LetterGrid extends StatelessWidget {
  final List<dynamic> letters;

  const _LetterGrid({required this.letters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: letters.length,
      itemBuilder: (context, i) {
        final letter = letters[i];
        return LetterCard(
          character: letter.character,
          transliteration: 'A says "${letter.transliteration}"',
          word: letter.word,
          wordMeaning: letter.wordMeaning,
          audioText: letter.word,
          language: 'en-US',
          color: AppTheme.moduleColors[1],
        );
      },
    );
  }
}