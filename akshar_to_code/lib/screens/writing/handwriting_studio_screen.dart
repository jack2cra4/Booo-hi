import 'package:flutter/material.dart';
import '../../data/stroke_patterns.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class _Stroke {
  final Color color;
  final double width;
  final List<Offset> pts;

  _Stroke(this.color, this.width, this.pts);
}

enum _TraceCategory { hindiSwar, hindiVyanjan, upper, lower, numbers }

const List<(String, _TraceCategory)> _traceCategories = [
  ('हिंदी स्वर', _TraceCategory.hindiSwar),
  ('हिंदी व्यंजन', _TraceCategory.hindiVyanjan),
  ('A-Z', _TraceCategory.upper),
  ('a-z', _TraceCategory.lower),
  ('1-100', _TraceCategory.numbers),
];

const _hindiSwar = ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'अः'];
const _hindiVyanjan = [
  'क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ',
  'ट', 'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न',
  'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श',
  'ष', 'स', 'ह', 'क्ष', 'त्र', 'ज्ञ',
];
const _upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _lower = 'abcdefghijklmnopqrstuvwxyz';

const List<(String, Color)> _penOptions = [
  ('नोटबुक नीला', Color(0xFF1E5AA8)),
  ('जेल हरा', Color(0xFF00A551)),
  ('काली स्याही', Color(0xFF212121)),
];

class HandwritingStudioScreen extends StatefulWidget {
  const HandwritingStudioScreen({super.key});

  @override
  State<HandwritingStudioScreen> createState() => _HandwritingStudioScreenState();
}

class _HandwritingStudioScreenState extends State<HandwritingStudioScreen>
    with TickerProviderStateMixin {
  late final TabController _tab;
  late final AnimationController _fade;
  final List<_Stroke> _strokes = [];
  bool _tipsOpen = false;
  Color _penColor = const Color(0xFF1E5AA8);
  bool _eraser = false;
  bool _showGuide = true;
  int _patternIndex = 0;
  _TraceCategory _category = _TraceCategory.hindiSwar;
  String _traceChar = 'अ';

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tab.dispose();
    _fade.dispose();
    super.dispose();
  }

  List<String> _charsFor(_TraceCategory c) {
    switch (c) {
      case _TraceCategory.hindiSwar:
        return _hindiSwar;
      case _TraceCategory.hindiVyanjan:
        return _hindiVyanjan;
      case _TraceCategory.upper:
        return _upper.split('');
      case _TraceCategory.lower:
        return _lower.split('');
      case _TraceCategory.numbers:
        return [
          for (var n = 1; n <= 100; n++) '$n',
        ];
    }
  }

  bool get _isNumber => _category == _TraceCategory.numbers;

  String get _ttsText => _traceChar;

  static const Map<_TraceCategory, String> _langForCat = {
    _TraceCategory.hindiSwar: 'hi-IN',
    _TraceCategory.hindiVyanjan: 'hi-IN',
    _TraceCategory.upper: 'en-IN',
    _TraceCategory.lower: 'en-IN',
    _TraceCategory.numbers: 'en-IN',
  };

  void _speakTrace() {
    TTSService().speakImmediate(_ttsText, langCode: _langForCat[_category]);
  }

  void _onPanStart(DragStartDetails d) {
    setState(() {
      _strokes.add(_Stroke(
        _eraser ? Colors.white : _penColor,
        _eraser ? 16 : 5,
        [d.localPosition],
      ));
    });
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (_strokes.isEmpty) return;
    setState(() {
      _strokes.last.pts.add(d.localPosition);
    });
  }

  void _undo() {
    if (_strokes.isEmpty) return;
    setState(_strokes.removeLast);
  }

  void _clear() {
    if (_strokes.isEmpty) return;
    setState(_strokes.clear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('🖍️ सुलेख स्टूडियो'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF00897B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTipsCard(),
          Container(
            color: const Color(0xFF2E7D32),
            child: TabBar(
              controller: _tab,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'स्ट्रोक्स अभ्यास'),
                Tab(text: 'अक्षर ट्रेसिंग'),
              ],
            ),
          ),
          _buildControlsRow(),
          const Divider(height: 1),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildStrokesTab(),
                _buildTracingTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    const tips = [
      '✏️ सही ग्रिप और कोण (Pencil Grip)',
      '📏 अक्षरों की शिरोरेखा (Top line) का सही खिंचाव',
      '↔️ अक्षरों के बीच समान दूरी (Letter Spacing)',
      '⚖️ अक्षरों का सही अनुपात (Proportion)',
      '🐢 स्लो और स्मूथ स्ट्रोक अभ्यास (Slow & Smooth)',
    ];
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => setState(() => _tipsOpen = !_tipsOpen),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb_rounded,
                        color: Color(0xFFF9A825), size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'सुंदर लिखावट के 5 नियम',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _tipsOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
                if (_tipsOpen) ...[
                  const SizedBox(height: 6),
                  for (final t in tips)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        t,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          for (final (label, color) in _penOptions)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Tooltip(
                message: label,
                child: GestureDetector(
                  onTap: () => setState(() {
                    _penColor = color;
                    _eraser = false;
                  }),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: !_eraser && _penColor == color
                            ? const Color(0xFF2D3142)
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const Spacer(),
          _IconControl(
            icon: Icons.cleaning_services_rounded,
            tooltip: 'इरेज़र',
            active: _eraser,
            onTap: () => setState(() => _eraser = !_eraser),
          ),
          const SizedBox(width: 6),
          _IconControl(
            icon: Icons.undo_rounded,
            tooltip: 'पिछला हटाएँ',
            active: false,
            onTap: _undo,
          ),
          const SizedBox(width: 6),
          _IconControl(
            icon: Icons.delete_sweep_rounded,
            tooltip: 'सब साफ़ करें',
            active: false,
            onTap: _clear,
          ),
          const SizedBox(width: 6),
          _IconControl(
            icon: _showGuide
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            tooltip: 'गाइड दिखाएँ/छिपाएँ',
            active: _showGuide,
            onTap: () => setState(() => _showGuide = !_showGuide),
          ),
        ],
      ),
    );
  }

  Widget _buildStrokesTab() {
    final pattern = StrokePatterns.all[_patternIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 92,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: StrokePatterns.all.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final p = StrokePatterns.all[i];
              final selected = i == _patternIndex;
              return InkWell(
                onTap: () => setState(() => _patternIndex = i),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 86,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF2E7D32)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFF2E7D32).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        p.sample,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: selected ? Colors.white : AppTheme.textPrimary,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.label,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? Colors.white70
                              : AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              const Icon(Icons.info_rounded,
                  size: 15, color: Color(0xFF2E7D32)),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  pattern.hint,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildCanvas(guides: pattern.guides)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildTracingTab() {
    final chars = _charsFor(_category);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            scrollDirection: Axis.horizontal,
            itemCount: _traceCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (context, i) {
              final (label, cat) = _traceCategories[i];
              final selected = cat == _category;
              return ChoiceChip(
                label: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : AppTheme.textPrimary,
                  ),
                ),
                selected: selected,
                selectedColor: const Color(0xFF00897B),
                backgroundColor: Colors.white,
                visualDensity: VisualDensity.compact,
                onSelected: (_) => setState(() {
                  _category = cat;
                  _traceChar = _charsFor(cat).first;
                }),
              );
            },
          ),
        ),
        SizedBox(
          height: 84,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final c in chars)
                  InkWell(
                    onTap: () => setState(() => _traceChar = c),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _traceChar == c
                            ? const Color(0xFF00897B)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _traceChar == c
                              ? const Color(0xFF00897B)
                              : const Color(0xFF00897B).withOpacity(0.25),
                        ),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: _isNumber ? 15 : 19,
                          fontWeight: FontWeight.bold,
                          color: _traceChar == c
                              ? Colors.white
                              : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Text(
                _isNumber ? '$_traceChar' : _traceChar,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF00897B),
                ),
              ),
              const Spacer(),
              Text(
                'ट्रेस करो और सुनो तो शानदार:',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00897B),
                ),
              ),
              const SizedBox(width: 8),
              SpeakerButton(text: _ttsText, size: 32, color: const Color(0xFF00897B), onTap: _speakTrace),
            ],
          ),
        ),
        Expanded(child: _buildCanvas(guides: const [])),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCanvas({required List<List<Offset>> guides}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: const Color(0xFF00897B).withOpacity(0.4)),
          ),
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: _TracePainter(
                    strokes: List.of(_strokes),
                    guides: guides,
                    guideText: _tab.index == 1 ? _traceChar : '' ,
                    guideTextOpacity:
                        0.28 + 0.22 * Curves.easeInOut.transform(_fade.value),
                    showGuide: _showGuide,
                  ),
                ),
              ),
            ),
          );
        );
      }
}

class _IconControl extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool active;
  final VoidCallback onTap;

  const _IconControl({
    required this.icon,
    required this.tooltip,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2E7D32) : AppTheme.textSecondary;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? const Color(0xFF2E7D32).withOpacity(0.14)
                : Colors.white,
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }
}

class _TracePainter extends CustomPainter {
  final List<_Stroke> strokes;
  final List<List<Offset>> guides;
  final String guideText;
  final double guideTextOpacity;
  final bool showGuide;

  _TracePainter({
    required this.strokes,
    required this.guides,
    required this.guideText,
    required this.guideTextOpacity,
    required this.showGuide,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

    final linePaint = Paint()
      ..color = const Color(0xFFC9D6F0)
      ..strokeWidth = 1;
    const rowH = 34.0;
    for (double y = rowH; y < size.height; y += rowH) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    final marginPaint = Paint()
      ..color = const Color(0xFFFFB3A0)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(44, 0), Offset(44, size.height), marginPaint);

    final m = size.width * 0.05;

    if (showGuide && guides.isNotEmpty) {
      final guidePaint = Paint()
        ..color = const Color(0xFF90A4AE)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      final startPaint = Paint()..color = const Color(0xFF2E7D32);
      var first = true;
      for (final pts in guides) {
        final scaled = [
          for (final p in pts)
            Offset(
              m + p.dx * (size.width - 2 * m),
              m + p.dy * (size.height - 2 * m),
            ),
        ];
        _drawDots(canvas, scaled, guidePaint);
        if (first && scaled.isNotEmpty) {
          canvas.drawCircle(scaled.first, 6, startPaint);
          first = false;
        }
      }
    }

    if (showGuide && guideText.isNotEmpty) {
      final isNum = guideText.length > 1 && int.tryParse(guideText) != null;
      final ts = TextStyle(
        color: const Color(0xFF00897B).withOpacity(guideTextOpacity),
        fontSize: isNum ? size.height * 0.4 : size.height * 0.62,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      );
      final tp = TextPainter(
        text: TextSpan(text: guideText, style: ts),
        textDirection: TextDirection.ltr,
      )..layout();
      final pos = Offset(
        (size.width - tp.width) / 2,
        (size.height - tp.height) / 2 - size.height * 0.02,
      );
      tp.paint(canvas, pos);
      canvas.drawCircle(
        Offset(pos.dx + tp.width - 6, pos.dy + tp.height - 4),
        6,
        Paint()..color = const Color(0xFF2E7D32),
      );
    }

    for (final s in strokes) {
      if (s.pts.isEmpty) continue;
      if (s.pts.length == 1) {
        canvas.drawCircle(
          s.pts.first,
          s.width / 2,
          Paint()..color = s.color,
        );
        continue;
      }
      final paint = Paint()
        ..color = s.color
        ..strokeWidth = s.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;
      final path = Path()
        ..moveTo(s.pts.first.dx, s.pts.first.dy);
      for (final p in s.pts.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  void _drawDots(Canvas canvas, List<Offset> pts, Paint paint) {
    if (pts.isEmpty) return;
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    const step = 9.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d <= metric.length) {
        final t = metric.getTangentForOffset(d);
        if (t != null) {
          canvas.drawCircle(t.position, 2.4, paint);
        }
        d += step;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter oldDelegate) => true;
}