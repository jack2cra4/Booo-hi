import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';
import '../../widgets/speaker_button.dart';

class HindiSentencesScreen extends StatefulWidget {
  const HindiSentencesScreen({super.key});

  @override
  State<HindiSentencesScreen> createState() => _HindiSentencesScreenState();
}

class _HindiSentencesScreenState extends State<HindiSentencesScreen> {
  int _level = 0;

  final List<({String title, IconData icon, List<String> sentences})> _levels = [
    (
      title: 'छोटे वाक्य',
      icon: Icons.looks_one,
      sentences: HindiData.shortSentences,
    ),
    (
      title: 'मध्यम वाक्य',
      icon: Icons.looks_two,
      sentences: HindiData.mediumSentences,
    ),
    (
      title: 'बड़े पैराग्राफ',
      icon: Icons.looks_3,
      sentences: HindiData.paragraphSentences,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final level = _levels[_level];
    return Scaffold(
      appBar: AppBar(
        title: const Text('वाक्य निर्माण'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppTheme.primary,
            child: Row(
              children: List.generate(_levels.length, (i) {
                final isSelected = i == _level;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _level = i),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _levels[i].icon,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _levels[i].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: const Text(
              '💡 वाक्य को ज़ोर से पढ़ो! हर एक शब्द पर स्पीकर दबाओ और सुनो।',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...level.sentences.map(
            (sentence) => SentenceCard(
              sentence: sentence,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class SentenceCard extends StatelessWidget {
  final String sentence;
  final Color color;

  const SentenceCard({
    super.key,
    required this.sentence,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final words = sentence.split(' ');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: words.map((word) {
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SpeakerButton(
                text: sentence,
                language: 'hi-IN',
                size: 34,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}