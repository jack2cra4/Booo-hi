import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../data/english_data.dart';
import '../../models/lesson.dart';
import '../../services/progress_service.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/celebration_widgets.dart';
import '../../widgets/quiz_widgets.dart';

class QuizDashboard extends StatelessWidget {
  const QuizDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('क्विज़ / Quiz'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, AppTheme.secondary],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _QuizCategoryCard(
            title: '🔊 हिंदी: सुनो और सही अक्षर चुनो',
            subtitle: 'अक्षर पहचान',
            color: AppTheme.moduleColors[0],
            screenType: _QuizType.hindiLetterListening,
          ),
          const SizedBox(height: 12),
          const _QuizCategoryCard(
            title: '🎯 हिंदी: अक्षर से शब्द',
            subtitle: 'कौन सा शब्द इस अक्षर से शुरू होता है?',
            color: Color(0xFF00BCD4),
            screenType: _QuizType.hindiWordMatch,
          ),
          const SizedBox(height: 12),
          const _QuizCategoryCard(
            title: '🔤 English: सुनो और सही अक्षर',
            subtitle: 'Phonics Listening',
            color: AppTheme.moduleColors[1],
            screenType: _QuizType.englishLetterListening,
          ),
          const SizedBox(height: 12),
          const _QuizCategoryCard(
            title: '🐘 English: Animal Word Match',
            subtitle: 'शब्द और अर्थ जोड़ो',
            color: Colors.pink,
            screenType: _QuizType.englishWordMeaning,
          ),
        ],
      ),
    );
  }
}

enum _QuizType {
  hindiLetterListening,
  hindiWordMatch,
  englishLetterListening,
  englishWordMeaning,
}

class _QuizCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final _QuizType screenType;

  const _QuizCategoryCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.screenType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizScreen(type: screenType, color: color),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.quiz_rounded, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final _QuizType type;
  final Color color;

  const QuizScreen({
    super.key,
    required this.type,
    required this.color,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _correctCount = 0;
  List<List<String>> _questions = [];
  List<String> _audioTexts = [];
  List<List<String>> _allOptions = [];
  List<String> _correctAnswers = [];
  bool _quizComplete = false;
  int _starsEarned = 0;
  bool _celebrate = false;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    final rnd = Random();
    final allSwar = HindiData.swar.map((s) => s.character).toList();
    final allVyanjan = HindiData.vyanjan.map((s) => s.character).toList();

    switch (widget.type) {
      case _QuizType.hindiLetterListening:
        for (var i = 0; i < 10; i++) {
          final target = allSwar[rnd.nextInt(allSwar.length)];
          final options = _pickThree(target, [...allSwar, ...allVyanjan]);
          _questions.add(['हिंदी']);
          _audioTexts.add(target);
          _allOptions.add(options);
          _correctAnswers.add(target);
        }
        break;
      case _QuizType.hindiWordMatch:
        final allWords = [
          ...HindiData.twoLetterWords,
          ...HindiData.threeLetterWords,
          ...HindiData.fourLetterWords,
        ];
        for (var i = 0; i < 10; i++) {
          final target = allWords[rnd.nextInt(allWords.length)];
          final word = target.hindi;
          final startLetter = String.fromCharCode(word.runes.first);
          final options = _pickThree(word, allWords.map((w) => w.hindi).toList());
          _questions.add(['शब्द']);
          _audioTexts.add(startLetter);
          _allOptions.add(options);
          _correctAnswers.add(word);
        }
        break;
      case _QuizType.englishLetterListening:
        final allEnLetters = EnglishData.capitalLetters.map((l) => l.character).toList();
        for (var i = 0; i < 10; i++) {
          final idx = rnd.nextInt(EnglishData.capitalLetters.length);
          final letter = EnglishData.capitalLetters[idx];
          final audioWord = letter.word;
          final options = _pickThree(letter.character, allEnLetters);
          _questions.add(['English']);
          _audioTexts.add('$audioWord. The answer is the letter ${letter.character}');
          _allOptions.add(options);
          _correctAnswers.add(letter.character);
        }
        break;
      case _QuizType.englishWordMeaning:
        final allWords = [
          ...EnglishData.twoLetterWords,
          ...EnglishData.threeLetterWords,
          ...EnglishData.fourLetterWords,
        ];
        for (var i = 0; i < 10; i++) {
          final target = allWords[rnd.nextInt(allWords.length)];
          final meaning = target.meaning;
          final options = _pickThree(target.english, allWords.map((w) => w.english).toList());
          _questions.add(['English']);
          _audioTexts.add('Which word means $meaning?');
          _allOptions.add(options);
          _correctAnswers.add(target.english);
        }
        break;
    }
  }

  List<String> _pickThree(String correct, List<String> pool) {
    final rnd = Random();
    final options = <String>{correct};
    while (options.length < 4) {
      options.add(pool[rnd.nextInt(pool.length)]);
    }
    final list = options.toList()..shuffle();
    return list;
  }

  void _handleCorrect() {
    setState(() {
      _correctCount++;
      _starsEarned = _correctCount >= 8
          ? 3
          : _correctCount >= 5
              ? 2
              : 1;
    });
  }

  void _handleWrong() {
    // No-op to show feedback in UI
  }

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      _completeQuiz();
    }
  }

  Future<void> _completeQuiz() async {
    await ProgressService.recordLesson(
      'quiz_${widget.type.name}',
      stars: _starsEarned,
    );
    if (mounted) {
      setState(() {
        _quizComplete = true;
        _celebrate = true;
        TTSService().speakHindi(
          _correctCount >= 8
              ? 'वाह! बहुत बढ़िया! आपने $_correctCount सवाल सही किए!'
              : 'अच्छा प्रयास! $_correctCount सवाल सही। फिर से कोशिश करो!',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizComplete) {
      return ConfettiCelebration(
        active: _celebrate,
        child: Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            title: const Text('परिणाम / Result'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: AppTheme.star,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$_correctCount/${_questions.length} सही जवाब!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  StarRating(stars: _starsEarned, size: 44),
                  const SizedBox(height: 24),
                  Text(
                    _correctCount >= 8
                        ? '🎉 अद्भुत! आपने क्विज़ जीत लिया! 🎉'
                        : '💪 कोशिश जारी रखो - छोटे कदम, बड़ी जीत!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestion = 0;
                        _correctCount = 0;
                        _quizComplete = false;
                        _celebrate = false;
                        _generateQuestions();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.color,
                    ),
                    child: const Text('दोबारा खेलें / Play Again'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('घर वापस / Back to Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final question = _questions[_currentQuestion];
    final options = _allOptions[_currentQuestion];
    final audioText = _audioTexts[_currentQuestion];
    final correct = _correctAnswers[_currentQuestion];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('प्रश्न ${_currentQuestion + 1}/${_questions.length}'),
        backgroundColor: widget.color,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
              minHeight: 8,
              backgroundColor: Colors.white,
              color: AppTheme.success,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: AppTheme.star, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '$_correctCount ✓',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (widget.type == _QuizType.hindiLetterListening ||
                        widget.type == _QuizType.englishLetterListening)
                      ListeningQuiz(
                        options: options,
                        correctAnswer: correct,
                        audioText: audioText,
                        language: widget.type == _QuizType.hindiLetterListening
                            ? 'hi-IN'
                            : 'en-US',
                        onCorrect: _handleCorrect,
                        onWrong: _handleWrong,
                      )
                    else if (widget.type == _QuizType.hindiWordMatch)
                      ListeningQuiz(
                        options: options,
                        correctAnswer: correct,
                        audioText: audioText,
                        language: 'hi-IN',
                        onCorrect: _handleCorrect,
                        onWrong: _handleWrong,
                      )
                    else
                      ListeningQuiz(
                        options: options,
                        correctAnswer: correct,
                        audioText: audioText,
                        language: 'en-US',
                        onCorrect: _handleCorrect,
                        onWrong: _handleWrong,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _nextQuestion,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  _currentQuestion == _questions.length - 1
                      ? 'परिणाम देखो / See Result'
                      : 'अगला प्रश्न / Next',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}