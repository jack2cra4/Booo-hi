import 'package:flutter/material.dart';
import '../../data/pronunciation_rules.dart';
import '../../models/lesson.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class PronunciationRulesScreen extends StatelessWidget {
  const PronunciationRulesScreen({super.key});

  static const List<(String, String, List<PronunciationRule>, Color)> _tabs =
      [
    ('Rule A', 'A', PronunciationData.aRules, Color(0xFFE53935)),
    ('Rule E', 'E', PronunciationData.eRules, Color(0xFF1E88E5)),
    ('Rule I', 'I', PronunciationData.iRules, Color(0xFF8E24AA)),
    ('Rule O', 'O', PronunciationData.oRules, Color(0xFFFB8C00)),
    ('Rule U', 'U', PronunciationData.uRules, Color(0xFF00897B)),
  ];

  static String _tabLabel(int i) {
    final t = _tabs[i];
    return '${t.$1} (${t.$3.length})';
  }

  @override
  Widget build(BuildContext context) {
    final total = PronunciationData.totalRules;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Column(
            children: [
              Text('🔤 A, E, I, O, U के 51 जादुई नियम'),
              Text(
                'Master Reading Rules',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF283593), Color(0xFF7B1FA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              for (var i = 0; i < _tabs.length; i++) Tab(text: _tabLabel(i)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final t in _tabs)
              _RulesTab(
                rules: t.$3,
                color: t.$4,
                vowel: t.$2,
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            TTSService().preWarm();
            TTSService().speakImmediate(
              'Welcome! There are total $total master rules. Tap any word to hear its sound.',
              langCode: 'en-US',
            );
          },
          backgroundColor: const Color(0xFF283593),
          icon: const Icon(Icons.record_voice_over, color: Colors.white),
          label: const Text(
            '🔊 सारे नियम सुनो',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _RulesTab extends StatelessWidget {
  final List<PronunciationRule> rules;
  final Color color;
  final String vowel;

  const _RulesTab({
    required this.rules,
    required this.color,
    required this.vowel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: rules.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _RuleCard(rule: rules[i], color: color, vowel: vowel),
    );
  }
}

class _RuleCard extends StatefulWidget {
  final PronunciationRule rule;
  final Color color;
  final String vowel;

  const _RuleCard({
    required this.rule,
    required this.color,
    required this.vowel,
  });

  @override
  State<_RuleCard> createState() => _RuleCardState();
}

class _RuleCardState extends State<_RuleCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final rule = widget.rule;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [widget.color, widget.color.withOpacity(0.7)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      rule.id,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rule.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${rule.pattern}  →  "${rule.sound}"',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: widget.color,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState:
                _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExamplesHeader(),
                  const SizedBox(height: 10),
                  for (final w in rule.words) ...[
                    _WordTile(word: w, color: widget.color),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.color.withOpacity(0.4)),
          ),
          child: Text(
            'उदाहरण 🔊 टैप करके सुनो',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'पीला = स्वर ध्वनि  •  नीला = Silent / प्रभाव',
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _WordTile extends StatelessWidget {
  final RuleWord word;
  final Color color;

  const _WordTile({required this.word, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1C2140),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _speak,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              SpeakerButton(
                text: word.word,
                language: 'en-US',
                size: 30,
                color: const Color(0xFFFFD600),
                onTap: _speak,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _HighlightedWord(word: word),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '= ${word.hindiPronunciation}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      word.hindiMeaning,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _speak() {
    TTSService().speakImmediate(word.word, langCode: 'en-US');
  }
}

class _HighlightedWord extends StatelessWidget {
  final RuleWord word;

  const _HighlightedWord({required this.word});

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    for (var i = 0; i < word.word.length; i++) {
      final ch = word.word[i];
      late final TextStyle style;
      if (word.vowelIndices.contains(i)) {
        style = const TextStyle(
          color: AppTheme.pronounceVowel,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        );
      } else if (word.silentIndices.contains(i)) {
        style = const TextStyle(
          color: AppTheme.pronounceSilent,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        );
      } else {
        style = const TextStyle(
          color: AppTheme.pronounceBase,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        );
      }
      spans.add(TextSpan(text: ch, style: style));
    }
    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.left,
    );
  }
}