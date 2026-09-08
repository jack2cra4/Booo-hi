import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';

class HindiWordsScreen extends StatefulWidget {
  const HindiWordsScreen({super.key});

  @override
  State<HindiWordsScreen> createState() => _HindiWordsScreenState();
}

class _HindiWordsScreenState extends State<HindiWordsScreen> {
  int _selectedTab = 0;

  final _tabs = [
    ('2 अक्षर', HindiData.twoLetterWords),
    ('3 अक्षर', HindiData.threeLetterWords),
    ('4 अक्षर', HindiData.fourLetterWords),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('शब्द निर्माण'),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _tabs[_selectedTab].$2.length,
          itemBuilder: (context, i) {
            final word = _tabs[_selectedTab].$2[i];
            return WordCard(
              word: word.hindi,
              subtitle: word.english,
              meaning: word.meaning,
              audioText: word.hindi,
              language: 'hi-IN',
              color: AppTheme.moduleColors[1],
            );
          },
        ),
      ),
    );
  }
}