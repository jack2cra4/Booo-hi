import 'package:flutter/material.dart';
import '../../data/hindi_data.dart';
import '../../models/lesson.dart';
import '../../services/progress_service.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? _profile;
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await ProgressService.getUserProfile();
    if (mounted) setState(() => _profile = profile);
  }

  Future<void> _updateProfile(UserProfile updated) async {
    await ProgressService.saveUserProfile(updated);
    if (mounted) setState(() => _profile = updated);
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile ?? UserProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('प्रोफ़ाइल'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: GestureDetector(
              onTap: () => _pickAvatar(profile),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white,
                  child: Text(
                    HindiData.avatars[
                        profile.avatarIndex % HindiData.avatars.length],
                    style: const TextStyle(fontSize: 52),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              '👆 अपना Avatar बदलने के लिए दबाएँ',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: _isEditingName
                ? _buildNameEditor(profile)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => setState(() => _isEditingName = true),
                        borderRadius: BorderRadius.circular(20),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatsItem(
                  icon: Icons.local_fire_department,
                  color: AppTheme.error,
                  value: '${profile.dailyStreak}',
                  label: 'दिन की स्ट्रीक',
                ),
                _StatsItem(
                  icon: Icons.star,
                  color: AppTheme.star,
                  value: '${profile.totalStars}',
                  label: 'सितारे',
                ),
                _StatsItem(
                  icon: Icons.check_circle,
                  color: AppTheme.success,
                  value: '${profile.totalLessonsCompleted}',
                  label: 'पाठ पूरे',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '🎓 मेरी प्रगति',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          _buildProgressCard(
            title: 'हिंदी',
            icon: Icons.translate,
            color: AppTheme.moduleColors[0],
            progress: profile.categoryProgress['hindi'] ?? 30,
          ),
          _buildProgressCard(
            title: 'English',
            icon: Icons.abc,
            color: AppTheme.moduleColors[1],
            progress: profile.categoryProgress['english'] ?? 20,
          ),
          _buildProgressCard(
            title: 'स्टोरी बुक्स',
            icon: Icons.menu_book,
            color: AppTheme.moduleColors[2],
            progress: profile.categoryProgress['stories'] ?? 60,
          ),
          _buildProgressCard(
            title: 'गणित',
            icon: Icons.calculate,
            color: AppTheme.moduleColors[5],
            progress: profile.categoryProgress['math'] ?? 40,
          ),
          _buildProgressCard(
            title: 'कोडिंग',
            icon: Icons.code,
            color: Colors.teal,
            progress: profile.categoryProgress['coding'] ?? 10,
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              final total = (profile.categoryProgress.values
                      .fold<int>(0, (a, b) => a + b)) %
                  100;
              TTSService().speakHindi(
                  'नमस्ते! मेरी प्रगति सुनाते हैं। मैंने कुल $total प्रतिशत पढ़ाई पूरी की है। शाबाश मुझे!');
            },
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF3776AB).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF3776AB)),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'मेरी प्रगति सुनो',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  const Icon(Icons.volume_up, color: Color(0xFF3776AB)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNameEditor(UserProfile profile) {
    final controller = TextEditingController(text: profile.name);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () async {
            final updated = UserProfile(
              name: controller.text.trim().isEmpty
                  ? profile.name
                  : controller.text.trim(),
              avatarIndex: profile.avatarIndex,
              dailyStreak: profile.dailyStreak,
              totalStars: profile.totalStars,
              totalLessonsCompleted: profile.totalLessonsCompleted,
              lastActiveDate: profile.lastActiveDate,
              categoryProgress: profile.categoryProgress,
            );
            await _updateProfile(updated);
            setState(() => _isEditingName = false);
          },
          icon: const Icon(Icons.check, color: AppTheme.success),
        ),
      ],
    );
  }

  void _pickAvatar(UserProfile profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'अपना Avatar चुनें',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: HindiData.avatars.asMap().entries.map((entry) {
                final isSelected = entry.key == profile.avatarIndex;
                return GestureDetector(
                  onTap: () async {
                    final updated = UserProfile(
                      name: profile.name,
                      avatarIndex: entry.key,
                      dailyStreak: profile.dailyStreak,
                      totalStars: profile.totalStars,
                      totalLessonsCompleted: profile.totalLessonsCompleted,
                      lastActiveDate: profile.lastActiveDate,
                      categoryProgress: profile.categoryProgress,
                    );
                    await _updateProfile(updated);
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primary.withOpacity(0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Text(entry.value, style: const TextStyle(fontSize: 32)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required IconData icon,
    required Color color,
    required int progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (progress % 100) / 100,
                    minHeight: 7,
                    backgroundColor: color.withOpacity(0.15),
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${progress % 100}%',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatsItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}