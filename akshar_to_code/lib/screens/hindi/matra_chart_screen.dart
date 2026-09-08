import 'package:flutter/material.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class MatraChartScreen extends StatelessWidget {
  const MatraChartScreen({super.key});

  static const List<_Matra> rows = [
    _Matra('अ', 'a', null, 'क', 'कमल', 'कमल — Lotus'),
    _Matra('आ', 'aa', 'ा', 'का', 'काम', 'काम — Work'),
    _Matra('इ', 'i', 'ि', 'कि', 'किताब', 'किताब — Book'),
    _Matra('ई', 'ee', 'ी', 'की', 'कीमत', 'कीमत — Price'),
    _Matra('उ', 'u', 'ु', 'कु', 'कुर्सी', 'कुर्सी — Chair'),
    _Matra('ऊ', 'oo', 'ू', 'कू', 'कूदना', 'कूदना — To Jump'),
    _Matra('ऋ', 'ri', 'ृ', 'कृ', 'कृपा', 'कृपा — Kindness'),
    _Matra('ए', 'e', 'े', 'के', 'केला', 'केला — Banana'),
    _Matra('ऐ', 'ai', 'ै', 'कै', 'कैलेंडर', 'कैलेंडर — Calendar'),
    _Matra('ओ', 'o', 'ो', 'को', 'कोयल', 'कोयल — Cuckoo Bird'),
    _Matra('औ', 'au', 'ौ', 'कौ', 'कौआ', 'कौआ — Crow'),
    _Matra('अं', 'an / am', 'ं', 'कं', 'कंघा', 'कंघा — Comb'),
    _Matra('अः', 'ah', 'ः', 'कः', 'दुःख', 'दुःख — Sorrow'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('मात्रा व अक्षर मेल चार्ट'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3949AB), Color(0xFF00ACC1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroCard(),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rows.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, i) => _MatraCell(matra: rows[i]),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3949AB), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.spellcheck, color: Colors.white),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'स्वर + व्यंजन = नया अक्षर',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'मात्रा = स्वर को अक्षर से जोड़ने की शक्ति। '
            'कल्पना करो: क + े = के। '
            'हर सेल पर टैप करो और सुनो!',
            style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _Matra {
  final String swar;
  final String phonics;
  final String? matra;
  final String joined;
  final String example;
  final String meaning;

  const _Matra(this.swar, this.phonics, this.matra, this.joined,
      this.example, this.meaning);
}

class _MatraCell extends StatelessWidget {
  final _Matra matra;

  const _MatraCell({required this.matra});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3949AB).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3949AB).withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _speak,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    matra.swar,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2858),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE082),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      matra.phonics,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D6E00),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SpeakerButton(
                    text: '${matra.swar}, ${matra.example}',
                    size: 30,
                    color: const Color(0xFF1E88E5),
                    onTap: _speak,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F4FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    matra.matra == null ? 'कोई मात्रा नहीं' : matra.matra!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00ACC1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'क + ${matra.matra ?? matra.swar} = ${matra.joined}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                matra.example,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                matra.meaning,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _speak() {
    TTSService().speakImmediate(
      '${matra.swar}, क ${matra.joined}, ${matra.example}',
      langCode: 'hi-IN',
    );
  }
}