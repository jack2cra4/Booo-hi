import 'package:flutter/material.dart';
import '../data/hindi_data.dart';
import '../models/lesson.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import '../widgets/module_card.dart';
import 'hindi/hindi_dashboard.dart';
import 'english/english_dashboard.dart';
import 'stories/storybook_library.dart';
import 'reading/whatsapp_reader.dart';
import 'reading/newspaper_reader.dart';
import 'math/math_dashboard.dart';
import 'programming/programming_dashboard.dart';
import 'profile/profile_screen.dart';
import 'quiz/quiz_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? _profile;
  int _welcomeIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    TTSService().init();
  }

  Future<void> _loadProfile() async {
    final profile = await ProgressService.getUserProfile();
    if (mounted) {
      setState(() => _profile = profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile ?? UserProfile();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, profile),
                const SizedBox(height: 16),
                Center(
                  child: InkWell(
                    onTap: () {
                      TTSService().speakHindi(
                        'पढ़ाई जारी रखें। पढ़ाई कभी मत रोको, राजा बनोगे चुपचाप!',
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '🚀 Resume Learning',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'अपनी पढ़ाई जारी रखें',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 48,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: profile.totalLessonsCompleted > 0
                                ? (profile.totalLessonsCompleted %
                                            10) /
                                        10.0 +
                                    0.5
                                : 0.1,
                            minHeight: 8,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '🔥 डेली स्ट्रीक: ${profile.dailyStreak} दिन | '
                            '⭐ कुल सितारे: ${profile.totalStars}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '📚 सीखने के मॉड्यूल',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.0,
                  children: [
                    ModuleCard(
                      title: 'हिंदी',
                      subtitle: 'वर्णमाला से वाक्य तक',
                      icon: Icons.translate,
                      color: AppTheme.moduleColors[0],
                      badge: '🇮🇳',
                      progress: 0.3,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HindiDashboard(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'English',
                      subtitle: 'Letters to Fluency',
                      icon: Icons.abc,
                      color: AppTheme.moduleColors[1],
                      badge: '🔤',
                      progress: 0.2,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EnglishDashboard(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'स्टोरी बुक्स',
                      subtitle: 'Interactive Stories',
                      icon: Icons.menu_book,
                      color: AppTheme.moduleColors[2],
                      badge: '📖',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StorybookLibrary(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'WhatsApp',
                      subtitle: 'Real Chat Reading',
                      icon: Icons.chat_bubble,
                      color: AppTheme.moduleColors[3],
                      badge: '💬',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WhatsAppReaderScreen(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'समाचार पत्र',
                      subtitle: 'News & Articles',
                      icon: Icons.newspaper,
                      color: AppTheme.moduleColors[4],
                      badge: '📰',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NewspaperReaderScreen(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'गणित',
                      subtitle: 'Counting & Tables',
                      icon: Icons.calculate,
                      color: AppTheme.moduleColors[5],
                      badge: '🔢',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MathDashboard(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'कोडिंग',
                      subtitle: 'Python · Java · C · C++',
                      icon: Icons.code,
                      color: Colors.teal,
                      badge: '💻',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgrammingDashboard(),
                          ),
                        );
                      },
                    ),
                    ModuleCard(
                      title: 'क्विज़',
                      subtitle: 'चुनौती / Challenge',
                      icon: Icons.quiz_rounded,
                      color: Colors.deepOrange,
                      badge: '🏆',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuizDashboard(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final index = _welcomeIndex % HindiData.avatars.length;
          _welcomeIndex++;
          TTSService().speakHindi(
            'नमस्ते ${profile.name}! मैं आपका शिक्षक दोस्त हूँ। आज भी मौज-मस्ती से पढ़ते हैं!',
          );
        },
        backgroundColor: AppTheme.primary,
        child: Text(
          HindiData.avatars[0],
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textSecondary,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'घर',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'कहानियाँ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_rounded),
            label: 'क्विज़',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'प्रोफ़ाइल',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StorybookLibrary()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizDashboard()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserProfile profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.categoryProgress.isNotEmpty
                    ? 'Welcome back! 👋'
                    : 'Namaste! 🙏',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'अक्षर से कोड तक का सफ़र',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Text(
                HindiData.avatars[
                    profile.avatarIndex % HindiData.avatars.length],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}