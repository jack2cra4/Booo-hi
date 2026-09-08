import 'package:flutter/material.dart';
import '../../data/math_data.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  int _selectedTable = 2;
  double _speed = 0.5;
  bool _useHindi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('पहाड़ा ${_selectedTable}'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF9800), Color(0xFFFF5722)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTablePicker(),
          _buildControls(),
          Expanded(
            child: _buildTableList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTablePicker() {
    return Container(
      height: 64,
      color: const Color(0xFFFF9800).withOpacity(0.08),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: MathData.tables.length,
        itemBuilder: (context, i) {
          final table = MathData.tables[i];
          final isSelected = table == _selectedTable;
          return GestureDetector(
            onTap: () => setState(() => _selectedTable = table),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 48,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF9800) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.transparent : const Color(0xFFFF9800),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '$table',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFFFF9800),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '🔊 गति (Speed):',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Expanded(
                child: Slider(
                  value: _speed,
                  min: 0.3,
                  max: 0.9,
                  divisions: 6,
                  label: '${_speed.toStringAsFixed(1)}x',
                  onChanged: (v) => setState(() => _speed = v),
                ),
              ),
              Text(
                '${_speed.toStringAsFixed(1)}x',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('English'),
                      icon: Icon(Icons.language),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('हिंदी'),
                      icon: Icon(Icons.translate),
                    ),
                  ],
                  selected: {_useHindi},
                  onSelectionChanged: (val) =>
                      setState(() => _useHindi = val.first),
                ),
              ),
              const SizedBox(width: 12),
              SpeakerButton(
                text: _tableText(1),
                language: _useHindi ? 'hi-IN' : 'en-US',
                size: 48,
                color: const Color(0xFFFF9800),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _tableText(int n) {
    final result = _selectedTable * n;
    if (_useHindi) {
      return '$_selectedTable ${_hindiNumber(n)} $result';
    }
    return '$_selectedTable ${_englishSuffix(n)} $result';
  }

  String _englishSuffix(int n) {
    switch (n) {
      case 1: return "One's";
      case 2: return "Two's";
      case 3: return "Three's";
      case 4: return "Four's";
      case 5: return "Five's";
      case 6: return "Six's";
      case 7: return "Seven's";
      case 8: return "Eight's";
      case 9: return "Nine's";
      case 10: return "Ten's";
      default: return '$n';
    }
  }

  String _hindiNumber(int n) {
    const names = [
      'एक', 'दो', 'तीन', 'चार', 'पाँच', 'छह', 'सात', 'आठ', 'नौ', 'दस',
    ];
    return names[n - 1];
  }

  Widget _buildTableList() {
    final entries = MathData.generateTable(_selectedTable);
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final entry = entries[i];
        return InkWell(
          onTap: () {
            final text = _useHindi ? entry.hindiText : entry.text;
            TTSService().speak(text, langCode: _useHindi ? 'hi-IN' : 'en-US');
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFF9800).withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _useHindi ? entry.hindiText : entry.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                SpeakerButton(
                  text: _useHindi ? entry.hindiText : entry.text,
                  language: _useHindi ? 'hi-IN' : 'en-US',
                  size: 30,
                  color: const Color(0xFFFF9800),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}