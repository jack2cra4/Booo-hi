import 'package:flutter/material.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';

class EndLetterRulesScreen extends StatelessWidget {
  const EndLetterRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('English End-Letter Secret Rules'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD81B60), Color(0xFFFF6F00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _IntroCard(),
          SizedBox(height: 16),
          _RuleOneCard(),
          SizedBox(height: 16),
          _RuleTwoCard(),
          SizedBox(height: 16),
          _LegendCard(),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD81B60), Color(0xFFFF6F00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🚫 अब नहीं रटना स्पेलिंग!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'English शब्द कभी भी कुछ खास अक्षरों से खत्म नहीं होते। '
            'ये 2 गुप्त नियम अपने दिमाग में बिठाओ — फिर कोई भी word '
            'सही लिखोगे।',
            style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _ForbiddenEndingLetters {
  final String text;
  final List<int> redIndices;
  final List<int> yellowIndices;

  const _ForbiddenEndingLetters(
      this.text, this.redIndices, this.yellowIndices);
}

class _RuleOneCard extends StatelessWidget {
  const _RuleOneCard();

  static const _forbidden = [
    _ForbiddenEndingLetters('i', [0], []),
    _ForbiddenEndingLetters('v', [0], []),
    _ForbiddenEndingLetters('j', [0], []),
    _ForbiddenEndingLetters('u', [0], []),
    _ForbiddenEndingLetters('oa', [0, 1], []),
    _ForbiddenEndingLetters('ai', [0, 1], []),
  ];

  static const _words = [
    _EndWord('Save', 'सेव', 'बचाना', [1], [3], [2]),
    _EndWord('Leave', 'लीव', 'जाना / छोड़ना', [1, 2], [4], [3]),
    _EndWord('Give', 'गिव', 'देना', [1], [3], [2]),
    _EndWord('Live', 'लिव', 'जीना / रहना', [1], [3], [2]),
    _EndWord('Solve', 'सॉल्व', 'हल करना', [1], [4], [3]),
    _EndWord('Have', 'हैव', 'रखना / पास होना', [1], [3], [2]),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpandedRuleCard(
      badge: '1',
      color: const Color(0xFFD81B60),
      title: 'शब्द कभी नहीं खत्म होते इनसे',
      rule: '\"i, v, j, u, oa, ai\"',
      kidRule: 'जब भी शब्द \"v\" ध्वनि से खत्म हो, अंत में silent \"e\" जोड़ो।',
      header: Column(
        children: [
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final f in _forbidden)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.6, end: 1.0),
                    duration: const Duration(milliseconds: 900),
                    builder: (context, t, child) =>
                        Transform.scale(scale: t, child: child),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFFF3B30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.close_rounded,
                              color: Color(0xFFFF3B30), size: 16),
                          const SizedBox(width: 4),
                          _ColorWord(
                            text: f.text,
                            redIndices: f.redIndices,
                            yellowIndices: f.yellowIndices,
                            color: const Color(0xFFFF3B30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
      words: _words,
    );
  }
}

class _RuleTwoCard extends StatelessWidget {
  const _RuleTwoCard();

  static const _words = [
    _EndWord('Sky', 'स्काई', 'आसमान', [2], [], []),
    _EndWord('Dry', 'ड्राई', 'सूखा', [2], [], []),
    _EndWord('Spy', 'स्पाई', 'जासूस', [2], [], []),
    _EndWord('Why', 'व्हाई', 'क्यों', [2], [], []),
    _EndWord('Fly', 'फ्लाई', 'उड़ना', [2], [], []),
    _EndWord('Cry', 'क्राई', 'रोना', [2], [], []),
    _EndWord('Try', 'ट्राई', 'कोशिश', [2], [], []),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpandedRuleCard(
      badge: '2',
      color: const Color(0xFFFF6F00),
      title: 'आई/ई ध्वनि वाले अंत में लगता है \"y\"',
      rule: 'Sk[y] • Dr[y] • Fl[y]',
      kidRule: 'जो शब्द \"आई\" या \"ई\" की ध्वनि से खत्म होता है, '
          'उसके अंत में हमेशा \"y\" लिखते हैं।',
      header: const SizedBox.shrink(),
      words: _words,
    );
  }
}

class _LegendCard extends StatelessWidget {
  const _LegendCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF6F00).withOpacity(0.25)),
      ),
      child: const Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            _LegendDot(Color(0xFFFFD600)),
            SizedBox(width: 6),
            Text('स्वर ध्वनि', style: TextStyle(fontSize: 12)),
          ]),
          Row(mainAxisSize: MainAxisSize.min, children: [
            _LegendDot(Color(0xFF00E5FF)),
            SizedBox(width: 6),
            Text('Silent अक्षर', style: TextStyle(fontSize: 12)),
          ]),
          Row(mainAxisSize: MainAxisSize.min, children: [
            _LegendDot(Color(0xFFFF3B30)),
            SizedBox(width: 6),
            Text('नियम का निशान', style: TextStyle(fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF2D3142), width: 1.2),
      ),
    );
  }
}

class _EndWord {
  final String word;
  final String hindiUccharan;
  final String meaning;
  final List<int> yellowIndices;
  final List<int> cyanIndices;
  final List<int> redIndices;

  const _EndWord(this.word, this.hindiUccharan, this.meaning,
      this.yellowIndices, this.cyanIndices, this.redIndices);
}

class ExpandedRuleCard extends StatelessWidget {
  final String badge;
  final Color color;
  final String title;
  final String rule;
  final String kidRule;
  final Widget header;
  final List<_EndWord> words;

  const ExpandedRuleCard({
    required this.badge,
    required this.color,
    required this.title,
    required this.rule,
    required this.kidRule,
    required this.header,
    required this.words,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.75)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rule,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '👶 बच्चों वाली बात: $kidRule',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: color,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                for (final w in words) ...[
                  _RuleWordTile(word: w, color: color),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleWordTile extends StatelessWidget {
  final _EndWord word;
  final Color color;

  const _RuleWordTile({required this.word, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1C2140),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          TTSService().speakImmediate(word.word, langCode: 'en-IN');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: Row(
            children: [
              _ColorWord(
                text: word.word,
                yellowIndices: word.yellowIndices,
                cyanIndices: word.cyanIndices,
                redIndices: word.redIndices,
                color: color,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '= ${word.hindiUccharan}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      word.meaning,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: color.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.volume_up_rounded,
                color: Colors.white70,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorWord extends StatelessWidget {
  final String text;
  final List<int> yellowIndices;
  final List<int> cyanIndices;
  final List<int> redIndices;
  final Color color;

  const _ColorWord({
    required this.text,
    required this.yellowIndices,
    this.cyanIndices = const [],
    this.redIndices = const [],
    this.color = const Color(0xFFFF3B30),
  });

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      late final TextStyle style;
      if (yellowIndices.contains(i)) {
        style = const TextStyle(
          color: AppTheme.pronounceVowel,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        );
      } else if (cyanIndices.contains(i)) {
        style = const TextStyle(
          color: AppTheme.pronounceSilent,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        );
      } else if (redIndices.contains(i)) {
        style = const TextStyle(
          color: AppTheme.error,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        );
      } else {
        style = const TextStyle(
          color: AppTheme.pronounceBase,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        );
      }
      spans.add(TextSpan(text: ch, style: style));
    }
    return Text.rich(
      TextSpan(children: spans),
      textDirection: TextDirection.ltr,
    );
  }
}