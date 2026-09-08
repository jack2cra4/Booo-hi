import 'package:flutter/material.dart';
import '../../data/stories_data.dart';
import '../../models/lesson.dart';
import '../../theme/app_theme.dart';
import '../../services/tts_service.dart';
import '../../widgets/speaker_button.dart';

class StorybookLibrary extends StatelessWidget {
  const StorybookLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final hindi = StoryData.hindiStories;
    final english = StoryData.englishStories;
    final math = StoryData.mathStory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('स्टोरीबुक लाइब्रेरी'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.moduleColors[2], const Color(0xFF8BC34A)],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionTitle(
            title: '🇮🇳 हिंदी कहानियाँ',
            color: AppTheme.moduleColors[0],
          ),
          ...hindi.map((story) => _StoryCard(story: story)),
          const SizedBox(height: 8),
          _SectionTitle(
            title: '🇬🇧 English Stories',
            color: AppTheme.moduleColors[1],
          ),
          ...english.map((story) => _StoryCard(story: story)),
          const SizedBox(height: 8),
          const _SectionTitle(
            title: '🔢 Math Storybook',
            color: AppTheme.warning,
          ),
          _StoryCard(story: math),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.menu_book, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Story story;

  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    final color = story.language == 'हिंदी'
        ? AppTheme.moduleColors[0]
        : story.language == 'English'
            ? AppTheme.moduleColors[1]
            : AppTheme.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StoryReaderScreen(story: story),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    story.language == 'हिंदी'
                        ? Icons.translate
                        : story.language == 'English'
                            ? Icons.language
                            : Icons.calculate,
                    color: color,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        story.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${story.language} • ${story.pages.length} pages',
                              style: TextStyle(
                                fontSize: 11,
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: color, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StoryReaderScreen extends StatefulWidget {
  final Story story;

  const StoryReaderScreen({super.key, required this.story});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _autoRead = false;
  int _highlightedWord = -1;

  String get _languageCode =>
      widget.story.language == 'हिंदी' ? 'hi-IN' : 'en-US';

  @override
  void initState() {
    super.initState();
    TTSService().setLanguage(_languageCode);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startKaraoke(String text) {
    final words = text.split(' ');
    setState(() => _autoRead = true);
    _runKaraokeLoop(words);
  }

  Future<void> _runKaraokeLoop(List<String> words) async {
    for (var i = 0; i < words.length; i++) {
      if (!_autoRead || !mounted) return;
      setState(() => _highlightedWord = i);
      for (final ch in words[i].runes) {
        if (!_autoRead || !mounted) return;
        await TTSService().speak(
          String.fromCharCode(ch),
          langCode: _languageCode,
        );
        await Future.delayed(const Duration(milliseconds: 250));
      }
    }
    if (mounted && _autoRead) {
      setState(() {
        _autoRead = false;
        _highlightedWord = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = widget.story.pages[_currentPage];
    final words = page.text.split(' ');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.story.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.speaker_notes),
            onPressed: () {
              if (_autoRead) {
                setState(() {
                  _autoRead = false;
                  _highlightedWord = -1;
                });
                TTSService().stop();
              } else {
                _startKaraoke(page.text);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _highlightedWord = -1;
                  _autoRead = false;
                });
                TTSService().stop();
              },
              itemCount: widget.story.pages.length,
              itemBuilder: (context, index) {
                final p = widget.story.pages[index];
                return _StoryPageView(
                  text: p.text,
                  words: p.text.split(' '),
                  highlightedWord: index == _currentPage ? _highlightedWord : -1,
                  languageCode: _languageCode,
                  pageNumber: index + 1,
                  totalPages: widget.story.pages.length,
                  onWordTap: (word) {
                    TTSService().speak(word, langCode: _languageCode);
                  },
                );
              },
            ),
          ),
          _buildControls(page),
        ],
      ),
    );
  }

  Widget _buildControls(StoryPage page) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: _currentPage > 0
                ? () {
                    TTSService().stop();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpeakerButton(
                    text: page.audioText,
                    language: _languageCode,
                    size: 48,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_currentPage + 1}/${widget.story.pages.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: _currentPage < widget.story.pages.length - 1
                ? () {
                    TTSService().stop();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class _StoryPageView extends StatelessWidget {
  final String text;
  final List<String> words;
  final int highlightedWord;
  final String languageCode;
  final int pageNumber;
  final int totalPages;
  final void Function(String) onWordTap;

  const _StoryPageView({
    required this.text,
    required this.words,
    required this.highlightedWord,
    required this.languageCode,
    required this.pageNumber,
    required this.totalPages,
    required this.onWordTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.moduleColors[pageNumber % 3]
                      .withOpacity(0.3),
                  AppTheme.background,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                '📖',
                style: TextStyle(fontSize: 72),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 6,
            runSpacing: 8,
            children: List.generate(words.length, (i) {
              final isHighlighted = i == highlightedWord;
              return GestureDetector(
                onTap: () => onWordTap(words[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? AppTheme.warning.withOpacity(0.4)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    words[i],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: isHighlighted
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            '👆 किसी भी शब्द पर दबाओ और सुनो / Tap any word to hear it',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}