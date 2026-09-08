import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class NewspaperReaderScreen extends StatelessWidget {
  const NewspaperReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('समाचार पत्र & किताबें'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _ArticleHeader(),
          const SizedBox(height: 12),
          const _Article(
            title: 'हमारा सोशल प्रोजेक्ट 🎉',
            category: 'Local News',
            paragraphs: [
              'हमारे गाँव में एक नया पुस्तकालय खुला है। इसमें बच्चों के लिए हिंदी और English दोनों भाषाओं की किताबें हैं।',
              'शिक्षक रमेश जी ने बताया कि हर शाम 4 बजे वहाँ मुफ्त पढ़ाई होगी। सभी बच्चों को पढ़ने का न्यौता है!',
              'बुधवार को पुस्तकालय का उद्घाटन समारोह होगा। आप सभी का स्वागत है।',
            ],
          ),
          const SizedBox(height: 12),
          const _Article(
            title: 'जंगल का नया दोस्त',
            category: 'Moral Fable',
            paragraphs: [
              'एक बार एक छोटी गिलहरी एक बड़े पेड़ पर रहती थी। उसने एक दिन एक अनजान चिड़िया को पेड़ पर देखा।',
              'चिड़िया भूखी थी। गिलहरी ने अपने संग्रहित फल उसके साथ बाँटे। दोनों में मित्रता हो गई।',
              'सीख: छोटे से छोटा प्राणी भी दूसरों की मदद कर सकता है। दयालुता ही सबसे बड़ा धर्म है।',
            ],
          ),
          const SizedBox(height: 12),
          _Article(
            title: 'The Rising Sun',
            category: 'English News',
            paragraphs: [
              'The sun rises in the east every morning. It gives us light and warmth all day long.',
              'Farmers wake up early to work in their fields under the golden sun. Birds sing sweet songs.',
              'The sun teaches us to rise early and work hard every single day.',
            ],
            isEnglish: true,
          ),
        ],
      ),
    );
  }
}

class _ArticleHeader extends StatelessWidget {
  const _ArticleHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📰 आज की ख़बरें',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'समाचार पढ़ो, सुनो और समझो!',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _Article extends StatelessWidget {
  final String title;
  final String category;
  final List<String> paragraphs;
  final bool isEnglish;

  const _Article({
    required this.title,
    required this.category,
    required this.paragraphs,
    this.isEnglish = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent = isEnglish
        ? AppTheme.moduleColors[1]
        : const Color(0xFFFF9800);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: accent,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SpeakerButton(
                  text: paragraphs.join(' '),
                  language: isEnglish ? 'en-US' : 'hi-IN',
                  size: 40,
                  color: accent,
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (final paragraph in paragraphs) ...[
              Text(
                paragraph,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}