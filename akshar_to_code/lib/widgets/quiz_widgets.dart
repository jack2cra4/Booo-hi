import 'dart:math';
import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import 'speaker_button.dart';

class QuizCard extends StatefulWidget {
  final List<String> options;
  final String correctAnswer;
  final String? audioText;
  final String language;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const QuizCard({
    super.key,
    required this.options,
    required this.correctAnswer,
    this.audioText,
    this.language = 'en-US',
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int? _selectedIndex;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.audioText != null) {
        TTSService().speak(widget.audioText!, langCode: widget.language);
      }
    });
  }

  void _answer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
    });
    if (widget.options[index] == widget.correctAnswer) {
      widget.onCorrect();
    } else {
      widget.onWrong();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (widget.audioText != null)
              SpeakerButton(text: widget.audioText!, language: widget.language, size: 56)
            else
              Text(
                'सही उत्तर चुनें / Choose the correct answer',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(
                widget.options.length,
                (i) {
                  final isCorrect = _answered && widget.options[i] == widget.correctAnswer;
                  final isWrong = _selectedIndex == i && !isCorrect;
                  return GestureDetector(
                    onTap: () => _answer(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? AppTheme.success
                            : isWrong
                                ? AppTheme.error
                                : AppTheme.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCorrect
                              ? AppTheme.success
                              : isWrong
                                  ? AppTheme.error
                                  : AppTheme.primary.withOpacity(0.4),
                          width: 2,
                        ),
                        boxShadow: isCorrect || isWrong
                            ? null
                            : [
                                BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                      ),
                      child: Text(
                        widget.options[i],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isCorrect || isWrong
                              ? Colors.white
                              : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListeningQuiz extends StatefulWidget {
  final List<String> options;
  final String correctAnswer;
  final String audioText;
  final String language;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ListeningQuiz({
    super.key,
    required this.options,
    required this.correctAnswer,
    required this.audioText,
    required this.language,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  State<ListeningQuiz> createState() => _ListeningQuizState();
}

class _ListeningQuizState extends State<ListeningQuiz> {
  int? _selectedIndex;
  bool _answered = false;

  void _playAudio() {
    TTSService().speak(widget.audioText, langCode: widget.language);
  }

  void _answer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
    });
    if (widget.options[index] == widget.correctAnswer) {
      widget.onCorrect();
    } else {
      widget.onWrong();
    }
  }

  @override
  Widget build(BuildContext context) {
    final shuffled = [...widget.options]..shuffle(Random());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              '🔊 सुनो और पहचानो / Listen and Match',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _playAudio,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 40),
              ),
            ),
            const Text('Tap to listen again', style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(shuffled.length, (i) {
                final isCorrect = _answered && shuffled[i] == widget.correctAnswer;
                final isWrong = _selectedIndex == i && !isCorrect;
                return GestureDetector(
                  onTap: () => _answer(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? AppTheme.success
                          : isWrong
                              ? AppTheme.error
                              : AppTheme.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCorrect
                            ? AppTheme.success
                            : isWrong
                                ? AppTheme.error
                                : AppTheme.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      shuffled[i],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isCorrect || isWrong ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}