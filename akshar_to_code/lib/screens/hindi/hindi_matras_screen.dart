import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/learning_widgets.dart';
import '../../widgets/speaker_button.dart';

class HindiMatrasScreen extends StatefulWidget {
  const HindiMatrasScreen({super.key});

  @override
  State<HindiMatrasScreen> createState() => _HindiMatrasScreenState();
}

class _HindiMatrasScreenState extends State<HindiMatrasScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('मात्राएँ'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: AppTheme.primary,
            child: Row(
              children: [
                _tabButton('मात्रा', 0),
                _tabButton('बारहखड़ी', 1),
                _tabButton('संयुक्त अक्षर', 2),
              ],
            ),
          ),
        ),
      ),
      body: _selectedTab == 0
          ? _buildMatrasList()
          : _selectedTab == 1
              ? _buildBarakhadi()
              : _buildSamyukt(),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
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
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatrasList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: HindiData.matras.entries.map((entry) {
        final matra = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9800).withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9800).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF9800),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'चिह्न: ${matra['symbol']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        '${matra['example']} (${matra['meaning']})',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SpeakerButton(
                  text: matra['example'] ?? entry.key,
                  language: 'hi-IN',
                  size: 38,
                  color: const Color(0xFFFF9800),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBarakhadi() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: HindiData.barakhadiFull.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${entry.key} समूह',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: entry.value.map((char) {
                  return InkWell(
                    onTap: () {
                      TTSService().speakHindi(char);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        char,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSamyukt() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: HindiData.samyuktAkshar.map((word) {
        return WordCard(
          word: word.hindi,
          subtitle: word.english,
          meaning: word.meaning,
          audioText: word.hindi,
          language: 'hi-IN',
          color: Colors.deepPurple,
        );
      }).toList(),
    );
  }
}